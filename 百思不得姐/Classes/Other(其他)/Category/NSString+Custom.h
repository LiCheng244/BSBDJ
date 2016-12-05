//
//  NSString+Custom.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Custom)


/**
 *  将大于10000的数字转换成“1.0万”的格式
 *
 *  @param number  数字
 *  @param placeholer 当 number=0 时的占位文字
 *
 *  @return 转换后的字符串
 */
+(NSString *)changeNumberIntoString:(NSInteger)number
                         placeholer:(NSString *)placeholer;


@end
