//
//  UIView+BSFrame.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSFrame)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;

/**
 *  在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现 和 带有下划线的成员变量
 */


@end
