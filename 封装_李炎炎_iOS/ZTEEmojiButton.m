//
//  ZTEEmojiButton.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/6.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘中的 表情按钮

#import "ZTEEmojiButton.h"

@implementation ZTEEmojiButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotjiModel:(ZTEEmotionModel *)emotjiModel{
    _emotjiModel = emotjiModel;
    if (emotjiModel.png) { // 有图片 非emoji表情
        [self setImage:[UIImage imageNamed:emotjiModel.png] forState:UIControlStateNormal];
    } else if (emotjiModel.code) { // 是emoji表情 其实是文字 需要经过解码 显示(看起来像图片)
        // 设置emoji
        [self setTitle:emotjiModel.code.emoji forState:UIControlStateNormal];
    }
}

@end
