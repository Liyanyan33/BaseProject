//
//  UIButton+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/10/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

#pragma mark 常见构造方法
/** 正常状态 文字 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText;

/** 正常状态下 图片 */
+ (UIButton*)buttonWithnormalImage:(NSString*)normalImage;

/** 正常状态 文字 + 字体 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font;

/** 正常状态 文字 + 字体 + 字体颜色 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor;

/** 正常状态 文字 + 字体 + 正常状态图片 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalImage:(NSString*)normalImage;

/** 正常状态 文字 + 字体 + 字体颜色 + 正常状态图片 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString *)normalImage;

/** 正常状态 文字 + 字体 + 字体颜色 + 正常状态图片 + 背景图片 */
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString*)normalImage normalBackgroundImage:(NSString*)normalBackgroundImage;

#pragma mark 交互事件
/** 添加点击事件 */
- (void)addClickBlock:(void(^)(void))blockHandler;

@end
