//
//  MBHUD.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/11/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "MBHUD.h"
#import <MBProgressHUD.h>

#define DelayTime 3.0f

@implementation MBHUD

+ (void)showLoading{
    
}

+ (void)showLoading:(UIView *)toView title:(NSString *)title hasBackground:(BOOL)hasBackground{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if ([title isEqualToString:@""]) {
        title = @"正在加载中...";
    }
    hud.label.text = title;
    hud.offset = CGPointMake(0, 0);
}

+ (void)showToast:(UIView*)toview{
    [self showToast:toview title:@""];
}

+ (void)showToast:(UIView *)toview title:(NSString *)title{
    [self showToast:toview title:title location:HUDLocationCenter];
}

+ (void)showToast:(UIView *)toview title:(NSString *)title location:(HUDLocation)location{
    [self showToast:toview title:title location:location delayTime:DelayTime];
}

+ (void)showToast:(UIView *)toview title:(NSString *)title location:(HUDLocation)location delayTime:(CGFloat)delayTime{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    if ([title isEqualToString:@""]) {
        title = @"数据加载失败...";
    }
    hud.label.text = title;
    if (location == HUDLocationCenter) {
        hud.offset = CGPointMake(0, 0);
    }else if (location == HUDLocationBottom){
        hud.offset = CGPointMake(0, MBProgressMaxOffset);
    }
    [hud hideAnimated:YES afterDelay:delayTime];
}
@end
