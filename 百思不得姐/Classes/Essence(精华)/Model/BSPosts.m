//
//  BSPosts.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/1.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPosts.h"

@implementation BSPosts

/**
 *  设置创建时间的显示问题
 */
-(NSString *)create_time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *createTime = [formatter dateFromString:_create_time];
        
    if ([createTime isThisYear]) { // 今年
        
        if ([createTime isThisDay]) { // 今天
            
            NSDateComponents *comps = [[NSDate date] deltaFrom:createTime]; // 获取当前时间和创建时间相差的各个元素
            
            if (comps.hour >= 1) { // 至少一个小时
                
                return [NSString stringWithFormat:@"%ld小时前", comps.hour];
                
            }else if (comps.minute >= 1){ //  1分钟 < 创建时间 < 1小时
                
                return [NSString stringWithFormat:@"%ld分钟前", comps.minute];
                
            }else{ // 小于一分钟
                
                return @"刚刚";
            }
            
        }else if ([createTime isThisYesterday]) { // 昨天
            
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createTime];
            
        }else{ // 其他
            
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createTime];
        }
        
    }else { // 非今年
        
        return _create_time;
    }

}
@end
