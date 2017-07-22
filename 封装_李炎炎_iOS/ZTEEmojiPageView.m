//
//  ZTEEmojiPageView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  ZTEEmojiModuleView 模块view中滚动视图的 pageView (分页 滚动显示)

#import "ZTEEmojiPageView.h"
#import "ZTEEmojiPopView.h"

@interface ZTEEmojiPageView ()
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)ZTEEmojiPopView *popView;
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
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
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
        btn.x = inset + (i%ZTEEmotionMaxCols) * btnW;
        btn.y = inset + (i/ZTEEmotionMaxCols) * btnH;
    }
    // 删除按钮
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.y = h - btnH;
    self.deleteBtn.x = w - inset - btnW;
}

/** 表情按钮 被点击 */
- (void)btnClick:(ZTEEmojiButton*)sender{
    if (_emojiBtnClick) {
        _emojiBtnClick(sender.emotjiModel);
    }
}

/** 删除按钮 被点击 */
- (void)deleteClick:(UIButton*)sender{
    if (_deleteBtnClick) {
        _deleteBtnClick();
    }
}

/** 长按手势 回调 */
- (void)longPress:(UILongPressGestureRecognizer*)sender{
    // 获取长按的位置坐标
    CGPoint location = [sender locationInView:sender.view];
    // 根据长按位置坐标 获取被长按的表情按钮
    ZTEEmojiButton *curEmotionBtn = [self emotionButtonWithLocaion:location];
    // 手势状态的判断
    switch (sender.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView dismiss];
            
            // 如果手指还在表情按钮上
            if (curEmotionBtn) {
                // 发出通知
//                [self selectEmotion:btn.emotion];
            }
            break;
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            [self.popView showFrom:curEmotionBtn];
            break;
        }
        default:
            break;
    }
}

- (ZTEEmojiButton*)emotionButtonWithLocaion:(CGPoint)location{
    NSUInteger count = self.emojiArr.count;
    for (int i = 0; i < count; i++) {
        ZTEEmojiButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
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

#pragma mak 懒加载
- (ZTEEmojiPopView*)popView{
    if (!_popView) {
        _popView = [ZTEEmojiPopView popView];
    }
    return _popView;
}
@end
