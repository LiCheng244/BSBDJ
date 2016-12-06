//
//  BSRecommendTagCell.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/14.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendTagCell.h"
#import "BSRecommendTag.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BSRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation BSRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setRecommendTag:(BSRecommendTag *)recommendTag {
    _recommendTag = recommendTag;

    NSString *subNumber  = [NSString changeNumberIntoString:recommendTag.sub_number placeholer:@"关注"];
    _subNumberLabel.text = [NSString stringWithFormat:@"%@人关注", subNumber];
    _themeNameLabel.text = recommendTag.theme_name;
    [_imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]
                           placeholderImage:[UIImage imageNamed:@"cellFollowDisableIcon"]];
}

/**
 *  重写, 外部任何一次修改frame 都会调用该方法
 * 
 *  以后不想让别人修改 frame, 就重写 该方法在里面设置固定值
 */
-(void)setFrame:(CGRect)frame {
    
    frame.origin.x = 10;
    frame.size.width -= 20;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
