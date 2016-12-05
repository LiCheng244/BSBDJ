//
//  BSPosts.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/1.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPosts : NSObject

/** 名称 */
@property (nonatomic, copy)  NSString *name;

/** 头像 */
@property (nonatomic, copy)  NSString *profile_image;

/** 时间 */
@property (nonatomic, copy) NSString *create_time;

/** 内容 */
@property (nonatomic, copy)  NSString *text;

/** 顶 */
@property (nonatomic, assign)  NSInteger ding;

/** 踩 */
@property (nonatomic, assign) NSInteger cai;

/** 转发数量 */
@property (nonatomic, assign)  NSInteger repost;

/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 新浪登陆加 V */
@property (nonatomic, assign, getter=isSina_v) BOOL *sina_v;


@end
