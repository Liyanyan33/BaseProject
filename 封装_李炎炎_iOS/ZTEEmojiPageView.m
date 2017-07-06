//
//  ZTEEmojiPageView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  ZTEEmojiModuleView 模块view中滚动视图的 pageView (分页 滚动显示)

#import "ZTEEmojiPageView.h"
#import "ZTEEmojiButton.h"

@interface ZTEEmojiPageView ()
@property(nonatomic,strong)UIButton *deleteBtn;
@end

@implementation ZTEEmojiPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.deleteBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    // 内边距(四周)
    CGFloat inset = 10;
    NSUInteger count = self.emojiArr.count;
    CGFloat btnW = (w - 2 * inset) / ZTEEmotionMaxCols;
    CGFloat btnH = (h - inset) / ZTEEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.backgroundColor = randomColor;
        btn.x = inset + (i%ZTEEmotionMaxCols) * btnW;
        btn.y = inset + (i/ZTEEmotionMaxCols) * btnH;
    }
    // 删除按钮
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.y = h - btnH;
    self.deleteBtn.x = w - inset - btnW;
}

- (void)btnClick:(ZTEEmojiButton*)sender{
    
}

- (void)deleteClick:(UIButton*)sender{
    
}

- (void)setEmojiArr:(NSArray *)emojiArr{
    _emojiArr = emojiArr;
    NSUInteger count = emojiArr.count;
    for (int i = 0; i<count; i++) {
        ZTEEmojiButton *btn = [[ZTEEmojiButton alloc] init];
        [self addSubview:btn];
        // 设置表情数据
        btn.emotjiModel = emojiArr[i];
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIButton*)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]init];
        [_deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [_deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
