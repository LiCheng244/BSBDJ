//
//  NSString+Custom.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "NSString+Custom.h"

@implementation NSString (Custom)


+(NSString *)changeNumberIntoString:(NSInteger)number placeholer:(NSString *)placeholer{
    
    if (number == 0) {
        return placeholer;
    }else if (number >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", number/1000.0];
    }else{
        return[NSString stringWithFormat:@"%ld", number];
    }
}
@end
