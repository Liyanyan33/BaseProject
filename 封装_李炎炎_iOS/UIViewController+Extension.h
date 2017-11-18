//
//  UIViewController+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/21.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
#pragma mark  获取应用程序当前正在显示的视图控制器
+ (UIViewController *)currentViewController;

/** 在导航控制器栈中 删除指定的视图控制器 */
- (void)deletVCInNavStackWithVCName:(NSString*)vcName;

@property(nonatomic,copy)NSString *message;

@end
