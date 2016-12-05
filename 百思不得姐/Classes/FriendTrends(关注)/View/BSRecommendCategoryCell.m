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
    
    /**
     *  当cell的selection 被设置为 none 时:
     *
     *  cell 中的所有子控件 都不会进入高亮状态; 但是点击事件会存在
     *  即使在 该方法中通过代码设置 cell 的选中样式没有效果
     */
}


/**
 *  赋值
 */
-(void)setCategory:(BSRecommendCategory *)category{
    
    _category = category;
    self.textLabel.text = category.name;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 重新调整内部textLabel 的frame(不要挡住自定义的底部白线)
    self.textLabel.bs_y = 2;
    self.textLabel.bs_height = self.contentView.bs_height - 2 * self.textLabel.bs_y;
}


/**
 *  可以在该方法中监听cell的选中和未选中状态
 *
 *  如果要修改cell被选中的状态可以再该方法中进行修改
 *
 *  @param selected 值为YES 代表选中
 */
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
    
    self.leftSelectView.hidden = !selected;
    self.textLabel.textColor   = !selected ? BSRGBColor(78, 78, 78) : BSRGBColor(219, 21, 26);
    self.backgroundColor       = !selected ? BSGlobalColor : BSRGBColor(255, 255, 255);
}

@end
