//
//  OnLineCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "OnLineCell.h"
#import "OnLineResponModel.h"
#import "ZTELabel.h"

static CGFloat marginTop = 15;
static CGFloat marginLeft = 12;
static CGFloat marginRight = 12;
static CGFloat marginBottom = 15;
static CGFloat btnWidth = 60;
static CGFloat btnHeight = 25;

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
    AddressModel *adressModel = (AddressModel*)model;
    _nameLabel.text = adressModel.customerName;
    CGSize name_size = [NSString getBoundSizeWithText:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(marginLeft, marginTop, name_size.width, name_size.height);
    
    _numberLabel.text = adressModel.phoneNumber;
    CGSize number_size = [NSString getBoundSizeWithText:_numberLabel.text font:_numberLabel.font];
    _numberLabel.frame = CGRectMake(kScreenWidth - marginRight - number_size.width, marginTop, number_size.width, number_size.height);
    
    _contentLabel.text = adressModel.detailAddress;
    if (adressModel.isExpand) { // 展开
        CGSize content_size = [_contentLabel.text sizeWithFont:_contentLabel.font withWidth:kScreenWidth - marginLeft - marginRight];
        _contentLabel.frame = CGRectMake(marginLeft, CGRectGetMaxY(_nameLabel.frame) + marginTop, content_size.width, content_size.height);
    }else{ // 不展开
        /** 计算一行文本的高度 */
        CGSize one_row_size = [@"one" sizeWithFont:_contentLabel.font withWidth:kScreenWidth - marginLeft*2];
        /** 计算整体文本的高度 */
        CGSize text_size = [adressModel.detailAddress sizeWithFont:_contentLabel.font withWidth:kScreenWidth - 12*2];
        /** 整个文本的高度大于三行 三行显示 否则 有多高显示多高 */
        CGFloat  text_height = text_size.height >= one_row_size.height*3 ? one_row_size.height*3:text_size.height;
        CGFloat text_width =  text_size.height >= one_row_size.height*3 ? kScreenWidth - marginLeft*2:text_size.width;
       _contentLabel.frame = CGRectMake(marginLeft, CGRectGetMaxY(_nameLabel.frame) + marginTop, text_width, text_height);
    }
    _chaBtn.frame = CGRectMake(kScreenWidth - marginRight - btnWidth - btnWidth - marginLeft, CGRectGetMaxY(_contentLabel.frame)+marginTop, btnWidth, btnHeight);
    _deleBtn.frame = CGRectMake(CGRectGetMaxX(_chaBtn.frame)+marginLeft, _chaBtn.frame.origin.y, btnWidth, btnHeight);
    
    self.cellHeight = CGRectGetMaxY(_chaBtn.frame) + marginBottom;
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
