//
//  UIImage+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/19.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithCustomerColor:(UIColor *)color{
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/**
* 矩形颜色图片
*/
+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(aSzize, NO,0);
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, aSzize.width, aSzize.height)];
    
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}
@end
