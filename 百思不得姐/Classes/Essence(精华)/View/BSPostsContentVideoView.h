//
//  BSPostsContentVideoView.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/13.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSPosts;

@interface BSPostsContentVideoView : UIView

/** 模型 */
@property (nonatomic, strong) BSPosts *post;

+(instancetype)postContentVideoView;
@end
