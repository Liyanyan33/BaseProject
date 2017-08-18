//
//  DrawTextController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "DrawTextController.h"
#import "DrawTextView.h"

@interface DrawTextController ()

@end

@implementation DrawTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制文本";
    DrawTextView *dtv = [[DrawTextView alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 200)];
    dtv.backgroundColor = RGBColor(211, 255, 242);
    [self.view addSubview:dtv];
    
}


@end
