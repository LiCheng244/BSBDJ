//
//  BSPostsViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/1.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPostsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SVProgressHUD.h"
#import "BSPosts.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BSPostsCell.h"

@interface BSPostsViewController ()

/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *posts;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时的参数 */
@property (nonatomic, copy  ) NSString *maxtime;
/** 保存当前请求的参数 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation BSPostsViewController

static NSString *const BSPostCellID = @"postsCell";

-(NSMutableArray *)posts {
    
    if(!_posts) {
        _posts = [NSMutableArray array];
    }
    return _posts;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 刷新控件
    [self setUpRefresh];
    
    // 设置 tableView
    [self setUpTableView];
}


#pragma mark - <私有方法>
/**
 *  tableView
 */
- (void) setUpTableView{
    
    CGFloat top                          = BSTitlesViewH + BSTitlesViewY;
    CGFloat bottom                       = self.tabBarController.tabBar.bs_height;
    
    self.tableView.contentInset          = UIEdgeInsetsMake(top, 0, bottom, 0); // tableview 内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset; // 滚动条的内边距
    self.tableView.separatorStyle        = UITableViewCellSeparatorStyleNone; // 去掉分割线
    self.tableView.backgroundColor       = [UIColor clearColor];
    
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSPostsCell class]) bundle:nil] forCellReuseIdentifier:BSPostCellID];
}


#pragma mark - <初始化>
/**
 *  设置上拉刷新下拉加载控件
 */
- (void)setUpRefresh {
    
    // 上啦刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewPosts)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES; // 自动修改刷新控件的透明度
    [self.tableView.mj_header beginRefreshing]; // 进入界面自动刷新
    
    // 下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMorePosts)];
}


#pragma mark - <数据加载>
/**
 *  加载新的文字帖子
 */
- (void)loadNewPosts {
    
    // 结束上啦加载
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]                = @"list";
    params[@"c"]                = @"data";
    params[@"type"]             = @(self.type);
    self.params                 = params;
    
    [[AFHTTPSessionManager manager] GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 说明当前请求不是最后一个请求
        if (self.params != params) return ;
        
        
        // 存入 maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        self.posts = [BSPosts mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMorePosts{
    
    // 结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]                = @"list";
    params[@"c"]                = @"data";
    params[@"type"]             = @(self.type);
    params[@"page"]             = @(page);
    params[@"maxtime"]          = self.maxtime;
    self.params                 = params;
    
    [[AFHTTPSessionManager manager] GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return ;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        NSArray *newPosts = [BSPosts mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.posts addObjectsFromArray:newPosts];

        // 刷新表格
        [self.tableView reloadData];
        
        // 结束下拉刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return ;
        
        // 结束下拉刷新
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

#pragma mark - <代理方法>
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 有数据就 显示 footr
    self.tableView.mj_footer.hidden = (self.posts.count == 0);
    
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:BSPostCellID];
    cell.post = self.posts[indexPath.row];
    
    return cell;
}


#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 方式1: 自己计算 (该方式会多次调用,频繁的计算)
    
//    BSPosts *post = self.posts[indexPath.row];
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*BSPostsCellMargin, MAXFLOAT); // 文字的最大区域
//    CGFloat contentTextH = [post.text boundingRectWithSize:maxSize
//                                                   options:(NSStringDrawingUsesLineFragmentOrigin)
//                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
//                                                   context:nil].size.height; // 文字的高度
//    CGFloat cellH = BSPostsCellContentTextY + contentTextH + BSPostsCellBottomBarH + 2*BSPostsCellMargin ;
    
    
    // 方式2: 在模型中只计算一次高度就可以了
    BSPosts *post = self.posts[indexPath.row];

    return post.cellHeight;
}




@end
