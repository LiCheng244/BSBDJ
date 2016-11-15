//
//  BSRecommendCategory.h
//  百思不得姐
//
//  Created by LiCheng on 2016/11/4.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;


/** 存储当前类别中的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

/** 总数 */
@property (nonatomic, assign) NSInteger total;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end
