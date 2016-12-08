//
//  BSPosts.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/1.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPosts : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 时间 */
@property (nonatomic, copy) NSString *create_time;

/** 内容 */
@property (nonatomic, copy) NSString *text;

/** 顶 */
@property (nonatomic, assign)  NSInteger ding;

/** 踩 */
@property (nonatomic, assign) NSInteger cai;

/** 转发数量 */
@property (nonatomic, assign)  NSInteger repost;

/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 新浪登陆加 V */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片（小） URL */
@property (nonatomic, copy) NSString *small_image;
/** 图片（中） URL */
@property (nonatomic, copy) NSString *middle_image;
/** 图片（大） URL */
@property (nonatomic, copy) NSString *large_image;

/** 内容图片的高度 */
@property (nonatomic, assign) CGFloat width;

/** 内容图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 帖子的类型 */
@property (nonatomic, assign) BSPostsType type;



#pragma mark - <辅助的属性>
/**  cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 帖子图片的 frame */
@property (nonatomic, assign, readonly) CGRect contentPictureFrame;
/** 图片是否过长 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片加载的进度条 */
@property (nonatomic, assign) CGFloat pictureProgress;

@end
