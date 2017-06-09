//
//  UIBarButtonItem+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action text:(NSString *)text{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

//+ (UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage text:(NSString *)text{
//
//    
//    
//    
//}


@end
