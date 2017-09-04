//
//  ZTEPhotoAccessoryView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#define labelW 100
#define btnMarginRight 20
#define btnW 22

#import "ZTEPhotoAccessoryView.h"

@interface ZTEPhotoAccessoryView ()
@property(nonatomic,strong)UILabel *photoIndexLabel;
@property(nonatomic,strong)UIButton *downImageBtn;
@end

@implementation ZTEPhotoAccessoryView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.photoIndexLabel];
    [self addSubview:self.downImageBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.photoIndexLabel.frame = CGRectMake(0, 0, kScreenWidth, h);
    self.photoIndexLabel.centerX = w/2;
    self.downImageBtn.frame = CGRectMake(w - btnMarginRight - btnW, 0, btnW, btnW);
    self.downImageBtn.centerY = h/2;
}

#pragma mark 监听事件 下载图片
- (void)downImage:(UIButton*)sender{
    
}

#pragma mark 懒加载
- (UILabel*)photoIndexLabel{
    if (!_photoIndexLabel) {
        _photoIndexLabel = [ZTEUIKit labelWithText:@"1/10" font:ScreenFitFont(15) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        _photoIndexLabel.backgroundColor = [UIColor clearColor];
    }
    return _photoIndexLabel;
}

- (UIButton*)downImageBtn{
    if (!_downImageBtn) {
        _downImageBtn = [ZTEUIKit buttonWtihNormalText:nil font:nil normalTextColor:nil normalImage:@"picture_download_icon.png"];
        [_downImageBtn addTarget:self action:@selector(downImage:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _downImageBtn;
}
@end
