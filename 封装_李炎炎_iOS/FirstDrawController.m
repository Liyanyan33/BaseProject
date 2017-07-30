//
//  FirstDrawController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FirstDrawController.h"
#import "FDrawView.h"

@interface FirstDrawController ()

@end

@implementation FirstDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在UIView的子类方法drawRect";
    
    FDrawView *fDrawView = [[FDrawView alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 200)];
    [self.view addSubview:fDrawView];
}

@end
