//
//  UIViewController+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/21.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+ (UIViewController *)currentViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // modal展现方式的底层视图不同
    // 获取到第一层，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    
    // 获取view所在的视图控制器
    UIViewController *vc = secondView.parentController;
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}
@end
