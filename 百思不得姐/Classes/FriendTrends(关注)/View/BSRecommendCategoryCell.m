//
//  BSRecommendCategoryCell.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/4.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendCategoryCell.h"
#import "BSRecommendCategory.h"


@interface BSRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *leftSelectView;

@end


@implementation BSRecommendCategoryCell


/**
 *  xib 创建会调用该方法
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = BSRGBColor(244, 244, 244);
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 重新调整内部textLabel 的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

-(void)setCategory:(BSRecommendCategory *)category{
    
    _category = category;
    self.textLabel.text = category.name;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
    
    self.leftSelectView.hidden = !selected;
    self.textLabel.textColor = !selected ? BSRGBColor(78, 78, 78) : BSRGBColor(219, 21, 26);

}

@end
