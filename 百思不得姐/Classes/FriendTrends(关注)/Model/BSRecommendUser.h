//
//  BSRecommendUser.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 关注数 */
@property (nonatomic, assign) NSInteger fans_count;;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
