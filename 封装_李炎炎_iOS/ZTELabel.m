//
//  ZTELabel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/9.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTELabel.h"

// 默认字体大小
#define defaultFont 17

@interface ZTELabel ()
@property(nonatomic,copy)NSString *txt;
@property(nonatomic,assign)CGFloat fontSize;
@end

@implementation ZTELabel

- (instancetype)initWithText:(NSString *)text{
    return [self initWithText:text withFontSize:defaultFont];
}

- (instancetype)initWithFontSize:(CGFloat)fontSize{
    return [self initWithText:nil withFontSize:fontSize];
}

- (instancetype)initWithText:(NSString *)text withFontSize:(CGFloat)fontSize{
    _txt = text;
    _fontSize = fontSize;
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.text = _txt;
    self.font = [UIFont systemFontOfSize:_fontSize];
}

@end
