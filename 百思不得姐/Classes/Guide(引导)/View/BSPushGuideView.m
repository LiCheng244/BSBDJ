//
//  BSPushGuideView.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/15.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPushGuideView.h"

@implementation BSPushGuideView


+(void)show {
    
    // 获取当前版本号
    NSString *versionKey = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    // 获取沙盒中存储的上一个版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:versionKey];
    
    if (![currentVersion isEqualToString:sanboxVersion]) { // 版本更新了
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // 添加推送指南 (第一次打开app时/app更新后, 显示)
        BSPushGuideView *guideView = [BSPushGuideView pushGuideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 储存新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize]; // 立即保存
    }
}

/**
 *  关闭 推送指南
 */
- (IBAction)closeClick {
    
    [self removeFromSuperview];
}

/**
 *  添加推送指南
 */
+(instancetype)pushGuideView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}



@end
