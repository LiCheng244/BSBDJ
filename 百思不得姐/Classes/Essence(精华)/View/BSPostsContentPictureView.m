//
//  BSPostsContentPictureView.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPostsContentPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DACircularProgress/DALabeledCircularProgressView.h>
#import "BSPosts.h"
#import "BSShowPictureController.h"

@interface BSPostsContentPictureView ()
/** 图片内容视图 */
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/** 动图 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看全部图片按钮 */
@property (weak, nonatomic) IBOutlet UIButton *totalPictureBtn;
/** 进度条 */
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation BSPostsContentPictureView


+ (BSPostsContentPictureView *)postsContentPictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
    // 禁止自动伸缩
    self.autoresizingMask                     = UIViewAutoresizingNone;
    self.progressView.roundedCorners          = 3;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    // 给图片添加监听器
    self.pictureView.userInteractionEnabled   = YES; // 接受点击事件
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    // 将totalPictureBtn的用户交互关闭，点击totalPictureBtn时相当于点击了后面的pictureView
}

/**
 *  显示全部图片按钮
 */
-(void)showPicture {
    
    BSShowPictureController *showPictureVC = [[BSShowPictureController alloc] init];
    showPictureVC.post                     = self.post;
    [BSRootViewVC presentViewController:showPictureVC animated:YES completion:nil];
}


-(void)setPost:(BSPosts *)post{
    
    _post = post;
    
    // 马上显示图片加载进度条(防止因为网速慢，导致显示其他图片的下载进度)
    [self.progressView setProgress:post.pictureProgress animated:NO];
    
    // 图片
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:post.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        
        // 进度条值
        post.pictureProgress     = 1.0*receivedSize/expectedSize;
        [self.progressView setProgress:post.pictureProgress];
        
        // 圆圈中的值
        NSString *text = [NSString stringWithFormat:@"%.0f%%", post.pictureProgress*100];
        self.progressView.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (post.isBigPicture) { // 只有大图才进行裁剪
            
            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(post.contentPictureFrame.size, YES, 0.0);
            
            // 将下载的图片对象绘制到图形上下文
            CGFloat width = post.contentPictureFrame.size.width;
            CGFloat height = width * post.height / post.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            
            // 获得图片
            self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 结束上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    // gif (利用扩展名来判断，sdwebimage使用图片date的第一个字节来判断的)
    NSString *extension = post.large_image.pathExtension; // 获取扩展名
    self.gifView.hidden = ! [extension.lowercaseString isEqualToString:@"gif"];
    
    // 查看全部按钮
    if (post.isBigPicture) { // 大图
        self.totalPictureBtn.hidden    = NO;
        self.pictureView.contentMode   = UIViewContentModeScaleAspectFill; // 等比例伸缩
        self.pictureView.clipsToBounds = YES;
        
    }else{
        self.totalPictureBtn.hidden  = YES;
        self.pictureView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
