//
//  TestViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TestViewController.h"
#import "ZTEEmojiKeyBoard.h"

@interface TestViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)ZTEEmojiKeyBoard *emojiKeyBoard;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    [self createUI];
    
    NSLog(@"内边距 = %@",NSStringFromUIEdgeInsets(self.textView.textContainerInset));
}

- (void)createUI{
//    [self.view addSubview:self.textView];
    [self.view addSubview:self.emojiKeyBoard];
}

#pragma mark 懒加载
- (UITextView*)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 64+20, kScreenWidth - 10*2, 150)];
        _textView.backgroundColor = [UIColor redColor];
        _textView.text = @"大看的撒发的卡开发决定撒范德萨啦富家大室拉房间大理石";
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:19];
        _textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        _textView.delegate = self;
    }
    return _textView;
}

- (ZTEEmojiKeyBoard*)emojiKeyBoard{
    if (!_emojiKeyBoard) {
        _emojiKeyBoard = [[ZTEEmojiKeyBoard alloc]initWithFrame:CGRectMake(0, 300, kScreenWidth, 216)];
    }
    return _emojiKeyBoard;
}

@end
