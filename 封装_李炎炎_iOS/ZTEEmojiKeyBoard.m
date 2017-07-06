//
//  ZTEEmojiKeyBoard.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘(替换系统键盘 进行显示)

#import "ZTEEmojiKeyBoard.h"
#import "ZTEEmojiModuleView.h"
#import "ZTEEmojiTabBar.h"
#import "ZTEEmotionUtils.h"

#define bottom_tabBarH 44

@interface ZTEEmojiKeyBoard ()<ZTEEmojiTabBarDelegate>
@property(nonatomic,strong)ZTEEmojiTabBar *bottom_tabBar;
@property(nonatomic,strong)ZTEEmojiModuleView *recentModuleView; //最近
@property(nonatomic,strong)ZTEEmojiModuleView *defaultMoudleView; // 默认
@property(nonatomic,strong)ZTEEmojiModuleView *emojiMoudleView;  // emoji
@property(nonatomic,strong)ZTEEmojiModuleView *lxhMoudleView;  //浪小花
@property(nonatomic,strong)ZTEEmojiModuleView *showingMoudleView;  // 记录正在显示的模块View
@end

@implementation ZTEEmojiKeyBoard

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.bottom_tabBar];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 1.底部选项卡
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _bottom_tabBar.frame = CGRectMake(0, h - bottom_tabBarH, w, bottom_tabBarH);
    
    // 2.表情内容
    self.showingMoudleView.x = self.showingMoudleView.y = 0;
    self.showingMoudleView.width = self.width;
    self.showingMoudleView.height = self.bottom_tabBar.y;
}

#pragma mark ZTEEmojiTabBarDelegate
- (void)emotionTabBar:(ZTEEmojiTabBar *)tabBar didSelectButton:(ZTEEmojiTabBarButtonType)buttonType{
    // 移除正在显示的listView控件 只是移除 并没有销毁
    [self.showingMoudleView removeFromSuperview];
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case ZTEEmojiTabBarButtonTypeRecent: { // 最近
            [self addSubview:self.recentModuleView];
            break;
        }
        case ZTEEmojiTabBarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultMoudleView];
            break;
        }
        case ZTEEmojiTabBarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiMoudleView];
            break;
        }
        case ZTEEmojiTabBarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhMoudleView];
            break;
        }
    }
    // 设置正在显示的listView
    self.showingMoudleView = [self.subviews lastObject];
    // 设置frame
    [self setNeedsLayout];
}

#pragma mark 懒加载
- (ZTEEmojiTabBar*)bottom_tabBar{
    if (!_bottom_tabBar) {
        _bottom_tabBar = [[ZTEEmojiTabBar alloc]init];
        _bottom_tabBar.delegate = self;
    }
    return _bottom_tabBar;
}

- (ZTEEmojiModuleView*)recentModuleView{
    if (!_recentModuleView) {
        _recentModuleView = [[ZTEEmojiModuleView alloc]init];
    }
    return _recentModuleView;
}

- (ZTEEmojiModuleView*)defaultMoudleView{
    if (!_defaultMoudleView) {
        _defaultMoudleView = [[ZTEEmojiModuleView alloc]init];
        _defaultMoudleView.emojiArr = [ZTEEmotionUtils defaultEmotions];
    }
    return _defaultMoudleView;
}

- (ZTEEmojiModuleView*)emojiMoudleView{
    if (!_emojiMoudleView) {
        _emojiMoudleView = [[ZTEEmojiModuleView alloc]init];
        _emojiMoudleView.emojiArr = [ZTEEmotionUtils emojiEmotions];
    }
    return _emojiMoudleView;
}

- (ZTEEmojiModuleView*)lxhMoudleView{
    if (!_lxhMoudleView) {
        _lxhMoudleView = [[ZTEEmojiModuleView alloc]init];
        _lxhMoudleView.emojiArr = [ZTEEmotionUtils lxhEmotions];
    }
    return _lxhMoudleView;
}
@end
