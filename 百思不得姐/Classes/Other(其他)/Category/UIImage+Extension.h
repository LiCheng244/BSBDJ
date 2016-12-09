//
//  UIImage+Extension.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/8.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  裁剪图片
 *
 *  @rect 裁剪的位置
 *  @image 要裁剪的图片
 *  
 *  @return 新的 image
 */
+ (UIImage *)imageWithCutRect:(CGRect)rect cutImage:(UIImage *)image;

@end
