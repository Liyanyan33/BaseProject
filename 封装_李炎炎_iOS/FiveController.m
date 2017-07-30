//
//  FiveController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FiveController.h"

@interface FiveController ()

@end

@implementation FiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 200, 200)];
    imageView.image = image;
    [self.view addSubview:imageView];
}
@end
