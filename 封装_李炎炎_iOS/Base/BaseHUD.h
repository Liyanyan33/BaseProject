//
//  BaseHUD.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/11/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HUDLocation){
    HUDLocationCenter,
    HUDLocationBottom
};

@interface BaseHUD : NSObject

+ (void)showLoading:(UIView*)toView;
+ (void)showLoading:(UIView*)toView title:(NSString*)title;
+ (void)showLoading:(UIView*)toView title:(NSString*)title hasBackground:(BOOL)hasBackground;

+ (void)hideLoading;

+ (void)showSuccess:(UIView*)view;
+ (void)showError;

+ (void)showToast:(UIView*)toview;
+ (void)showToast:(UIView*)toview title:(NSString*)title;
+ (void)showToast:(UIView*)toview title:(NSString*)title location:(HUDLocation)location;
+ (void)showToast:(UIView*)toview title:(NSString*)title location:(HUDLocation)location delayTime:(CGFloat)delayTime;

@end
