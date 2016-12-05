//
//  BSPostsViewController.h
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BSPostsTypeAll = 1,
    BSPostsTypePicture = 10,
    BSPostsTypeWord = 29,
    BSPostsTypeVoice = 31,
    BSPostsTypeVideo = 41
} BSPostsType;

@interface BSPostsViewController : UITableViewController

/** 帖子类型（枚举值） */
@property (nonatomic, assign)  BSPostsType type;

@end
