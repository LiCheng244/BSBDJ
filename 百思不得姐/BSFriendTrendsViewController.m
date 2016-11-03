//
//  BSFriendTrendsViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSFriendTrendsViewController.h"

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
    
    self.view.backgroundColor = [UIColor brownColor];

}

- (void)friendsClick {
    BSLogFunc;
}

@end
