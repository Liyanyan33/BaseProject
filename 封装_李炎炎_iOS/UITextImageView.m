//
//  UITextImageView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "UITextImageView.h"

#pragma mark 不同尺寸屏幕下的imageView图片尺寸
#define  i5ImageWidth   60
#define  i6ImageWidth   80
#define  i6PImageWidth 90
#define  iPadWidth         170
#define  labelHeight        35

#pragma mark 为了缩减imageView图片的尺寸 缩减之后上移图片(Y轴偏移量)
#define  imageYOffset    20

@interface UITextImageView ()
@property(nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,assign)CGFloat imageWidth;

@end

@implementation UITextImageView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setData];
        [self createUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setData];
        [self createUI];
    }
    return self;
}

- (void)setData{

    if (isiPhone5) {
        _imageWidth = i5ImageWidth;
    }else if (isiPhone6){
        _imageWidth = i6ImageWidth;
    }else if (isiPhone6P){
        _imageWidth = i6PImageWidth;
    }else if (isiPad){
        _imageWidth = iPadWidth;
    }
}

- (void)createUI{
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

- (void)setTitle:(NSString *)text image:(NSString *)image{
    _label.text = text;
    _imageView.image = [UIImage imageNamed:image];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CGFloat imageX = w/2 - _imageWidth/2;
    CGFloat imageY = h - _imageWidth - labelHeight;
    if (_imageWidth >= iPadWidth) {
        imageY = h - _imageWidth - labelHeight - imageYOffset;
    }
    NSLog(@"imageX = %f---imageY = %f--imageWidth = %f--w = %f",imageX,imageY,_imageWidth,w);
    self.imageView.frame = CGRectMake(imageX, imageY, _imageWidth, _imageWidth);
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), w, labelHeight);
}

#pragma mark 懒加载
- (UIImageView*)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
    }
    return _backgroundImageView;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UILabel*)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont getFont];
        _label.backgroundColor = [UIColor brownColor];
        _label.userInteractionEnabled = YES;
    }
    return _label;
}
@end
