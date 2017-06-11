//
//  OnLineCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "OnLineCell.h"
#import "OnLineResponModel.h"
#import "AdressViewModel.h"
#import "ZTELabel.h"

@interface OnLineCell ()
@property(nonatomic,strong)ZTELabel *nameLabel;
@property(nonatomic,strong)ZTELabel *numberLabel;
@property(nonatomic,strong)ZTELabel *contentLabel;
@property(nonatomic,strong)UIButton *chaBtn;
@property(nonatomic,strong)UIButton *deleBtn;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation OnLineCell

- (void)createUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.numberLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.chaBtn];
    [self addSubview:self.deleBtn];
}

- (void)click:(UIButton*)sender{
    if (_btnBlock) {
        _btnBlock((int)sender.tag);
    }
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    AdressViewModel *adressViewModel = (AdressViewModel*)model;
    AddressModel *adressModel = adressViewModel.adressModel;
    
    _nameLabel.text = adressModel.customerName;
    _nameLabel.frame = adressViewModel.name_frame;
    
    _numberLabel.text = adressModel.phoneNumber;
    _numberLabel.frame = adressViewModel.number_frame;
    
    _contentLabel.text = adressModel.detailAddress;
    _contentLabel.frame = adressViewModel.content_frame;
    
    _chaBtn.frame = adressViewModel.chakan_frame;
    _deleBtn.frame = adressViewModel.dele_frame;
}

#pragma mark 监听事件
- (void)tap:(UITapGestureRecognizer*)sender{
    if (_clickContentLabelBlock) {
        _clickContentLabelBlock(_indexPath);
    }
}

#pragma mark 懒加载
- (ZTELabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[ZTELabel alloc]initWithText:@"用户姓名" withFontSize:17];
    }
    return _nameLabel;
}
- (ZTELabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[ZTELabel alloc]initWithText:@"电话号码" withFontSize:15];
        _numberLabel.backgroundColor = [UIColor greenColor];
    }
    return _numberLabel;
}
- (ZTELabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[ZTELabel alloc]initWithFontSize:18];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor orangeColor];
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_contentLabel addGestureRecognizer:tap];
    }
    return _contentLabel;
}
- (UIButton*)chaBtn{
    if (!_chaBtn) {
        _chaBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 75 - 20 - 10 - 75, 10, 75, 30)];
        [_chaBtn setTitle:@"查看" forState:(UIControlStateNormal)];
        [_chaBtn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        _chaBtn.backgroundColor = randomColor;
        [_chaBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        _chaBtn.tag = 100;
    }
    return _chaBtn;
}
- (UIButton*)deleBtn{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 75 - 20, 10, 75, 30)];
        [_deleBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleBtn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        _deleBtn.backgroundColor = randomColor;
        [_deleBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        _deleBtn.tag = 101;
    }
    return _deleBtn;
}
@end
