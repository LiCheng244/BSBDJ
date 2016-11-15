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
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    /**
     *  当使用 self.title 时, 是将 tabBarItem 和 naviationItem 的title 一起设置了
     *  如果要设置不同的title, 要分开设置
     */
    
    
    // 设置导航栏左按钮
    UIBarButtonItem *friendsBtn = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon"
                                                       highImage:@"friendsRecommentIcon-click"
                                                          target:self
                                                          action:@selector(friendsClick)];
    self.navigationItem.leftBarButtonItem = friendsBtn;
    
    // 设置背景颜色
    self.view.backgroundColor = BSGlobalColor;
}


- (IBAction)loginClick:(id)sender {
    
    BSLoginRegisterViewController *loginVC = [[BSLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)friendsClick {
    BSLogFunc;
    BSRecommendViewController *recommendVC = [[BSRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recommendVC animated:YES];
    
}

@end
