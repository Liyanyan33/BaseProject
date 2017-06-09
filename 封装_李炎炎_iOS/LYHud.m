//
//  LYHud.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "LYHud.h"

@implementation LYHud

+ (MBProgressHUD*)showAtView:(UIView*)view{

    return  [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)setHUDPropetyAtView:(UIView *)view statu:(netStatu)statu{
    // 获取HUD控件
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        if (statu == Success) {
            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            hud.customView = imageView;
            hud.mode = MBProgressHUDModeCustomView;
            hud.label.text = NSLocalizedString(@"数据加载成功", @"HUD completed title");
        }else if(statu == error){
        
        }
    }
}


+ (void)hideAtView:(UIView*)view{

    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showAtView:(UIView *)view title:(NSString *)title{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = title;
}

+ (void)hideAtView:(UIView *)view statu:(netStatu)statu{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    UIImage *image = [[UIImage imageNamed:@"success-black.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    
    if (statu == Success) {
        hud.label.text = NSLocalizedString(@"数据加载成功", @"HUD completed title");
    }else if (statu == error){
        hud.label.text = NSLocalizedString(@"Completed", @"HUD completed title");
    }
    [hud hideAnimated:YES afterDelay:1.0f];
}

+ (void)showAtView:(UIView *)view title:(NSString *)title dimBackground:(BOOL)dimBackground{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = title;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];   // 设置遮盖背景的颜色
    hud.backgroundView.color = [UIColor blackColor];
    hud.backgroundView.alpha = 0.4;
}

+ (MBProgressHUD*)showActivityIndicatorAtView:(UIView *)view title:(NSString *)title dimBackground:(BOOL)dimBackground{

    MBProgressHUD *hud = [self showAtView:view];
    hud.label.text = title;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.backgroundView.color = [UIColor blackColor];
    hud.backgroundView.alpha = 0.3;
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}

+ (MBProgressHUD*)showOnlyLabelAtView:(UIView *)view title:(NSString *)title dimBackground:(BOOL)dimBackground{
    
    MBProgressHUD *hud = [self showActivityIndicatorAtView:view title:title dimBackground:dimBackground];
    hud.mode = MBProgressHUDModeText;
    return hud;
}

+ (MBProgressHUD*)showProgressBarAtView:(UIView *)view title:(NSString *)title dimBackground:(BOOL)dimBackground{

    MBProgressHUD *hud = [self showActivityIndicatorAtView:view title:title dimBackground:dimBackground];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    return hud;
}

+ (void)showToastAtView:(UIView *)view title:(NSString *)title delay:(NSTimeInterval)delay{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    
    // 设置Toast的展示位置
    // MBProgressMaxOffset  表示在底部
    //               0                      表示在中间
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);

    [hud hideAnimated:YES afterDelay:delay];
}


@end
