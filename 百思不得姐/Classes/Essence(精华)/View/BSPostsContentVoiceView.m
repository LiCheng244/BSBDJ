//
//  BSPostsContentVoiceView.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/13.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPostsContentVoiceView.h"
#import "BSPosts.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BSPostsContentVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthL;
@property (weak, nonatomic) IBOutlet UILabel *playcountL;

@end
@implementation BSPostsContentVoiceView

+ (instancetype)postsContentVoiceView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = NO;
}

-(void)setPost:(BSPosts *)post{
    _post = post;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:post.large_image]];
    
    NSInteger minute = post.voicetime / 60;
    NSInteger sencond = post.voicetime % 60;
    self.voicelengthL.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, sencond];
    self.playcountL.text = [NSString stringWithFormat:@"%ld次播放", post.playcount];
}
- (IBAction)playClick:(id)sender {
}


@end
