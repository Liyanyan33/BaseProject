//
//  BaseView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  普通View的基类

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
}

- (void)configWithViewModel:(id)viewModel{
    
}
@end
