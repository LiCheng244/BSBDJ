//
//  BSFriendTrendsViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSFriendTrendsViewController.h"
#import "BSRecommendViewController.h"
#import "AFNetworking.h"

#import "BSLoginRegisterViewController.h"

@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
}

#pragma mark - <私有方法>
/**
 *  设置导航栏
 */
- (void)setUpNav {
    
    // 标题
    self.navigationItem.title = @"我的关注";
    /**
     *  当使用 self.title 时, 是将 tabBarItem 和 naviationItem 的title 一起设置了
     *  如果要设置不同的title, 要分开设置
     */
    
    // 设置导航栏左按钮
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon"
                                                                  highImage:@"friendsRecommentIcon-click"
                                                                     target:self
                                                                     action:@selector(friendsClick)];
    
    // 设置背景颜色
    self.view.backgroundColor = BSGlobalColor;
}

#pragma mark - <点击方法>
/**
 *  登陆按钮
 */
- (IBAction)loginClick:(id)sender {
    
    BSLoginRegisterViewController *loginVC = [[BSLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
}

/**
 *  朋友按钮
 */
- (void)friendsClick {
    
    BSRecommendViewController *recommendVC = [[BSRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
    
}

@end
