//
//  BSComment.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/13.
//  Copyright © 2016年 LiCheng. All rights reserved.
//
//  帖子的评论信息
//

#import <Foundation/Foundation.h>
@class BSUser;

@interface BSComment : NSObject
/** 音频评论时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 文字评论内容 */
@property (nonatomic, copy  ) NSString *content;
/** 评论的点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户信息 */
@property (nonatomic, strong) BSUser *user;
@end
