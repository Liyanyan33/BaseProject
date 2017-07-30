//
//  BaseTextController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "BaseTextController.h"

@interface BaseTextController ()

@end

@implementation BaseTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    [self createUI];
}


- (void)createUI{
    
}

- (void)setText:(NSString *)text{
    _text = [text copy];
    if (_textView) {
        _textView.text = text;
    }
}

#pragma mak 懒加载
- (UITextView*)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _textView.font = [UIFont systemFontOfSize:17];
        [_textView setEditable:NO];
    }
    return _textView;
}
@end
