//
//  UIView+BSFrame.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "UIView+BSFrame.h"

@implementation UIView (BSFrame)

-(void)setBs_x:(CGFloat)bs_x{
    
    CGRect frame   = self.frame;
    frame.origin.x = bs_x;
    self.frame     = frame;
}

-(void)setBs_y:(CGFloat)bs_y{
    
    CGRect frame   = self.frame;
    frame.origin.y = bs_y;
    self.frame     = frame;
}

-(void)setBs_width:(CGFloat)bs_width{
    
    CGRect frame     = self.frame;
    frame.size.width = bs_width;
    self.frame       = frame;
}

-(void)setBs_height:(CGFloat)bs_height{
    
    CGRect frame      = self.frame;
    frame.size.height = bs_height;
    self.frame        = frame;
}

-(void)setBs_centerX:(CGFloat)bs_centerX{
    CGPoint center = self.center;
    center.x       = bs_centerX;
    self.center    = center;
}

-(void)setBs_centerY:(CGFloat)bs_centerY{
    CGPoint center = self.center;
    center.y       = bs_centerY;
    self.center    = center;
}

-(CGFloat)bs_centerX{
    return self.center.x;
}
-(CGFloat)bs_centerY{
    return self.center.y;
}
-(CGFloat)bs_x{
    return self.frame.origin.x;
}

-(CGFloat)bs_y{
    return self.frame.origin.y;
}

-(CGFloat)bs_width{
    return self.frame.size.width;
}

-(CGFloat)bs_height{
    return self.frame.size.height;
}

-(void)setBs_size:(CGSize)bs_size{
    
    CGRect frame = self.frame;
    frame.size   = bs_size;
    self.frame   = frame;
}
-(CGSize)bs_size{
    return self.frame.size;
}
@end
