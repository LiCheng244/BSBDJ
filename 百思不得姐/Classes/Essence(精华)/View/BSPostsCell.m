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

@interface BSPostsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@end

@implementation BSPostsCell

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    // 设置 cell 的背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setPost:(BSPosts *)post{
    
    _post = post;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image]
                          placeholderImage:[UIImage imageNamed:@"cellFollowDisableIcon"]];
    
    self.sina_vImageView.hidden = !post.isSina_v;
    
    self.nameLabel.text = post.name;
    self.timeLabel.text = post.create_time;
    
    [self.dingBtn setTitle:[NSString changeNumberIntoString:post.ding placeholer:@"赞"]
                  forState:(UIControlStateNormal)];
    [self.caiBtn setTitle:[NSString changeNumberIntoString:post.cai placeholer:@"踩"]
                 forState:(UIControlStateNormal)];
    [self.shareBtn setTitle:[NSString changeNumberIntoString:post.repost placeholer:@"分享"]
                   forState:(UIControlStateNormal)];
    [self.commentBtn setTitle:[NSString changeNumberIntoString:post.comment placeholer:@"评论"]
                     forState:(UIControlStateNormal)];
}

/**
 *  设置 cell 的边距问题
 */
-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;
    frame.origin.y += 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

@end
