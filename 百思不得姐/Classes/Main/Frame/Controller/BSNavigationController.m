//
//  BSNavigationController.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/3.
//  Copyright © 2016年 Li_Cheng. All rights reserved.
//

#import "BSNavigationController.h"

@implementation BSNavigationController

/**
 *  当第一次使用该类时, 会调用该方法
 */
+ (void)initialize{
    
    // 设置导航栏背景图片
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    /**
     *  appearanceWhenContainedInInstancesOfClasses
     *
     *  该方法是设置, 当导航栏包含在当前控制器下才会 设置下面导航栏的背景图片, 其他的话不会设置
     */
    
//    [bar setBackgroundColor:[UIColor redColor]];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]
              forBarMetrics:(UIBarMetricsDefault)];
}

- (void)viewDidLoad{
    
    /**
     *      导航栏的设置 最好不要写在该方法中
     *
     *  因为程序启动时viewDidLoad会调用四次, 相当于设置了四次.
     */
}


/**
 *  可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    // 判断push进来的是不是第一个控制器, 第一个控制器为精华,新帖等等, 不需要返回按钮
    if (self.childViewControllers.count > 0) {
        
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        // 设置文字
        [backBtn setTitle:@"返回"
                 forState:(UIControlStateNormal)];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [backBtn setTitleColor:[UIColor blackColor]
                      forState:(UIControlStateNormal)];
        [backBtn setTitleColor:[UIColor redColor]
                      forState:(UIControlStateHighlighted)];
        
        // 设置图片
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"]
                 forState:(UIControlStateNormal)];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"]
                 forState:(UIControlStateHighlighted)];
        [backBtn addTarget:self
                    action:@selector(backClick)
          forControlEvents:(UIControlEventTouchUpInside)];
        
        backBtn.bs_size = CGSizeMake(70, 25);
        
        // contentHorizontalAlignment: 让按钮内部所有内容左对齐
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 设置按钮的内边距
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        // 将自定义的返回按钮 设置为控制器的左按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        /**
         *  viewController.navigationItem.backBarButtonItem = backBtn;
         *  如果要设置控制器的返回按钮, 可以在这个控制器的上一个控制器中设置navigationItem. backBarButtonItem
         */
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;

    }
    
    [super pushViewController:viewController animated:animated];
    /**
     *      调用super的push方法放在后面:
     *
     *  原因: 让viewController可以覆盖上面设置的 leftBarButtonItem
     *       可以在控制器内部设置leftBarButtonItem, 这样就覆盖了上面设置的leftBarButtonItem
     */
    
}

- (void)backClick{
    [self popViewControllerAnimated:YES];
}
@end
