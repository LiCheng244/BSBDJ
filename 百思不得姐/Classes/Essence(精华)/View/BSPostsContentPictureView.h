//
//  BSPostsContentPictureView.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//
//  图片帖子 内容视图
//

#import <UIKit/UIKit.h>
@class BSPosts;
@interface BSPostsContentPictureView : UIView

/** 模型 */
@property (nonatomic, strong)  BSPosts *post;


/** 初始化 view */
+ (instancetype)postsContentPictureView;
@end
