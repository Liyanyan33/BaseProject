//
//  ZTETextImageView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/19.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTETextImageView.h"

#define imageMarginLeft 10
#define imageW 20

#define textLabelMarginLeft 5
#define textLabelMarginRight 10

@interface ZTETextImageView ()
@property(nonatomic,strong)UIView *contentView;  // 图片+文字 的容器视图
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *textLabel;
@end

@implementation ZTETextImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.imageView.frame = CGRectMake(imageMarginLeft, 0, imageW, imageW);
    CGSize textSize = [NSString getBoundSizeWithText:_textLabel.text font:_textLabel.font];
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+textLabelMarginLeft, 0, textSize.width, textSize.height);
    
    self.contentView.frame = CGRectMake(0, 0, imageMarginLeft + imageW + textLabelMarginLeft + textSize.width + textLabelMarginRight, h);
    self.contentView.centerX = w/2;
    self.imageView.centerY = h/2;
    self.textLabel.centerY = self.imageView.centerY;
}

- (void)setText:(NSString *)text{
    _text = text;
    _textLabel.text = text;
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    _imageView.image = [UIImage imageNamed:imageStr];
}

#pragma mak 懒加载
- (UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (UILabel*)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:15];
    }
    return _textLabel;
}
@end

