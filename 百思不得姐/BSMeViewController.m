//
//  BSMeViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSMeViewController.h"

@interface BSMeViewController ()

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我";
    
    // 设置导航栏按钮
    UIBarButtonItem *nightModeBtn = [UIBarButtonItem itemWithImage:@"mine-moon-icon"
                                                         highImage:@"mine-moon-icon-click"
                                                            target:self
                                                            action:@selector(nightModeClick)];
    
    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:@"mine-setting-icon"
                                                       highImage:@"mine-setting-icon-click"
                                                          target:self
                                                          action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingBtn, nightModeBtn];
    /**
     *  右按钮添加: 从右开始添加
     *  左按钮添加: 从左开始添加
     */
}

- (void)nightModeClick {
    BSLogFunc;
}

- (void)settingClick {
    BSLogFunc;
}

@end
