//
//  NSDate+Extension.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


/**
 *  比较 self 和 from 时间的差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否是今年
 */
-(BOOL)isThisYear;

/**
 *  是否是今天
 */
-(BOOL)isThisDay;

/**
 *  是否是昨天
 */
-(BOOL)isThisYesterday;


@end
