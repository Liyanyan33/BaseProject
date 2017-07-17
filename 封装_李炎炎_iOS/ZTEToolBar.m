//
//  ZTEToolBar.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/12.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  聊天工具栏 主要包括 内容输入框 表情按钮  表情键盘面板 

#import "ZTEToolBar.h"
#import "ZTEEmojiTextView.h"
#import "ZTEEmojiKeyBoard.h"

#define textViewMarginLeft 6
#define textViewMarginTop 6
#define emojiBtnW 30
#define emojiBtnMarginRight 6
#define emojiBtnMarginLeft 6

@interface ZTEToolBar ()<UITextViewDelegate,ZTEEmojiKeyBoardDelegate>
@property(nonatomic,strong)ZTEEmojiTextView *textView;  // 输入框
@property(nonatomic,strong)UIButton *emojiBtn;  // 表情按钮
@property(nonatomic,strong)ZTEEmojiKeyBoard *emojiKeyBoard;  // 表情面板
@property(nonatomic,weak)UIViewController *targetVC;  // toolBar 被添加到的 控件(父控件)
@property(nonatomic,assign)BOOL isSwitchingKeyboard;  // 是否正在切换键盘
@end

@implementation ZTEToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(145, 173, 144);
        self.inputState = UITextViewInputStateSystem;  // 默认为系统键盘
        [self createUI];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withTargetVC:(UIViewController *)targetVC{
    _targetVC = targetVC;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(145, 173, 144);
        [self createUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)createUI{
    [self addSubview:self.textView];
    [self addSubview:self.emojiBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.textView.frame = CGRectMake(textViewMarginLeft, textViewMarginTop, w - textViewMarginLeft - emojiBtnMarginRight - emojiBtnW - emojiBtnMarginLeft, h - textViewMarginTop*2);
    self.emojiBtn.frame = CGRectMake(CGRectGetMaxX(self.textView.frame)+emojiBtnMarginLeft, 0, emojiBtnW, emojiBtnW);
    self.emojiBtn.centerY = h/2;
}

#pragma mark 监听回调
/** 当键盘的frame发生变化时调用 */
- (void)keyBoardFrameChange:(NSNotification*)notification{
    NSLog(@"%s",__func__);
    if (self.inputState == UITextViewInputStateSystem && [_textView isFirstResponder]) {
        //1> 获取键盘frame
        CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue];
        //2> 获取动画时间
        NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 3> 执行动画
        UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            //设置动画结束时 输入视图的位置
            self.y = keyboardFrame.origin.y - self.height;
        } completion:nil];
    }
}

- (void)emojiBtnClick:(UIButton*)sender{
    CGFloat emojiKeyboardY = kScreenHeight;
    if (self.inputState == UITextViewInputStateEmoji) {
        self.inputState = UITextViewInputStateSystem;
        [_textView becomeFirstResponder];  //弹出系统键盘
    }else{
        self.inputState = UITextViewInputStateEmoji;
        [_textView resignFirstResponder];  // 退出系统键盘
        emojiKeyboardY = kScreenHeight - self.emojiKeyBoard.height;  // 显示表情键盘
    }
    [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.emojiKeyBoard.y = emojiKeyboardY;
        if (kScreenHeight - emojiKeyboardY > 0) {
            self.y = emojiKeyboardY - self.height;
        }
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark UITextViewDelegate
// 当textView被点击 开始编辑的时候 的回调
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"%s",__func__);
    if (self.inputState != UITextViewInputStateSystem) {
        self.inputState = UITextViewInputStateSystem;
        [UIView animateWithDuration:0.25 delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            _emojiKeyBoard.y = kScreenHeight;
        } completion:^(BOOL finished) {
            self.inputState = UITextViewInputStateSystem;
        }];
    }
    return YES;
}

// UITextFieldDelegate代理里面响应return键的回调:textFieldShouldReturn:。
// 但是 UITextView的代理UITextViewDelegate 里面并没有这样的回调 可以通过判断输入的字是否是回车，即按下return
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if ([self.delegate respondsToSelector:@selector(toolBar:sendInputText:)]) {
            [self.delegate toolBar:self sendInputText:_textView.fullText];
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%s",__func__);
    NSLog(@"内容size = %@",NSStringFromCGSize(textView.contentSize));
    [UIView animateWithDuration:0.25 animations:^{
        _textView.height = textView.contentSize.height;
        self.height = _textView.height + textViewMarginTop*2;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark ZTEEmojiKeyBoardDelegate
- (void)zteEmojiKeyBoard:(ZTEEmojiKeyBoard *)zteEmojiKeyBoard emojiBtnClickModel:(ZTEEmotionModel *)model{
    [_textView insertEmotionModel:model];
}

- (void)deleteBtnClickZteEmojiKeyBoard:(ZTEEmojiKeyBoard *)zteEmojiKeyBoard{
    [_textView deleteBackward];
}

- (void)zteEmojiKeyBoard:(ZTEEmojiKeyBoard *)zteEmojiKeyBoard sendBtnClick:(UIButton *)sendButton{
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(toolBar:sendInputText:)]) {
        [self.delegate toolBar:self sendInputText:_textView.fullText];
    }
}

#pragma mak 懒加载
- (ZTEEmojiTextView*)textView{
    if (!_textView) {
        _textView = [[ZTEEmojiTextView alloc]init];
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 5.0;
        _textView.placeHolder = @"说点什么....";
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.returnKeyType = UIReturnKeySend;  // 修改键盘 return按钮的文字
        _textView.delegate = self;
    }
    return _textView;
}

#pragma mak 懒加载
- (UIButton*)emojiBtn{
    if (!_emojiBtn) {
        _emojiBtn = [[UIButton alloc]init];
        [_emojiBtn setImage:[UIImage imageNamed:@"keyboard_emotion@2x.png"] forState:(UIControlStateNormal)];
        [_emojiBtn addTarget:self action:@selector(emojiBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _emojiBtn;
}

#pragma mak 懒加载
- (ZTEEmojiKeyBoard*)emojiKeyBoard{
    if (!_emojiKeyBoard) {
        _emojiKeyBoard = [[ZTEEmojiKeyBoard alloc]initWithFrame:CGRectMake(0, kScreenHeight - 216, kScreenWidth, 216)];
        _emojiKeyBoard.delegate = self;
        [_targetVC.view addSubview:_emojiKeyBoard];
    }
    return _emojiKeyBoard;
}

/**
 #pragma mark UITextViewDelegate  每输入文字 都会调用此方法  UITextView默认存在内边距 计算文本size的时候要做考虑
 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
 NSLog(@"%s",__func__);
 NSString *completeStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
 if ([text isEqualToString:@""]) { // 删除字符
 if (![textView.text isEqualToString:@""]) {
 completeStr = [completeStr substringToIndex:completeStr.length - 1];
 }
 }
 CGSize textSize = [completeStr sizeWithFont:textView.font withWidth:textView.width-5*2];
 NSLog(@"textSize = %@",NSStringFromCGSize(textSize));
 [UIView animateWithDuration:0.5f animations:^{
 textView.height = textSize.height + textView.textContainerInset.top*2;
 }];
 return YES;
 }
 */
@end
