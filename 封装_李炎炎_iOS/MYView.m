//
//  MYView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/23.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "MYView.h"

@interface MYView ()
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation MYView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{

    UILabel *label = [[UILabel alloc]init];
    label.text = @"sfdsafdsadsgd";
    label.backgroundColor = [UIColor redColor];
    [self addSubview:label];
    self.lable = label;
    
    UIImageView *iv = [[UIImageView alloc]init];
    iv.backgroundColor = [UIColor greenColor];
    [self addSubview:iv];
    self.imageView = iv;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.lable.frame = CGRectMake(0, 0, w/2, h);
    self.imageView.frame = CGRectMake(w/2, 0, w/2, h);
    
}

@end
