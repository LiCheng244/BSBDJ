//
//  BSRecommendViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/4.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

#import "BSRecommendCategoryCell.h"
#import "BSRecommendCategory.h"
#import "BSRecommendUsersCell.h"
#import "BSRecommendUser.h"


@interface BSRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左侧的类别数据 */
@property (nonatomic, strong) NSArray *categorys;
/** 左侧的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;


@end

@implementation BSRecommendViewController

/** 左侧cell标识符 */
static NSString *const BSCategoryID = @"category";
/** 右侧cell标识符 */
static NSString *const BSUsersID = @"users";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本信息
    self.title = @"推荐关注";
    self.view.backgroundColor = BSGlobalColor;
    
    // 注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:BSCategoryID];
    [self.usersTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendUsersCell class]) bundle:nil] forCellReuseIdentifier:BSUsersID];

    // 设置高度
    self.usersTableView.rowHeight = 70;
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO; // 告诉view 不自适应
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.usersTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);

    
    // 添加指示器
    [SVProgressHUD show];
    
    // 请求数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"c"] = @"subscribe";
    parameters[@"a"] = @"category";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏信息
        [SVProgressHUD dismiss];
        
        // 返回的json数据
        self.categorys = [BSRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //  刷新表格
        [self.categoryTableView reloadData];
        
        // 设置默认选择首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示加载失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    } else {
        // 获取选中的数据模型
        BSRecommendCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        return category.users.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        BSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:BSCategoryID];
        cell.category = self.categorys[indexPath.row];
        return cell;
    } else {
        BSRecommendUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:BSUsersID];
        // 选中的行号
        NSInteger selectIndex = self.categoryTableView.indexPathForSelectedRow.row;
        // 获取选中的数据模型
        BSRecommendCategory *category = self.categorys[selectIndex];
        
        cell.user = category.users[indexPath.row];
        return cell;
    }
}
#pragma mark - <UITableViewDataSource>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSRecommendCategory *category = self.categorys[indexPath.row];
    
    //请求数据
    if (category.users.count) {
        
        [self.usersTableView reloadData];
        
    } else {
        // 请求数据
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"c"] = @"subscribe";
        parameters[@"a"] = @"list";
        parameters[@"category_id"] = @(category.id);
        
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 返回的json数据
            NSArray *users = [BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            // 将用户数据 添加到当前类别对应的用户数组中
            NSLog(@"%@", users);
            [category.users addObjectsFromArray:users];
            
            NSLog(@"%@", category.users);
            [self.usersTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 显示加载失败信息
            [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        }];
    }
}

@end
