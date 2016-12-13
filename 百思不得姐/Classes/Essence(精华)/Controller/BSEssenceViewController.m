//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/1.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommendTagsViewController.h"
#import "BSPostsViewController.h"



@interface BSEssenceViewController ()<UIScrollViewDelegate>

/** 红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选择的按钮 */
@property (nonatomic, weak) UIButton *currentButton;
/** 顶部的标签栏 */
@property (nonatomic, strong) UIView *titlesView;
/** 底部的横屏滚动 view */
@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 添加每个标签的子控制器
    [self setUpTagChildVC];
    
    // 设置标签栏
    [self setUpTitlesView];
    
    // 设置内容滚动 view
    [self setUpContentView];
}

#pragma mark - <初始化操作>
/**
 *  设置导航栏
 */
- (void)setUpNav {
    
    // 设置背景颜色
    self.view.backgroundColor = BSGlobalColor;
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                                 highImage:@"MainTagSubIconClick"
                                                                    target:self
                                                                    action:@selector(leftRecommendTagsClick)];
}

/**
 * 添加每个标签的子控制器
 */
- (void)setUpTagChildVC {
    
    BSPostsViewController *allVC     = [[BSPostsViewController alloc] init];
    allVC.title                      = @"全部";
    allVC.type                       = BSPostsTypeAll;
    [self addChildViewController:allVC];
    
    BSPostsViewController *videoVC   = [[BSPostsViewController alloc] init];
    videoVC.title                    = @"视频";
    videoVC.type                     = BSPostsTypeVideo;
    [self addChildViewController:videoVC];
    
    BSPostsViewController *voiceVC   = [[BSPostsViewController alloc] init];
    voiceVC.title                    = @"音频";
    voiceVC.type                     = BSPostsTypeVoice;
    [self addChildViewController:voiceVC];
    
    BSPostsViewController *pictureVC = [[BSPostsViewController alloc] init];
    pictureVC.title                  = @"图片";
    pictureVC.type                   = BSPostsTypePicture;
    [self addChildViewController:pictureVC];
    
    BSPostsViewController *wordVC    = [[BSPostsViewController alloc] init];
    wordVC.title                     = @"段子";
    wordVC.type                      = BSPostsTypeWord;
    [self addChildViewController:wordVC];
}

/**
 *  设置标签栏
 */
- (void)setUpTitlesView {
    
    // 标签栏
    UIView *titlesView         = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];// 不建议使用alpha; 用alph 内部子控件也会变成透明的
    titlesView.frame           = CGRectMake(0, BSTitlesViewY, self.view.bs_width, BSTitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView            = titlesView;
    
    // 指示器（下边的红色）
    UIView *indicatorView         = [[UIView alloc] init];
    indicatorView.bs_y            = titlesView.bs_height - indicatorView.bs_height;
    indicatorView.bs_height       = 2;
    indicatorView.backgroundColor = [UIColor redColor];
    [titlesView addSubview:indicatorView];
    self.indicatorView            = indicatorView;
    
    // 内部button
    CGFloat width   = titlesView.bs_width / self.childViewControllers.count;
    CGFloat height  = titlesView.bs_height;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        
        UIButton *button       = [[UIButton alloc] init];
        button.tag             = 1000 + i;
        button.bs_x            = width * i;
        button.bs_width        = width;
        button.bs_height       = height;
        button.titleLabel.font = [UIFont systemFontOfSize:15];

        UIViewController *currentChildVC = self.childViewControllers[i];
        [button setTitle:currentChildVC.title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        [button addTarget:self action:@selector(titlesViewsClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titlesView addSubview:button];
        
        // 第一个button
        if (i == 0) {
            
            // 设置按钮选中后不能再次点击
            button.enabled     = NO;
            self.currentButton = button;
            
            // 让按钮内部的 label 根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.bs_x = (button.bs_width- button.titleLabel.bs_width) / 2;
            self.indicatorView.bs_width   = button.titleLabel.bs_width;
        }
    }
}

/**
 *  设置内容滚动View
 */
- (void)setUpContentView {
    
    // 不自动调整inset（内边距）
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 底部滚动视图
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame         = self.view.bounds;
    contentView.delegate      = self; // 滚动结束后加载数据
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0]; // 插入到标签栏的底部
    
    // 设置滚动范围 (取到当前的子控制器个数，子控制器的创建要在底部滚动视图的前面)
    contentView.contentSize   = CGSizeMake(contentView.bs_width * self.childViewControllers.count, 0);
   
    // 添加第一个子控制器视图
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    self.contentView = contentView;
}


#pragma mark - <点击事件>
/**
 *  标签栏点击事件
 */
- (void) titlesViewsClick:(UIButton *)button {
    
    // 修改按钮状态
    self.currentButton.enabled = YES;    // 当前按钮可以点击
    button.enabled             = NO;     // 点击按钮不能再次点击
    self.currentButton         = button; // 将选中按钮设置为当前按钮
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.bs_centerX = button.bs_centerX;
        self.indicatorView.bs_width   = button.titleLabel.bs_width;
    }];
    
    // 让底部的 contentView 滚动
    CGPoint point = self.contentView.contentOffset;
    point.x       = (button.tag-1000) * self.contentView.bs_width;
    [self.contentView setContentOffset:point animated:YES];
}

/**
 *  左按钮点击事件
 */
- (void)leftRecommendTagsClick {
    
    BSRecommendTagsViewController *tagsVC = [[BSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}


#pragma - <UIScrollViewDelegate>
/**
 *  滚动动画结束之后 调用该方法
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 添加子控制器的 view
    NSInteger index           = scrollView.contentOffset.x / scrollView.bs_width; // 获取当前索引
    UIViewController *childVC = self.childViewControllers[index]; // 取出当前子控制器
    childVC.view.bs_x         = scrollView.contentOffset.x;
    childVC.view.bs_y         = 0; // 如果不设置控制器view 的 y 值 ， 默认值是20
    childVC.view.bs_height    = self.view.bs_height; //（控制器的 view 默认的 frame：（0，20，屏幕宽，屏幕高-20）)
    
    [scrollView addSubview:childVC.view];
}

/**
 *  拖拽时 停止减速时 调用该方法
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 整屏切换
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 按钮切换
    NSInteger index = scrollView.contentOffset.x /scrollView.bs_width + 1000;
    [self titlesViewsClick:[self.titlesView viewWithTag:index]];
}

@end
