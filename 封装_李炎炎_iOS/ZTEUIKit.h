//
//  ZTEUIKit.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTEUIKit : NSObject

#pragma mark UILabel 初始化方法
/** 文字 */
+ (UILabel*)labelWithText:(NSString*)text;

/** 字体 */
+ (UILabel*)labelWithFont:(UIFont*)font;

/** 文字 + 字体 */
+ (UILabel*)labelWithText:(NSString*)text font:(UIFont*)font;

/** 文字 + 字体 + 文字颜色 */
+ (UILabel*)labelWithText:(NSString *)text  font:(UIFont*)font textColor:(UIColor *)textColor;

/** 文字 + 字体 + 文字对齐 */
+ (UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/** 文字 + 字体 + + 文字颜色 + 文字对齐 */
+ (UILabel*)labelWithText:(NSString *)text  font:(UIFont*)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/** 文字 + 文字颜色 + 字体 + 行数 + 文字对其 + 背景颜色 */
+ (UILabel*)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font numberLine:(NSInteger)numberLines
            textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)backgroundColor;

#pragma mark UIButton 初始化方法
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

@end
