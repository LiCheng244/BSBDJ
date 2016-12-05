//
//  BSLoginRegisterViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/14.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSLoginRegisterViewController.h"

@interface BSLoginRegisterViewController ()

/** 登录框距离控制器view左边的间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation BSLoginRegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

/**
 *  登录注册切换按钮
 */
- (IBAction)showLoginRegisterClick:(UIButton *)button {
    
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 正在显示登录, 需要切换到注册
        
        self.loginViewLeftMargin.constant = -self.view.bs_width;
        [button setTitle:@"已有账号?" forState:(UIControlStateNormal)];
        
    }else{ // 正在显示注册界面, 需要切换到登录
        
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:(UIControlStateNormal)];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
       
        // 需要重新布局时, 刷新布局
        [self.view layoutIfNeeded];
    }];
    
}

/**
 *  设置当前控制器的状态栏 为 白色
 */
-(UIStatusBarStyle)preferredStatusBarStyle {
    // 白色
    return UIStatusBarStyleLightContent;
}


/**
 *  返回按钮
 */
- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  登录
 */
- (IBAction)loginClick:(id)sender {
    
}


/**
 *  忘记密码
 */
- (IBAction)forgetPwdClick:(id)sender {
}


@end
