//
//  BSRecommendCategory.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/4.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

/**
 *  推荐关注  左边数据模型
 */

#import "BSRecommendCategory.h"
#import <MJExtension/MJExtension.h>
@implementation BSRecommendCategory

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id"
             };
}

/**
 *  懒加载用户数组
 */
-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
