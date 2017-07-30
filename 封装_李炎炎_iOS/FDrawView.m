//
//  FDrawView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FDrawView.h"

@implementation FDrawView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
    CGFloat x = (rect.size.width - 100)/2;
    CGFloat y = (rect.size.height - 100)/2;
    // 创建一条贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, 100, 100)];
    // 设置填充颜色
    [[UIColor blueColor] setFill];
    [path fill];
}
@end
