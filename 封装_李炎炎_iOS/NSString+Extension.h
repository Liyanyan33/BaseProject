//
//  NSString+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/1.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 根据身份证号码获取出生日期 */
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)iDnumberStr;

/** 根据身份证号码获取年龄 */
+ (NSString *)getIdentityCardAge:(NSString *)numberStr;

/** 根据文字 计算区域大小 */
+ (CGSize)getBoundSizeWithText:(NSString*)text font:(UIFont*)font;

/**
 *  根据文字,字体,指定的宽度 计算 区域大小 主要用于UILabel的自适应高度
 *  在计算 UILabel自适应高度时, 计算区域尺寸时的Font一定要与Label的font保持一致
 */
- (CGSize)sizeWithFont:(UIFont *)font withWidth:(CGFloat)width;

- (CGSize)sizeWithFont:(UIFont *)font withHeight:(CGFloat)height;
@end
