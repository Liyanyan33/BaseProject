//
//  Test_TwoController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "Test_TwoController.h"

@interface Test_TwoController ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation Test_TwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试控制器_02";
    NSLog(@"执行片段>>>");
    [self createUI];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时操作
        NSURL *url = [NSURL URLWithString:@"http://img.ztehealth.com/Uploads/2016129155635a.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"执行片段<<<");
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新UI
            NSLog(@"执行片段xxx");
            self.imageView.image = image;
        });
    });
    
    NSLog(@"执行片段---");
}

- (void)createUI{
    [self.view addSubview:self.imageView];
}

#pragma mak 懒加载
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 150)];
    }
    return _imageView;
}

@end
