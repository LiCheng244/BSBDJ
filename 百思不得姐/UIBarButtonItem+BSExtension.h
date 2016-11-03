//
//  UIBarButtonItem+BSExtension.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/2.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSExtension)


/**
 *  创建导航栏按钮 BarButtonItem
 *
 *  @param image     图片名称
 *  @param highImage 选中图片名称
 *  @param target    调用该对象的方法
 *  @param action    点击事件
 *
 *  @return UIBarButtonItem
 */
+ (instancetype) itemWithImage:(NSString *)image
                     highImage:(NSString *)highImage
                        target:(id)target
                        action:(SEL)action;
@end
