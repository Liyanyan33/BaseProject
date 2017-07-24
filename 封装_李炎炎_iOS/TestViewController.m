//
//  TestViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TestViewController.h"
#import "ZTEEmojiKeyBoard.h"
#import "ZTEEmojiTextView.h"
#import "ZTEEmotionModel.h"
#import "ZTESearchBar.h"
#import "ZTEChatToolBar.h"
#import "ZTEDropMenu.h"
#import "ZTEActionSheet.h"
#import "ZTEPickView.h"

@interface TestViewController ()<ZTEChatToolBarDelegate,UITextViewDelegate>
@property(nonatomic,strong)ZTEChatToolBar *toolBar;
@property(nonatomic,strong)ZTEEmojiTextView *emojiTextView;
@property(nonatomic,strong)ZTEDropMenu *menu;;
@property(nonatomic,strong)ZTEActionSheet *acSheet;
@property(nonatomic,strong)ZTEPickView *pickView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    [self createUI];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)createUI{
    [self.view addSubview:self.emojiTextView];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.menu];
}

- (void)navBarRightClick{
    _pickView = [ZTEPickView pickView];
    [_pickView show];
}

#pragma mark ZTEToolBarDelegate
- (void)toolBar:(ZTEChatToolBar *)toolBar sendInputText:(NSString *)inputText{
    NSLog(@"输入的内容 = %@",inputText);
    
}


 #pragma mark UITextViewDelegate  每输入文字 都会调用此方法  UITextView默认存在内边距 计算文本size的时候要做考虑
 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
     NSLog(@"%s",__func__);
//     NSString *completeStr = [NSString stringWithFormat:@"%@%@",textView.text,text];
//     if ([text isEqualToString:@""]) { // 删除字符
//     if (![textView.text isEqualToString:@""]) {
//     completeStr = [completeStr substringToIndex:completeStr.length - 1];
//     }
//     }
//     CGSize textSize = [completeStr sizeWithFont:textView.font withWidth:textView.width-5*2];
//     NSLog(@"textSize = %@",NSStringFromCGSize(textSize));
//     [UIView animateWithDuration:0.5f animations:^{
//     textView.height = textSize.height + textView.textContainerInset.top*2;
//     }];
     return YES;
 }

- (void)textViewDidChange:(UITextView *)textView{
    // 通过contentSize 实现textView内容的自适应
    NSLog(@"contentSize = %@",NSStringFromCGSize(textView.contentSize));
    [UIView animateWithDuration:0.25 animations:^{
        _emojiTextView.height = textView.contentSize.height;
    } completion:^(BOOL finished) {
        
    }];
}
 

#pragma mak 懒加载
- (ZTEChatToolBar*)toolBar{
    if (!_toolBar) {
        _toolBar = [[ZTEChatToolBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - 48 , kScreenWidth, 48) withTargetVC:self];
        _toolBar.delegate = self;
    }
    return _toolBar;
}

#pragma mak 懒加载
- (ZTEEmojiTextView*)emojiTextView{
    if (!_emojiTextView) {
        _emojiTextView = [[ZTEEmojiTextView alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 60)];
        _emojiTextView.delegate = self;
        _emojiTextView.placeHolder = @"说点什么呢...";
        _emojiTextView.font = [UIFont systemFontOfSize:16];
        _emojiTextView.layer.masksToBounds = YES;
        _emojiTextView.layer.cornerRadius = 5.0;
        _emojiTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _emojiTextView.layer.borderWidth = 2.0;
    }
    return _emojiTextView;
}

#pragma mak 懒加载
- (ZTEDropMenu*)menu{
    if (!_menu) {
        _menu = [[ZTEDropMenu alloc]initWithFrame:CGRectMake(20, 200, 100, 30)];
        [_menu setTitle:@[@"1",@"2",@"3",@"4"] rowHeight:44];
    }
    return _menu;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"输入框 内容size = %@",NSStringFromCGSize(_emojiTextView.contentSize));
    [self.toolBar hideToBottom];
}
@end
