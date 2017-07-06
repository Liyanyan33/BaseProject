//
//  ZTEEmojiTabBar.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘 底部的 tabbar选项卡

#import "ZTEEmojiTabBar.h"
#import "ZTEEmojiTabBarButton.h"

@interface ZTEEmojiTabBar ()
@property(nonatomic,strong)ZTEEmojiTabBarButton *selectedBtn;
@end

@implementation ZTEEmojiTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    NSArray *titleArr = @[@"最近",@"默认",@"Emoji",@"浪小花"];
    NSString *normal_image = @"compose_emotion_table_mid_normal";
    NSString *select_image = @"compose_emotion_table_mid_selected";
    for (int i = 0; i < titleArr.count; i++) {
        ZTEEmojiTabBarButton *tabBar_btn = [[ZTEEmojiTabBarButton alloc]init];
        [tabBar_btn setTitle:titleArr[i] forState:(UIControlStateNormal)];
        [tabBar_btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        switch (i) {
            case 0:
                tabBar_btn.tag = ZTEEmojiTabBarButtonTypeRecent;
                normal_image = @"compose_emotion_table_left_normal";
                select_image = @"compose_emotion_table_left_selected";
                break;
            case 1:
                tabBar_btn.tag = ZTEEmojiTabBarButtonTypeDefault;
                normal_image = @"compose_emotion_table_mid_normal";
                select_image = @"compose_emotion_table_mid_selected";
                break;
            case 2:
                tabBar_btn.tag = ZTEEmojiTabBarButtonTypeEmoji;
                normal_image = @"compose_emotion_table_mid_normal";
                select_image = @"compose_emotion_table_mid_selected";
                break;
            default:
                normal_image = @"compose_emotion_table_right_normal";
                select_image = @"compose_emotion_table_right_selected";
                tabBar_btn.tag = ZTEEmojiTabBarButtonTypeLxh;
                break;
        }
        [tabBar_btn setBackgroundImage:[UIImage imageNamed:normal_image] forState:(UIControlStateNormal)];
        [tabBar_btn setBackgroundImage:[UIImage imageNamed:select_image] forState:(UIControlStateDisabled)];
        [self addSubview:tabBar_btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        ZTEEmojiTabBarButton *tabbar_btn = (ZTEEmojiTabBarButton*)self.subviews[i];
        tabbar_btn.width = w/4;
        tabbar_btn.height = h;
        tabbar_btn.y = 0;
        tabbar_btn.x = i*tabbar_btn.width;
    }
}

- (void)setDelegate:(id<ZTEEmojiTabBarDelegate>)delegate{
    _delegate = delegate;
    // 选中“默认”按钮
    [self btnClick:(ZTEEmojiTabBarButton *)[self viewWithTag:ZTEEmojiTabBarButtonTypeDefault]];
}

#pragma mark 监听事件
- (void)btnClick:(ZTEEmojiTabBarButton*)sender{
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:sender.tag];
    }
}
@end
