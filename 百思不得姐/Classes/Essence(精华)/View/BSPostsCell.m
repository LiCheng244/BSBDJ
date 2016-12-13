//
//  BSPostsCell.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/5.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPostsCell.h"
#import "BSPosts.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BSPostsContentPictureView.h"
#import "BSPostsContentVoiceView.h"
#import "BSPostsContentVideoView.h"
#import "BSComment.h"
#import "BSUser.h"

@interface BSPostsCell ()
/** 热门评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *postCommentL;
/** 热门评论 view */
@property (weak, nonatomic) IBOutlet UIView *commentView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 新浪+V */
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
/** 关注 */
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
/** 点赞 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 点踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/** 图片帖子的内容视图 */
@property (nonatomic, weak) BSPostsContentPictureView *contentPictureView;
/** 声音帖子的内容视图 */
@property (nonatomic, weak) BSPostsContentVoiceView *contentVoiceView;
/** 声音帖子的内容视图 */
@property (nonatomic, weak) BSPostsContentVideoView *contentVideoView;
@end

@implementation BSPostsCell

/**
 *  懒加载 图片帖子的内容 (保证只创建一次)
 */
-(BSPostsContentPictureView *)contentPictureView {

    if(!_contentPictureView) {
        BSPostsContentPictureView *contentPictureView = [BSPostsContentPictureView postsContentPictureView];
        [self.contentView addSubview:contentPictureView];
        _contentPictureView = contentPictureView;
    }
    return _contentPictureView;
}
/**
 *  懒加载 声音帖子的内容 (保证只创建一次)
 */
-(BSPostsContentVoiceView *)contentVoiceView{
    
    if(!_contentVoiceView) {
        BSPostsContentVoiceView *contentVoiceView = [BSPostsContentVoiceView postsContentVoiceView];
        [self.contentView addSubview:contentVoiceView];
        _contentVoiceView = contentVoiceView;
    }
    return _contentVoiceView;
}/**
  *  懒加载 声音帖子的内容 (保证只创建一次)
  */
-(BSPostsContentVideoView *)contentVideoView{
    if(!_contentVideoView) {
        BSPostsContentVideoView *contentVideoView = [BSPostsContentVideoView postContentVideoView];
        [self.contentView addSubview:contentVideoView];
        _contentVideoView = contentVideoView;
    }
    return _contentVideoView;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    // 设置 cell 的背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image        = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setPost:(BSPosts *)post{
    
    _post = post;
    

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image]
                          placeholderImage:[UIImage imageNamed:@"cellFollowDisableIcon"]];
    
    self.sina_vImageView.hidden = !post.isSina_v;
    self.nameLabel.text         = post.name;
    self.timeLabel.text         = post.create_time;
    self.contentTextLabel.text  = post.text;
    
    [self.dingBtn setTitle:[NSString changeNumberIntoString:post.ding placeholer:@"赞"]
                  forState:(UIControlStateNormal)];
    [self.caiBtn setTitle:[NSString changeNumberIntoString:post.cai placeholer:@"踩"]
                 forState:(UIControlStateNormal)];
    [self.shareBtn setTitle:[NSString changeNumberIntoString:post.repost placeholer:@"分享"]
                   forState:(UIControlStateNormal)];
    [self.commentBtn setTitle:[NSString changeNumberIntoString:post.comment placeholer:@"评论"]
                     forState:(UIControlStateNormal)];
    
    // 根据帖子类型 添加内容视图
    if (post.type == BSPostsTypePicture) { // 图片帖子
        self.contentPictureView.post = post;
        self.contentPictureView.frame = post.contentPictureFrame;
        // 防止循环利用
        self.contentPictureView.hidden = NO;
        self.contentVideoView.hidden = YES;
        self.contentVoiceView.hidden = YES;
        
    } else if (post.type == BSPostsTypeVoice) { // 声音帖子
        self.contentVoiceView.post = post;
        self.contentVoiceView.frame = post.contentVoiceFrame;
        // 防止循环利用
        self.contentVoiceView.hidden = NO;
        self.contentPictureView.hidden = YES;
        self.contentVideoView.hidden = YES;

        
    }else if (post.type == BSPostsTypeVideo) { // 视频帖子
        self.contentVideoView.post = post;
        self.contentVideoView.frame = post.contentVideoFrame;
        // 防止循环利用
        self.contentVideoView.hidden = NO;
        self.contentPictureView.hidden = YES;
        self.contentVoiceView.hidden = YES;
        
    }else{ // 段子帖子
        self.contentVideoView.hidden = YES;
        self.contentPictureView.hidden = YES;
        self.contentVoiceView.hidden = YES;
    }
    
    // 最热评论
    BSComment *top_cmt = [post.top_cmt firstObject];
    if (top_cmt) {
        self.commentView.hidden = NO;
        self.postCommentL.text = [NSString stringWithFormat:@"%@ : %@", top_cmt.user.username, top_cmt.content];
    }else{
        self.commentView.hidden = YES;
    }
}


/**
 *  设置 cell 的边距问题
 */
-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = BSPostsCellMargin;
    frame.origin.y += BSPostsCellMargin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= BSPostsCellMargin;
    
    [super setFrame:frame];
}

@end
