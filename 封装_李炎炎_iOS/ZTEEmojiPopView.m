//
//  ZTEEmojiPopView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/23.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEEmojiPopView.h"

#define selfWidth 64
#define selfHeight 90

@interface ZTEEmojiPopView ()
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)ZTEEmojiButton *emotionButton;
@end

@implementation ZTEEmojiPopView

+ (instancetype)popView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, selfWidth, selfHeight);
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.backImageView];
    [self addSubview:self.emotionButton];
}

- (void)showFrom:(ZTEEmojiButton *)fromView{
    if (fromView == nil) return;
    // 给popView传递数据
    self.emotionButton.emotjiModel = fromView.emotjiModel;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [fromView convertRect:fromView.bounds toView:nil];
    
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mak 懒加载
- (UIImageView*)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
        _backImageView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
    }
    return _backImageView;
}

- (UIButton*)emotionButton{
    if (!_emotionButton) {
        _emotionButton = [[ZTEEmojiButton alloc]initWithFrame:CGRectMake(0, 0, selfWidth, selfWidth)];
    }
    return _emotionButton;
}
@end
