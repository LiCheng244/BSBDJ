//
//  BSLoginTextFiled.m
//  百思不得姐
//
//  Created by LiCheng on 2016/11/15.
//  Copyright © 2016年 LiCheng. All rights reserved.
//

#import "BSLoginTextFiled.h"
#import <objc/runtime.h>


@interface BSLoginTextFiled ()

/** 占位文字 */
@property (nonatomic, strong) UILabel *placeholderLabel;
@end
@implementation BSLoginTextFiled


/**
 *  利用runtime 查看UITextFiled 都有哪些隐藏的属性
 */
+(void)initialize{
    
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    /**
     *  参数1:  要查看的类
        参数2:  给一个地址, 存变量列表的个数
        
        Ivar *ivars是一个指针: 指向成员变量数组中的第一个元素 , 且该数组中的元素类型都是Ivar类型
     */
    
    for (int i = 0; i < count; i++) {
        
        // 取出成员变量 (通过指针下标)
        Ivar ivar = *(ivars + i);
//        Ivar ivar = ivars[i]; (效果一样)
        
        // 获取变量名称
        const char *name = ivar_getName(ivar);
//        BSLog(@"%s", name);
    }
    
    // 释放内存 (因为是拷贝出来的所以需要自己释放)
    free(ivars);
    
}

/**
 *  相当于 : initWithFrame
 */
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 取出placeholderLabel
    self.placeholderLabel = [self valueForKey:@"_placeholderLabel"];
    self.placeholderLabel.textColor = [UIColor grayColor];
    
    // 修改光标颜色
    self.tintColor = self.textColor;
}

/**
 *  成为第一响应者, 当前文本框聚焦时调用
 */
-(BOOL)becomeFirstResponder{
    
    // 修改文字颜色
    self.placeholderLabel.textColor = self.textColor;
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时调用
 */
-(BOOL)resignFirstResponder{
    
    self.placeholderLabel.textColor = [UIColor grayColor];
    return [super resignFirstResponder];
}

/**
 *      通过富文本属性 直接赋值
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
 
    // NSAttributedString : 带有属性的文字(富文本: 可以控制字的颜色, 大小, 字体, 字号等等)
    NSAttributedString *phonePl = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    self.phoneNoTF.attributedPlaceholder = phonePl;
 
    NSAttributedString *pwdPl = [[NSAttributedString alloc] initWithString:@"密码" attributes:attrs];
    self.passwordTF.attributedPlaceholder = pwdPl;

 */

@end
