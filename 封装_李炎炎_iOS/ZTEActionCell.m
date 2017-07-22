//
//  ZteCell.m
//  自定义Sheet
//
//  Created by lyy on 17/3/29.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import "ZTEActionCell.h"

@interface ZTEActionCell ()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIView *line;
@end

@implementation ZTEActionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.label];
    [self addSubview:self.line];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _label.frame = CGRectMake(0, 0, w, h-1);
    _line.frame = CGRectMake(0, h-1, w, 1);
}

- (void)setTxt:(NSString *)txt{
    _label.text = txt;
}

- (UILabel*)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:18];
    }
    return _label;
}

- (UIView*)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor greenColor];
    }
    return _line;
}
@end
