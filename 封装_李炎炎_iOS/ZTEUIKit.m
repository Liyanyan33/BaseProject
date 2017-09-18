//
//  ZTEUIKit.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEUIKit.h"

@implementation ZTEUIKit

+ (UILabel*)labelWithText:(NSString *)text{
    return [ZTEUIKit labelWithText:text font:nil];
}

+ (UILabel*)labelWithFont:(UIFont *)font{
    return [ZTEUIKit labelWithText:nil font:font];
}

+ (UILabel*)labelWithText:(NSString*)text font:(UIFont*)font{
    return [ZTEUIKit labelWithText:text textColor:nil font:font numberLine:0 textAlignment:NSTextAlignmentLeft backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    return [ZTEUIKit labelWithText:text textColor:nil font:font numberLine:0 textAlignment:textAlignment backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text  font:(UIFont*)font textColor:(UIColor *)textColor{
    return [ZTEUIKit labelWithText:text textColor:textColor font:font numberLine:0 textAlignment:NSTextAlignmentLeft backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    return [ZTEUIKit labelWithText:text textColor:textColor font:font numberLine:0 textAlignment:textAlignment backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont*)font numberLine:(NSInteger)numberLines
            textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)backgroundColor{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.numberOfLines = numberLines;
    label.textAlignment = textAlignment;
    if (backgroundColor == nil) {
        label.backgroundColor = [UIColor clearColor];
    }else{
        label.backgroundColor = backgroundColor;
    }
    return label;
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText{
    return [ZTEUIKit buttonWtihNormalText:normalText font:nil];
}

+ (UIButton*)buttonWithnormalImage:(NSString *)normalImage{
    return [ZTEUIKit buttonWtihNormalText:nil font:nil normalImage:normalImage];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font{
    return [ZTEUIKit buttonWtihNormalText:normalText font:font normalTextColor:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalImage:(NSString *)normalImage{
    return [ZTEUIKit buttonWtihNormalText:normalText font:font normalTextColor:nil normalImage:normalImage normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor{
    return [ZTEUIKit buttonWtihNormalText:normalText font:font normalTextColor:normalTextColor normalImage:nil normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString *)normalImage{
    return [ZTEUIKit buttonWtihNormalText:normalText font:font normalTextColor:normalTextColor normalImage:normalImage normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString *)normalImage normalBackgroundImage:(NSString *)normalBackgroundImage {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:normalText forState:(UIControlStateNormal)];
    [button setTitleColor:normalTextColor forState:(UIControlStateNormal)];
    button.titleLabel.font = font;
    [button setImage:[UIImage imageNamed:normalImage] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:(UIControlStateNormal)];
    return button;
}
@end
