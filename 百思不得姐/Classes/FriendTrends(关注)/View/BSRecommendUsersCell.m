//
//  BSRecommendUsersCell.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/6.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSRecommendUsersCell.h"
#import "BSRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface BSRecommendUsersCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end
@implementation BSRecommendUsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setUser:(BSRecommendUser *)user{
    
    _user = user;
    
    
    NSString *fansCount   = [NSString changeNumberIntoString:user.fans_count placeholer:@"关注"];
    _fansCountLabel.text  = [NSString stringWithFormat:@"%@人关注", fansCount];
    _screenNameLabel.text = user.screen_name;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:user.header]
                      placeholderImage:[UIImage imageNamed:@"cellFollowDisableIcon"]];
}

@end
