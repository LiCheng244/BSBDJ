//
//  BSRecommendTagsViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/14.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendTagsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

#import "BSRecommendTag.h"
#import "BSRecommendTagCell.h"


@interface BSRecommendTagsViewController ()

/** 数组模型 */
@property (nonatomic, strong) NSArray *tags;
@end

@implementation BSRecommendTagsViewController


/** 左侧cell标识符 */
static NSString * const BSTagID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 菊花转
    [SVProgressHUD show];
    
    // 设置tableView
    [self setUpTableView];
    
    // 加载数据
    [self loadTags];
    
}

#pragma mark - <私有方法>
/**
 *  设置tableView
 */
- (void)setUpTableView {
    
    self.navigationItem.title     = @"推荐标签";
    self.view.backgroundColor     = BSGlobalColor;
    self.tableView.rowHeight      = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendTagCell class]) bundle:nil]
         forCellReuseIdentifier:BSTagID];
}

#pragma mark - <网络请求>
/**
 *  请求订阅的信息
 */
- (void)loadTags {
    
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]                = @"tag_recommend";
    params[@"c"]                = @"topic";
    params[@"action"]           = @"sub";
    
    // 请求
    [[AFHTTPSessionManager manager] GET:BSBaseAPI parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [BSRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}


#pragma mark - <代理>
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:BSTagID];
    cell.recommendTag        = self.tags[indexPath.row];
    return cell;
}
@end
