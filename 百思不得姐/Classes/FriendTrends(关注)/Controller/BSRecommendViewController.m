//
//  BSRecommendViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/4.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

#import "BSRecommendCategoryCell.h"
#import "BSRecommendCategory.h"
#import "BSRecommendUsersCell.h"
#import "BSRecommendUser.h"

/** 当前选择的类别 */
#define BSSelectedCategory self.categorys[self.categoryTableView.indexPathForSelectedRow.row]


@interface BSRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 左侧的分类表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *usersTableView;

/** 左侧的分类数据 */
@property (nonatomic, strong) NSArray *categorys;
/** 保存用户数据请求的参数 */
@property (nonatomic, strong) NSMutableDictionary *params;
/** AFN的请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BSRecommendViewController

/** 左侧cell标识符 */
static NSString * const BSCategoryID = @"category";
/** 右侧cell标识符 */
static NSString * const BSUsersID = @"users";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加指示器
    [SVProgressHUD show];
   
    // 设置tableView
    [self setUpTableView];

    // 添加刷新加载控件
    [self setUpRefresh];
    
    // 加载分类数据
    [self loadCategorys];
}

#pragma mark - <私有方法>
/**
 *  懒加载AFN请求管理者
 */
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
/**
 *  设置tableview
 */
- (void)setUpTableView {
    
    // 设置基本信息
    self.title                          = @"推荐关注";
    self.view.backgroundColor           = BSGlobalColor;
    self.usersTableView.backgroundColor = BSGlobalColor;
    self.usersTableView.rowHeight       = 70;

    // 注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategoryCell class]) bundle:nil]
                 forCellReuseIdentifier:BSCategoryID];
    [self.usersTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendUsersCell class]) bundle:nil]
              forCellReuseIdentifier:BSUsersID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO; // 告诉view 不自适应
    self.categoryTableView.contentInset       = UIEdgeInsetsMake(64, 0, 0, 0);
    self.usersTableView.contentInset          = UIEdgeInsetsMake(64, 0, 0, 0);
}

/**
 *  添加刷新控件
 */
- (void)setUpRefresh {
    
    // 下拉加载控件
    self.usersTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(loadNewUsers)];
    
    // 上啦刷新控件
    self.usersTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreUsers)];
}

/**
 *  检测footr的状态
 */
- (void)checkFooterState {
    
    BSRecommendCategory *category = BSSelectedCategory;
    
    // 根据是否有数据来显示或隐藏上啦刷新控件  当没有数据时不显示footr, 有数据时才显示footr
    self.usersTableView.mj_footer.hidden = (category.users.count == 0 ? YES : NO);

    // 判断数据是否全部加载完毕
    if (category.total == category.users.count) { // 全部加载完毕
        [self.usersTableView.mj_footer endRefreshingWithNoMoreData];
        
    } else {
        // 底部控件结束刷新
        [self.usersTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <网络请求>
/**
 *  加载分类数据
 */
- (void)loadCategorys {
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"]                = @"subscribe";
    params[@"a"]                = @"category";
    
    [self.manager GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏信息
        [SVProgressHUD dismiss];
        
        // 返回的json数据
        self.categorys = [BSRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //  刷新表格
        [self.categoryTableView reloadData];
        
        // 设置默认选择首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        
        // 加载用户数据
        [self.usersTableView.mj_header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示加载失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
}

/**
 *  加载最新数据
 */
- (void)loadNewUsers {
    
    BSRecommendCategory *category = BSSelectedCategory;
    
    // 设置当前页码
    category.currentPage = 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"]                = @"subscribe";
    params[@"a"]                = @"list";
    params[@"category_id"]      = @(category.ID);
    params[@"page"]             = @(category.currentPage);
    self.params                 = params;
    
    
    [self.manager GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 返回的json数据
        NSArray *users = [BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清空旧数据
        [category.users removeAllObjects];
        
        // 将新的用户数据 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        category.total = [responseObject[@"total"] integerValue];
        
        
        // 如果是最后一次请求再刷新表格
        if (self.params != params) return;
        
        [self.usersTableView reloadData];
        
        // 结束刷新
        [self.usersTableView.mj_header endRefreshing];
        
        // 检测上啦加载控件的状态
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        // 避免多次不同请求(总是请求最后一次的)
        if (self.params != params) return;

        // 显示加载失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        
        // 结束刷新
        [self.usersTableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMoreUsers {
    
    // 当前类别
    BSRecommendCategory *category = BSSelectedCategory;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"]                = @"subscribe";
    params[@"a"]                = @"list";
    params[@"category_id"]      = @(category.ID);
    params[@"page"]             = @(++category.currentPage);
    self.params                 = params;
    
    [self.manager GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 返回的json数据
        NSArray *users = [BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 将用户数据 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
    
        // 如果是最后一次请求再刷新表格
        if (self.params != params) return;
        
        [self.usersTableView reloadData];
        
        // 检测上啦加载控件的状态
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 避免多次不同请求(总是请求最后一次的)
        if (self.params != params) return;

        // 显示加载失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        
        // 底部控件结束刷新
        [self.usersTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) { // 左边表格
        return self.categorys.count;
        
    } else { // 右边表格
        
        // 检测footer的状态
        [self checkFooterState];
        
        return [BSSelectedCategory users].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        
        BSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:BSCategoryID];
        cell.category = self.categorys[indexPath.row];
        return cell;
        
    } else {
        
        BSRecommendUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:BSUsersID];
        cell.user = [BSSelectedCategory users][indexPath.row];
        return cell;
    }
}


#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.categoryTableView) {
        
        // 结束上次的刷新和加载
        [self.usersTableView.mj_header endRefreshing];
        [self.usersTableView.mj_footer endRefreshing];
        
        BSRecommendCategory *category = BSSelectedCategory;

        // 判断是否加载过数据
        if (category.users.count) { // 说明该数据已经请求过, 不需要再次请求, 直接取数据就可以了
            
            [self.usersTableView reloadData];
            
        } else { // 没有加载过, 请求数据
            
            // 刷新表格: 防止网络过慢数据加载不出来时, 会显示上一个category的残留数据
            [self.usersTableView reloadData];
            
            // 开始上啦加载
            [self.usersTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - <控制器的销毁>
- (void)dealloc {
    
    // 停止所有的请求
    [self.manager.operationQueue cancelAllOperations];
}


@end
