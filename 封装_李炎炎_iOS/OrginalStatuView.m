//
//  OrginalStatuView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  原创微博View

#import "OrginalStatuView.h"
#import "WBStatuViewModel.h"
#import "StatuTextView.h"
#import "ZTEJGGView.h"

@interface OrginalStatuView ()
@property(nonatomic,strong)StatuTextView *textView;
@property(nonatomic,strong)UILabel *txtLabel;
@property(nonatomic,strong)ZTEJGGView *jggView;
@property(nonatomic,strong)WBStatuViewModel *sViewModel;
@end

@implementation OrginalStatuView

- (void)createUI{
    [self addSubview:self.textView];
//    [self addSubview:self.txtLabel];
    [self addSubview:self.jggView];
}

- (void)configWithViewModel:(id)viewModel{
    _sViewModel = (WBStatuViewModel*)viewModel;
    
//    _txtLabel.attributedText = _sViewModel.statuModel.orginalAttrStr;
//    _txtLabel.frame = _sViewModel.orginalTxtFrame;
    
    _textView.attributedText = _sViewModel.statuModel.orginalAttrStr;
    _textView.frame = _sViewModel.orginalTxtFrame;
    
    _jggView.photos = _sViewModel.statuModel.pic_urls;
    _jggView.frame = _sViewModel.orginalJGGFrame;
}

#pragma mark 懒加载
#pragma mak 懒加载
- (StatuTextView*)textView{
    if (!_textView) {
        _textView = [[StatuTextView alloc]init];
    }
    return _textView;
}
- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
        _txtLabel.numberOfLines = 0;
        _txtLabel.backgroundColor = [UIColor greenColor];
    }
    return _txtLabel;
}

- (ZTEJGGView*)jggView{
    if (!_jggView) {
        _jggView = [[ZTEJGGView alloc]init];
    }
    return _jggView;
}
@end
