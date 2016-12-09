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

@interface BSShowPictureController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

/** 记录当前的缩放值 */
@property (nonatomic, assign)  CGFloat lastScale;
/** 图片 */
@property (nonatomic, weak)  UIImageView *pictureView;

@end

@implementation BSShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *pictureView = [[UIImageView alloc] init];
    pictureView.userInteractionEnabled = YES;

    // 图片添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)];
    [pictureView addGestureRecognizer:tapGesture];
    
    // 图片添加缩放事件
    UIPinchGestureRecognizer *scaleGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleClick:)];
    [pictureView addGestureRecognizer:scaleGesture];

    // 设置图片的位置
    CGFloat imageW = MainWidth;
    CGFloat imageH = imageW * self.post.height / self.post.width;
    if (imageH > MainHeight) { // 图片超出屏幕高度 滚动查看
        pictureView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    } else {
        pictureView.bs_size    = CGSizeMake(imageW, imageH);
        pictureView.bs_centerX = MainWidth / 2;
        pictureView.bs_centerY = MainHeight / 2;
    }
    
    // 马上显示进度条
    [self.progressView setProgress:self.post.pictureProgress animated:NO];
    
    // 下载图片
    [pictureView sd_setImageWithURL:[NSURL URLWithString:self.post.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress         = 1.0*receivedSize/expectedSize;
        [self.progressView setProgress:progress]; //进度条
        NSString *text = [NSString stringWithFormat:@"%.0f%%", progress*100];
        self.progressView.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];

    [self.scrollView addSubview:pictureView];
    self.pictureView = pictureView;
}


#pragma mark - <点击事件>
/**
 *  返回按钮
 */
- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.view.contentMode = UIViewContentModeScaleToFill;
}
/**
 *  转发按钮
 */
- (IBAction)shareClick:(id)sender {
}

/**
 *  保存图片
 */
- (IBAction)saveClick:(id)sender {
    
    // 将图片保存到相册中
    UIImageWriteToSavedPhotosAlbum(self.pictureView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 *  缩放图片
 */
- (void)scaleClick:(id)sender{
}

#pragma mark - <私有方法>
/**
 *  隐藏状态栏
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
}
/**
 *  保存图片回调方法
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
