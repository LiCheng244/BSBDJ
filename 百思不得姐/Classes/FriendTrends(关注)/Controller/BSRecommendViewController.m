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
#import "BSRecommendCategoryCell.h"
#import "MJExtension.h"
#import "BSRecommendCategory.h"

@interface BSRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *categorys;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation BSRecommendViewController

static NSString *const BSCategoryID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本信息
    self.title = @"推荐关注";
    self.view.backgroundColor = BSGlobalColor;
    
    // 注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:BSCategoryID];
    
    
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
    return self.categorys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:BSCategoryID];
    cell.category = self.categorys[indexPath.row];
    return cell;
}
@end
