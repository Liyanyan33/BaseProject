//
//  OneLabelCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "OneLabelCell.h"

#define labelMarginLeft 10
#define labelMarginTop 10
#define labelMarginBottom 10
#define lineH 3

@interface OneLabelCell ()
@property(nonatomic,strong)UILabel *txtLabel;
@property(nonatomic,strong)UIView *line;
@end

@implementation OneLabelCell

- (void)createUI{
    [self addSubview:self.txtLabel];
    [self addSubview:self.line];
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    NSString *txtStr = (NSString*)model;
    _txtLabel.text = txtStr;
    CGSize txtSize = [txtStr sizeWithFont:_txtLabel.font withWidth:kScreenWidth - labelMarginLeft*2];
    _txtLabel.frame = CGRectMake(labelMarginLeft, labelMarginTop, kScreenWidth - labelMarginLeft*2, txtSize.height);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.txtLabel.frame)+labelMarginBottom, kScreenWidth, lineH);
}

+ (CGFloat)calCellHeightWithModel:(id)modelData{
    NSString *txtStr = (NSString*)modelData;
    CGFloat cellHeight = 0;
    cellHeight+=labelMarginTop;
    CGSize txtSize = [txtStr sizeWithFont:ScreenFitFont(17) withWidth:kScreenWidth - labelMarginLeft*2];
    cellHeight+=txtSize.height;
    cellHeight+=labelMarginBottom;
    cellHeight+=lineH;
    return cellHeight;
}

#pragma mark 懒加载
- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
        _txtLabel.font = ScreenFitFont(17);
        _txtLabel.numberOfLines = 0;
        _txtLabel.textColor = [UIColor redColor];
    }
    return _txtLabel;
}

- (UIView*)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}
@end
