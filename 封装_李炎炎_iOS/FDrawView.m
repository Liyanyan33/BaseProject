//
//  FDrawView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FDrawView.h"

@implementation FDrawView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat x = (rect.size.width - 100)/2;
    CGFloat y = (rect.size.height - 100)/2;
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x,y,100,100)];
    [[UIColor blueColor] setFill];
    [p fill];
}

@end
