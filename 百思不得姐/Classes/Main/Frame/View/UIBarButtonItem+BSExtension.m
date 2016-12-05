//
//  UIBarButtonItem+BSExtension.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/2.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "UIBarButtonItem+BSExtension.h"

@implementation UIBarButtonItem (BSExtension)


+ (instancetype) itemWithImage:(NSString *)image
                     highImage:(NSString *)highImage
                        target:(id)target
                        action:(SEL)action
{
    // 设置导航栏左按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:image]
                      forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImage]
                      forState:(UIControlStateHighlighted)];

    [button addTarget:target
               action:action
     forControlEvents:(UIControlEventTouchUpInside)];

    button.bs_size  = button.currentBackgroundImage.size;

    return [[self alloc] initWithCustomView:button];
    /**
     *  使用 initWithCustomView 设置导航栏左按钮为自定义视图
        tarage: 明确 调用哪个对象
     */
}
@end
