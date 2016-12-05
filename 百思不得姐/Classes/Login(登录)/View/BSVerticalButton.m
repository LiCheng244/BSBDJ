//
//  BSVerticalButton.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/14.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton


- (void)setup {
    
    // 文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

/**
 *  xib创建
 */
-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
}
/**
 *  代码创建
 */
- (instancetype)initWithFrame:(CGRect)frame {
  
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  跳转子控件位置
 */
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 调整图片位置
    self.imageView.bs_x = 0;
    self.imageView.bs_y = 0;
    self.imageView.bs_width = self.bs_width;
    self.imageView.bs_height = self.imageView.bs_width;
    
    // 设置文字位置
    self.titleLabel.bs_x = 0;
    self.titleLabel.bs_y = self.imageView.bs_width + 5;
    self.titleLabel.bs_width = self.bs_width;
    self.titleLabel.bs_height = self.bs_height - self.imageView.bs_height;
}
@end
