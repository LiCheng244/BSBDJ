//
//  BSPublishViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/12/8.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"
#import <pop/POP.h>

@interface BSPublishViewController ()

/** 标语 */
@property (nonatomic, strong) UIImageView *sloganView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 等待动画执行, 禁止点击
    self.view.userInteractionEnabled = NO;
    
    // 按钮
    NSArray *imagesName = @[@"publish-video",
                            @"publish-picture",
                            @"publish-text",
                            @"publish-audio",
                            @"publish-review",
                            @"publish-offline"];
    NSArray *btnTitles  = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审贴", @"离线下载"];
    
    // 按钮位置信息
    NSInteger maxCols  = 3;
    CGFloat btnW       = 72;
    CGFloat btnH       = btnW + 30;
    CGFloat btnStartX  = 25;
    CGFloat btnMarignY = 10;
    CGFloat btnMarignX = (MainWidth - btnW * maxCols - btnStartX * 2) / (maxCols - 1);
    CGFloat btnStartY  = (MainHeight - btnH * 2 - btnMarignY) / 2;

    for (int i = 0; i < imagesName.count; i++) {
        
        BSVerticalButton *button = [BSVerticalButton buttonWithType:(UIButtonTypeCustom)];
        button.tag               = 1000+i;
        
        [button setTitleColor:[UIColor blackColor]
                     forState:(UIControlStateNormal)];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
        
        // 设置内容
        [button setTitle:btnTitles[i]
                forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:imagesName[i]]
                forState:(UIControlStateNormal)];

        // 行列
        int row = i / maxCols;
        int col = i % maxCols;
          
        // 计算 x/y
        CGFloat btnX      = btnStartX + col * (btnMarignX + btnW);
        CGFloat btnBeginY = btnH - MainWidth;
        CGFloat btnEndY   = btnStartY + row * (btnMarignY + btnH);
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.springBounciness    = 3;
        anim.springSpeed         = 3;
        anim.beginTime           = CACurrentMediaTime() + 0.1 * i; // 延时时间
        anim.fromValue           = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, btnW, btnH)];
        anim.toValue             = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        [button pop_addAnimation:anim forKey:nil];

        // 标语动画执行完毕
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finsihed) {
            self.view.userInteractionEnabled = YES;
        }];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];

    // 动画
    CGFloat sloganCenterX      = MainWidth / 2;
    CGFloat sloganendCenterY   = MainHeight * 0.15;
    CGFloat sloganbeginCenterY = -MainHeight;
    POPSpringAnimation *anim   = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.beginTime             = CACurrentMediaTime() + 0.1 * imagesName.count; // 延时时间
    anim.fromValue             = [NSValue valueWithCGPoint:(CGPointMake(sloganCenterX, sloganbeginCenterY))];
    anim.toValue               = [NSValue valueWithCGPoint:(CGPointMake(sloganCenterX, sloganendCenterY))];
    [sloganView pop_addAnimation:anim forKey:nil];
}

/**
 *  取消按钮
 */
- (IBAction)cancelClick {
    
    [self cancelWithCompletionBlock:nil];
}

/**
 *  发信息按钮
 */
- (void)buttonClick:(UIButton *)button {
    
    if (button.tag == 1000) {
        [self cancelWithCompletionBlock:^{
            NSLog(@"发视频");
        }];
    } else if (button.tag == 1001) {
        [self cancelWithCompletionBlock:^{
            NSLog(@"发语音");
        }];
    }
}

/**
 *  发信息按钮
 */
- (void)cancelWithCompletionBlock:(void (^)())block {
    
    self.view.userInteractionEnabled = NO;
    self.cancelBtn.hidden = YES;
    
    for (int i = 2; i < self.view.subviews.count; i++) {
        
        UIView *subview = self.view.subviews[i];
        
        // 动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY         = subview.bs_centerY + MainHeight;
        anim.beginTime          = CACurrentMediaTime() + 0.1 * (i - 2); // 延时时间
        anim.toValue            = [NSValue valueWithCGPoint:(CGPointMake(subview.bs_centerX, centerY))];
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 进行判断是否有 block
                !block ? :block();
            }];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletionBlock:nil];
}


@end
