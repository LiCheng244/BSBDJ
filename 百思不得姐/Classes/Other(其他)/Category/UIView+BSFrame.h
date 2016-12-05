//
//  UIView+BSFrame.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BSFrame)

@property (nonatomic, assign)CGFloat bs_x;
@property (nonatomic, assign)CGFloat bs_y;
@property (nonatomic, assign)CGFloat bs_width;
@property (nonatomic, assign)CGFloat bs_height;
@property (nonatomic, assign)CGSize  bs_size;


@property (nonatomic, assign)CGFloat bs_centerX;
@property (nonatomic, assign)CGFloat bs_centerY;

/**
 *  在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现 和 带有下划线的成员变量
 */


@end
