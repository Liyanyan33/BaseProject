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
@property(nonatomic,strong)UIView *headerLine;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)ZTEEmojiTabBarButton *selectedBtn;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)NSMutableArray *tabBarBtnArr;
@end

@implementation ZTEEmojiTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData{
    _dic = [[NSMutableDictionary alloc]init];
    _dic[@"Emoji"] = [NSString stringWithFormat:@"%lu",(unsigned long)ZTEEmojiTabBarButtonTypeEmoji];
    _dic[@"最近"] = [NSString stringWithFormat:@"%lu",(unsigned long)ZTEEmojiTabBarButtonTypeRecent];
    _dic[@"默认"] = [NSString stringWithFormat:@"%lu",(unsigned long)ZTEEmojiTabBarButtonTypeDefault];
    _dic[@"浪小花"] = [NSString stringWithFormat:@"%lu",(unsigned long)ZTEEmojiTabBarButtonTypeLxh];
}

- (void)reloadData{
    [self createUI];
}

- (void)createUI{
    if (self.subviews.count > 0) {
        [self removeAllSubviews];
    }
    
   NSArray *titleArr =  [self.delegate emojiTabBarTitleArr];
    
    if (!titleArr) { // 默认主题数组
        titleArr = @[@"最近",@"默认",@"Emoji",@"浪小花"];
    }
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.headerLine];
    [self addSubview:self.sendBtn];
    
    NSString *normal_image = @"compose_emotion_table_mid_normal";
    NSString *select_image = @"compose_emotion_table_mid_selected";
    for (int i = 0; i < titleArr.count; i++) {
        ZTEEmojiTabBarButton *tabBar_btn = [[ZTEEmojiTabBarButton alloc]init];
        [tabBar_btn setTitle:titleArr[i] forState:(UIControlStateNormal)];
        [tabBar_btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 0) {
            normal_image = @"compose_emotion_table_left_normal";
            select_image = @"compose_emotion_table_left_selected";
        }else if (i == (titleArr.count - 1)){
            normal_image = @"compose_emotion_table_right_normal";
            select_image = @"compose_emotion_table_right_selected";
        }else{
            normal_image = @"compose_emotion_table_mid_normal";
            select_image = @"compose_emotion_table_mid_selected";
        }
        NSUInteger tag = [[_dic objectForKey:titleArr[i] ] integerValue];
        tabBar_btn.tag = tag;
        [tabBar_btn setBackgroundImage:[UIImage imageNamed:normal_image] forState:(UIControlStateNormal)];
        [tabBar_btn setBackgroundImage:[UIImage imageNamed:select_image] forState:(UIControlStateDisabled)];
         [self btnClick:(ZTEEmojiTabBarButton *)[self viewWithTag:ZTEEmojiTabBarButtonTypeDefault]];
        [self.scrollView addSubview:tabBar_btn];
        [self.tabBarBtnArr addObject:tabBar_btn];
    }
    
    self.scrollView.contentSize = CGSizeMake(44+20*titleArr.count, 44);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.headerLine.frame = CGRectMake(0, 0, w, 0.25);
    self.sendBtn.frame = CGRectMake(w - h - 20, 0, h+20, h);
    self.scrollView.frame = CGRectMake(0, 0, w - h - 20, h);
    for (int i = 0; i < self.tabBarBtnArr.count; i++) {
        ZTEEmojiTabBarButton *tabbar_btn = (ZTEEmojiTabBarButton*)self.tabBarBtnArr[i];
        tabbar_btn.width = h + 20;
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

// 发送按钮点击
- (void)clickSendBtn:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSendButton:)]) {
        [self.delegate emotionTabBar:self didSendButton:sender];
    }
}

#pragma mak 懒加载
- (UIView*)headerLine{
    if (!_headerLine) {
        _headerLine = [[UIView alloc]init];
        _headerLine.backgroundColor = [UIColor grayColor];
    }
    return _headerLine;
}
- (UIButton*)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]init];
        [_sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
        [_sendBtn addTarget:self action:@selector(clickSendBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        _sendBtn.backgroundColor = [UIColor greenColor];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _sendBtn;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (NSMutableArray*)tabBarBtnArr{
    if (!_tabBarBtnArr) {
        _tabBarBtnArr = [[NSMutableArray alloc]init];
    }
    return _tabBarBtnArr;
}
@end
