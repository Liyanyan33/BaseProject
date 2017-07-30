//
//  FDrawController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FDrawController.h"
#import "FourDrawView.h"

@interface FDrawController ()<CALayerDelegate>
{
    CALayer *_layer;
}
@end

@implementation FDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    FourDrawView *fView = [[FourDrawView alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 200)];
    _layer = [CALayer layer];
    _layer.backgroundColor=[UIColor brownColor].CGColor;
    _layer.bounds=CGRectMake(0, 0, 200, 150);
    _layer.anchorPoint=CGPointZero;
    _layer.position=CGPointMake(0, 0);
    _layer.delegate = self;
    [fView.layer addSublayer:_layer];
    [_layer setNeedsDisplay];
    [self.view addSubview:fView];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)dealloc{
    _layer.delegate = nil;
}
@end
