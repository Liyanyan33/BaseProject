//
//  WBBottomToolBar.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "WBBottomToolBar.h"

@interface WBBottomToolBar ()
@property(nonatomic,strong)NSArray *textArr;
@property(nonatomic,strong)NSArray *imageArr;
@property(nonatomic,strong)NSMutableArray *buttonArr;
@end

@implementation WBBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)reloadData{
    _textArr = [self.dataSource bottomToolBarForTextArr:self];
    _imageArr = [self.dataSource bottomToolBarForImageArr:self];
    for (int i = 0; i < _textArr.count; i++) {
        UIButton *btn = [ZTEUIKit buttonWtihNormalText:_textArr[i] font:ScreenFitFont(14) normalTextColor:[UIColor grayColor] normalImage:_imageArr[i]];
        // 设置高亮状态下的背景图片
        [btn setBackgroundImage:[UIImage imageWithColor:RGBColor(240, 240, 240)] forState:(UIControlStateHighlighted)];
        // 设置图片的偏移量 图片向左偏移5个单位
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 0) {
            btn.tag = WBBottomToolBarBtnTypeReweet;
        }else if (i == 1){
            btn.tag = WBBottomToolBarBtnTypeShare;
        }else{
            btn.tag = WBBottomToolBarBtnTypeLike;
        }
        [self addSubview:btn];
        [_buttonArr addObject:btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    int i = 0;
    for (UIButton *btn in self.buttonArr) {
        btn.width = w/3;
        btn.height = h;
        btn.y = 0;
        btn.x = btn.width * i;
        i++;
    }
}

- (void)clickBtn:(UIButton*)sender{
    if (_bottomToolBarClickBlock) {
        _bottomToolBarClickBlock(sender.tag);
    }
}
@end
