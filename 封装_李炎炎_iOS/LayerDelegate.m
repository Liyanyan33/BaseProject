//
//  LayerDelegate.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "LayerDelegate.h"

@implementation LayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    UIGraphicsPushContext(ctx);
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [[UIColor blueColor] setFill];
    [p fill];
    UIGraphicsPopContext();
}



@end
