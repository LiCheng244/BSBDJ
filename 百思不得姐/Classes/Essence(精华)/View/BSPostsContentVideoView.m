//
//  BSPostsContentVideoView.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/13.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPostsContentVideoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BSPosts.h"

@interface BSPostsContentVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeL;

@property (weak, nonatomic) IBOutlet UILabel *videoPlayCountL;

@end
@implementation BSPostsContentVideoView

+(instancetype)postContentVideoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)videoPlayClick:(id)sender {
    
    NSLog(@"111");
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = NO;
}

-(void)setPost:(BSPosts *)post{
    _post = post;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:post.large_image]];
    
    NSInteger minute = post.videotime / 60;
    NSInteger sencond = post.videotime % 60;
    self.videoTimeL.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, sencond];
    self.videoPlayCountL.text = [NSString stringWithFormat:@"%ld次播放", post.playcount];

    
}

@end
