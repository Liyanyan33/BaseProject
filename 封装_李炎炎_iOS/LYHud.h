//
//  LYHud.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, netStatu) {
    Success,
    error,
};

@interface LYHud : NSObject

+ (MBProgressHUD*)showAtView:(UIView*)view;

+ (void)hideAtView:(UIView*)view;

+ (void)hideAtView:(UIView *)view title:(NSString*)title;

+ (void)hideAtView:(UIView *)view statu:(netStatu)statu;

+ (void)showAtView:(UIView *)view title:(NSString*)title;

+ (void)showAtView:(UIView *)view title:(NSString *)title dimBackground:(BOOL)dimBackground;

+ (MBProgressHUD*)showActivityIndicatorAtView:(UIView*)view title:(NSString*)title dimBackground:(BOOL)dimBackground;

+ (MBProgressHUD*)showOnlyLabelAtView:(UIView*)view title:(NSString*)title dimBackground:(BOOL)dimBackground;

+ (MBProgressHUD*)showProgressBarAtView:(UIView*)view title:(NSString*)title dimBackground:(BOOL)dimBackground;

+ (void)showToastAtView:(UIView*)view title:(NSString*)title  delay:(NSTimeInterval)delay;

+ (void)setHUDPropetyAtView:(UIView *)view statu:(netStatu)statu;


@end
