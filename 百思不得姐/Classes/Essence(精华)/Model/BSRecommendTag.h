//
//  BSRecommendTag.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/14.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendTag : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名称 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅量 */
@property (nonatomic, assign) NSInteger sub_number;
@end
