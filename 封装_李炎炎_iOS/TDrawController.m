//
//  TDrawController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TDrawController.h"
#import "TDrawView.h"
#import "LayerDelegate.h"

@interface TDrawController ()<CALayerDelegate>
@property(nonatomic,strong)CALayer *layer;

@end

@implementation TDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TDrawView *tDrawView = [[TDrawView alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 200)];
    tDrawView.backgroundColor = [UIColor redColor];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor=[UIColor brownColor].CGColor;
    layer.bounds=CGRectMake(0, 0, 200, 150);
    layer.anchorPoint=CGPointZero;
    layer.position=CGPointMake(0, 0);
    layer.delegate = self;
    [tDrawView.layer addSublayer:layer];
    [layer setNeedsDisplay];
    _layer = layer;
    [self.view addSubview:tDrawView];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    UIGraphicsPushContext(ctx);
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [[UIColor blueColor] setFill];
    [p fill];
    UIGraphicsPopContext();
}

- (void)dealloc{
    _layer.delegate = nil;  //必须要设置 否则会出现 闪退
}
@end
