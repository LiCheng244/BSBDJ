//
//  BSTabBar.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar()

/**  发布按钮  */
@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation BSTabBar

/**
 *  在创建时,添加发布按钮
 */
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 设置tabBar的背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        // 添加 发布按钮
        UIButton *publishBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"]
                    forState:(UIControlStateNormal)];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]
                    forState:(UIControlStateHighlighted)];

        publishBtn.size = publishBtn.currentImage.size;

        [self addSubview:publishBtn];

        self.publishBtn = publishBtn;
    }
    return self;
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 设置发布按钮的位置
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);

    // 设置其他按钮的frame
    CGFloat buttonY  = 0;
    CGFloat buttonW  = self.width / 5;
    CGFloat buttonH  = self.height;
    NSUInteger index = 0;
    
    for (UIView *button in self.subviews) {
        
        // 判断获取到的视图: 排除背景视图 和 发布按钮
        if (![button isKindOfClass:[UIControl class]] || button == self.publishBtn) continue;
        
        // 计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引值
        index++;
    }
    
}
@end
