//
//  UILabel+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/11/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
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

@end
