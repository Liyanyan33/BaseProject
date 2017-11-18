//
//  UIButton+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/10/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

typedef void(^blockHandler)(void);

@interface UIButton ()
@property(nonatomic,copy)blockHandler blockHandler;

@end

@implementation UIButton (Extension)
+ (UIButton*)buttonWtihNormalText:(NSString *)normalText{
    return [self buttonWtihNormalText:normalText font:nil];
}

+ (UIButton*)buttonWithnormalImage:(NSString *)normalImage{
    return [self buttonWtihNormalText:nil font:nil normalImage:normalImage];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font{
    return [self buttonWtihNormalText:normalText font:font normalTextColor:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalImage:(NSString *)normalImage{
    return [self buttonWtihNormalText:normalText font:font normalTextColor:nil normalImage:normalImage normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor{
    return [self buttonWtihNormalText:normalText font:font normalTextColor:normalTextColor normalImage:nil normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString *)normalImage{
    return [self buttonWtihNormalText:normalText font:font normalTextColor:normalTextColor normalImage:normalImage normalBackgroundImage:nil];
}

+ (UIButton*)buttonWtihNormalText:(NSString *)normalText font:(UIFont *)font normalTextColor:(UIColor *)normalTextColor normalImage:(NSString *)normalImage normalBackgroundImage:(NSString *)normalBackgroundImage {
    UIButton *button = [[self alloc]init];
    [button setTitle:normalText forState:(UIControlStateNormal)];
    [button setTitleColor:normalTextColor forState:(UIControlStateNormal)];
    button.titleLabel.font = font;
    [button setImage:[UIImage imageNamed:normalImage] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:(UIControlStateNormal)];
    return button;
}

static char overviewKey;

- (void)addClickBlock:(void (^)(void))blockHandler{
    objc_setAssociatedObject(self, &overviewKey, blockHandler,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:)forControlEvents:UIControlEventTouchUpInside];
}

- (void)callActionBlock:(UIButton*)sender{
     blockHandler block = (blockHandler)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}
@end
