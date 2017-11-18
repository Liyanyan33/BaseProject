//
//  UIView+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ZTEOscillatoryAnimationType){
    ZTEOscillatoryAnimationToBigger,
    ZTEscillatoryAnimationToSmaller,
};

@interface UIView (Extension)

#pragma mark 布局相关
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

#pragma mark 视图层次相关 获取view所在的视图控制器
- (UIViewController *)parentController;

#pragma mark 设置圆角边框
- (void)setCornerRadius:(CGFloat)radius borderW:(CGFloat)borderW borderCorlor:(UIColor*)corlor;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(ZTEOscillatoryAnimationType)type;

#pragma 交互事件
- (void)addTapGerstureBlock:(void(^)(void))tapBlock;

@end
