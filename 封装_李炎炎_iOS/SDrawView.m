//
//  SDrawView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "SDrawView.h"

@implementation SDrawView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat x = (rect.size.width - 100)/2;
    CGFloat y = (rect.size.height - 100)/2;
    // 获取当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 在当前上下文上的指定位置上 绘制圆形
    CGContextAddEllipseInRect(context, CGRectMake(x, y, 100, 100));
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
}

@end
