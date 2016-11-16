//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommendTagsViewController.h"

@interface BSEssenceViewController ()

/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

/** 当前选择的按钮 */
@property (nonatomic, strong) UIButton *currentButton;
@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 设置标签栏
    [self setUpTitlesView];
}

/**
 *  设置导航栏
 */
- (void)setUpNav {
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左按钮
    UIBarButtonItem *leftBtn = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                    highImage:@"MainTagSubIconClick"
                                                       target:self
                                                       action:@selector(leftClick)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // 设置背景颜色
    self.view.backgroundColor = BSGlobalColor;
}

/**
 *  设置标签栏
 */
- (void)setUpTitlesView {
    
    // 标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 35);
    [self.view addSubview:titlesView];
    
    // 指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.height = 2;
    self.indicatorView.y = titlesView.height - self.indicatorView.height;
    self.indicatorView.backgroundColor = [UIColor redColor];
    [titlesView addSubview:self.indicatorView];

    // 内部按钮
    NSArray *titles = @[@"全全部部", @"全部视频", @"全部音频",@"全部图片", @"全部段子"];
    
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat x = width * i;
        button.frame = CGRectMake(x, 0, width, height);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(changeClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titlesView addSubview:button];
        
        // 第一个button
        if (i == 0) {
            
            // 设置按钮选中后不能再次点击
            button.selected = YES;
//            self.currentButton = button;
            //            [button.titleLabel sizeToFit];
            self.currentButton.width = button.titleLabel.width;
            self.currentButton.centerX = button.centerX;
            
        }

    }
}


/**
 *  按钮点击事件
 */
- (void)changeClick:(UIButton *)button {
    
    // 修改按钮状态
    self.currentButton.selected = NO;
    button.selected = YES;
    self.currentButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}


/**
 *  左按钮点击事件
 */
- (void)leftClick {
    
    

    
    BSRecommendTagsViewController *tagsVC = [[BSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}

@end
