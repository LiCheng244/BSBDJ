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
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 设置文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}
@end
