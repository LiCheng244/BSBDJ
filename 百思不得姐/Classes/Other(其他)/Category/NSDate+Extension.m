//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (NSDateComponents *)deltaFrom:(NSDate *)from {
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

/**
 *  是否是今年
 */
-(BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComps = [calendar components:unit fromDate:self]; // self 指的是调用当前方法的时间对象
    
    return nowComps.year == selfComps.year;
}

/**
 *  是否是今天
 */
-(BOOL)isThisDay{
    
    // 方法1
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComps = [calendar components:unit fromDate:self]; // self 指的是调用当前方法的时间对象
    
    return nowComps.year == selfComps.year && nowComps.month == selfComps.month && nowComps.day == selfComps.day;
    
    // 方法2
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    
//    NSString *nowString = [formatter stringFromDate:[NSDate date]];
//    NSString *selfString = [formatter stringFromDate:self];
//    
//    return nowString == selfString;
}

/**
 *  是否是昨天
 */
-(BOOL)isThisYesterday{
    
    /**
     *  有这种情况:  (先忽略时分秒的比较， 只比较年月日的差值)
            2015-12-31 23:58:58
            2016-01-01 01:09:10
     */
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear  fromDate:selfDate toDate:nowDate options:0];

    return (comps.year == 0 && comps.month == 0 && comps.day == 1);
}

@end
