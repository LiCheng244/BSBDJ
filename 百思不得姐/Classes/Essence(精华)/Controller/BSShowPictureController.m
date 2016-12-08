//
//  BSShowPictureController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSShowPictureController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BSPosts.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <DACircularProgress/DALabeledCircularProgressView.h>

@interface BSShowPictureController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

/** 图片 */
@property (nonatomic, weak)  UIImageView *imageView;
@end

@implementation BSShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    // 图片添加点击事件
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)]];
    
    // 设置图片的位置
    CGFloat imageW = MainWidth;
    CGFloat imageH = imageW * self.post.height / self.post.width;
    if (imageH > MainHeight) { // 图片超出屏幕高度 滚动查看
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    } else {
        imageView.bs_size    = CGSizeMake(imageW, imageH);
        imageView.bs_centerX = MainWidth / 2;
        imageView.bs_centerY = MainHeight / 2;
    }
    
    // 马上显示进度条
    [self.progressView setProgress:self.post.pictureProgress animated:NO];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.post.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress         = 1.0*receivedSize/expectedSize;
        [self.progressView setProgress:progress]; //进度条
        NSString *text = [NSString stringWithFormat:@"%.0f%%", progress*100];
        self.progressView.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];

    
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
}

- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.view.contentMode = UIViewContentModeScaleToFill;
}

- (IBAction)shareClick:(id)sender {
}

/**
 *  保存图片
 */
- (IBAction)saveClick:(id)sender {
    
    // 将图片保存到相册中
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
