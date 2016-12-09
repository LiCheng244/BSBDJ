//
//  UIImage+Extension.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/8.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithCutRect:(CGRect)rect cutImage:(UIImage *)image{
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    
    // 将下载的图片对象绘制到图形上下文
    [image drawInRect:rect];
    
    // 获得图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();

    
    return image;
}

@end
