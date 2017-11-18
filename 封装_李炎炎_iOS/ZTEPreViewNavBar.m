//
//  ZTEPreViewNavBar.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEPreViewNavBar.h"

@interface ZTEPreViewNavBar ()
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation ZTEPreViewNavBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.backBtn];
    [self addSubview:self.selectedBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.backBtn.frame = CGRectMake(20, (h-30)/2, 30, 30);
    self.selectedBtn.frame = CGRectMake(w - 20 - 30, (h-30)/2, 30, 30);
}

#pragma mark 监听事件
- (void)buttonClick:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (self.buttonClickBlock) {
        self.buttonClickBlock(tag);
    }
}

#pragma mark setter getter
- (UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithnormalImage:@"navi_back.png"];
        _backBtn.tag = ZTEPreViewNavBarButtonTypeBack;
        [_backBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
}

- (UIButton*)selectedBtn{
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithnormalImage:@"photo_def_previewVc.png"];
        _selectedBtn.tag = ZTEPreViewNavBarButtonTypeSelected;
        [_selectedBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _selectedBtn;
}
@end
