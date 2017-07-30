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
#import <YYKit.h>

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
    
    [self createYYKitControl];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)createUI{
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.menu];
}

- (void)createYYKitControl{
    NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc]initWithString:@"Shadow"];
    one.font = [UIFont systemFontOfSize:20];
    one.color = [UIColor whiteColor];
    
    // 创建YYTextShadow对象
    YYTextShadow *shadow = [YYTextShadow new];
    shadow.color = [UIColor colorWithWhite:0.00 alpha:0.490];
    shadow.radius = 5.0;
    // 将创建的YYTextShadow对象绑定到属性字符串里面
    one.textShadow = shadow;
    [textAtt appendAttributedString:one];
    
    YYLabel *label = [YYLabel new];
    label.text = @"1234567890";
    label.width = self.view.width;
    label.height = 60;
    label.top = 100;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:label];
}

- (void)navBarRightClick{
    _pickView = [ZTEPickView pickView];
    [_pickView show];
}

#pragma mark ZTEToolBarDelegate
- (void)toolBar:(ZTEChatToolBar *)toolBar sendInputText:(NSString *)inputText{
    NSLog(@"输入的内容 = %@",inputText);
    
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
- (ZTEDropMenu*)menu{
    if (!_menu) {
        _menu = [[ZTEDropMenu alloc]initWithFrame:CGRectMake(20, 200, 100, 30)];
        [_menu setTitle:@[@"1",@"2",@"3",@"4"] rowHeight:44];
    }
    return _menu;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
//    NSLog(@"输入框 内容size = %@",NSStringFromCGSize(_emojiTextView.contentSize));
    [self.toolBar hideToBottom];
}
@end
