//
//  UIImage+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/19.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 通过颜色创建 一张图片*/
+ (UIImage *)imageWithCustomerColor:(UIColor *)color;

+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor;


@end
