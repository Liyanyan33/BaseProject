//
//  UILabel+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/11/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (UILabel*)labelWithText:(NSString *)text{
    return [self labelWithText:text font:nil];
}

+ (UILabel*)labelWithFont:(UIFont *)font{
    return [self labelWithText:nil font:font];
}

+ (UILabel*)labelWithText:(NSString*)text font:(UIFont*)font{
    return [self labelWithText:text textColor:nil font:font numberLine:0 textAlignment:NSTextAlignmentLeft backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    return [self labelWithText:text textColor:nil font:font numberLine:0 textAlignment:textAlignment backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text  font:(UIFont*)font textColor:(UIColor *)textColor{
    return [self labelWithText:text textColor:textColor font:font numberLine:0 textAlignment:NSTextAlignmentLeft backgroundColor:nil];
}

+ (UILabel*)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    return [self labelWithText:text textColor:textColor font:font numberLine:0 textAlignment:textAlignment backgroundColor:nil];
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

@end
