//
//  BSPosts.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/1.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPosts.h"
#import <MJExtension/MJExtension.h>
#import "BSComment.h"
#import "BSUser.h"

@interface BSPosts ()

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect contentPictureFrame;
@property (nonatomic, assign) CGRect contentVoiceFrame;
@property (nonatomic, assign) CGRect contentVideoFrame;



@end

@implementation BSPosts

/**
 *  属性名对应的 key 值
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2"
             };
}


/**
 *  指定数组中存放的元素模型
 */
+(NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt":[BSComment class]};
}


/**
 *  计算 cell 的高度
 */
-(CGFloat)cellHeight {
    
    if (!_cellHeight) { // 当 cell 的高度没有时才计算，保证每个 cell 只计算一次
        
        // 文字的最大区域
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*BSPostsCellMargin, MAXFLOAT);
        // 文字的高度
        CGFloat contentTextH = [self.text boundingRectWithSize:maxSize
                                                       options:(NSStringDrawingUsesLineFragmentOrigin)
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                       context:nil].size.height;
        
        // cell的基本高度 (文字的Y + 间距 + 文字的高度 + 间距 + 底部的工具条高度)
        _cellHeight = BSPostsCellContentTextY + BSPostsCellMargin + contentTextH + BSPostsCellMargin + BSPostsCellBottomBarH;
        
        if (self.type == BSPostsTypePicture) { // 图片帖子内容
            
            // 图片等比例填充
            CGFloat pictureW = maxSize.width; // 屏幕填充
            CGFloat pictureH = self.height * pictureW / self.width; // 等比例高度
            CGFloat pictureX = BSPostsCellMargin;
            CGFloat pictureY = BSPostsCellContentTextY + contentTextH + BSPostsCellMargin;
            // 设置图片的最大高度
            if (pictureH > BSPostsCellContentPictureMaxH) {
                pictureH = BSPostsCellContentPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            // 图片内容视图的 frame
            self.contentPictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            
            // 图片帖子 cell 的高度
            _cellHeight = _cellHeight +  pictureH + BSPostsCellMargin;
            
        }else if (self.type == BSPostsTypeVoice) { // 声音帖子
            // frame
            CGFloat voiceX = BSPostsCellMargin;
            CGFloat voiceY = BSPostsCellContentTextY + contentTextH + BSPostsCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = self.height * voiceW / self.width;
            self.contentVoiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            // cell 高度
            _cellHeight = _cellHeight + voiceH + BSPostsCellMargin;
            
        }else if (self.type == BSPostsTypeVideo) { // 视频帖子
            // frame
            CGFloat videoX = BSPostsCellMargin;
            CGFloat videoY = BSPostsCellContentTextY + contentTextH + BSPostsCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = self.height * videoW / self.width;
            self.contentVideoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            // cell高度
            _cellHeight = _cellHeight + videoH + BSPostsCellMargin;
        }
        
        // 热门评论的 高度
        BSComment *comment = [self.top_cmt firstObject];
        if (comment) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", comment.content, comment.user.username];
            CGFloat commentH = [content boundingRectWithSize:maxSize
                                                     options:(NSStringDrawingUsesLineFragmentOrigin)
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                                     context:nil].size.height;
            CGFloat commentViewH = 17 + commentH;
            _cellHeight = _cellHeight + commentViewH + BSPostsCellMargin;
        }
    }
    return _cellHeight;
}


/**
 *  设置创建时间的显示问题
 */
-(NSString *)create_time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime         = [formatter dateFromString:_create_time];
    
    if ([createTime isThisYear]) { // 今年
        
        if ([createTime isThisDay]) { // 今天
            NSDateComponents *comps = [[NSDate date] deltaFrom:createTime]; // 获取当前时间和创建时间相差的各个元素
            
            if (comps.hour >= 1) { // 至少一个小时
                return [NSString stringWithFormat:@"%ld小时前", comps.hour];
                
            }else if (comps.minute >= 1){ //  1分钟 < 创建时间 < 1小时
                return [NSString stringWithFormat:@"%ld分钟前", comps.minute];
                
            }else{ // 小于一分钟
                return @"刚刚";
            }
            
        }else if ([createTime isThisYesterday]) { // 昨天
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createTime];
            
        }else{ // 其他
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createTime];
        }
        
    }else { // 非今年
        return _create_time;
    }

}
@end
