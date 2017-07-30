//
//  SixController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "SixController.h"

@interface SixController ()

@end

@implementation SixController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);

    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
    CGContextFillPath(con);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 200, 200)];
    imageView.image = image;
    [self.view addSubview:imageView];

}



@end
