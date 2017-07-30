//
//  SDrawController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "SDrawController.h"
#import "SDrawView.h"

@interface SDrawController ()

@end

@implementation SDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    SDrawView *sDrawView = [[SDrawView alloc]initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 200)];
    [self.view addSubview:sDrawView];
}


@end
