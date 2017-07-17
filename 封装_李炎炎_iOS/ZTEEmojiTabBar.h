//
//  ZTEEmojiTabBar.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘 底部的 tabbar选项卡

#import <UIKit/UIKit.h>

@class ZTEEmojiTabBar;
/** 按钮类型枚举 */
typedef NS_ENUM(NSUInteger,ZTEEmojiTabBarButtonType){
    ZTEEmojiTabBarButtonTypeRecent, // 最近
    ZTEEmojiTabBarButtonTypeDefault, // 默认
    ZTEEmojiTabBarButtonTypeEmoji,   // emoji
    ZTEEmojiTabBarButtonTypeLxh,      // 浪小花
};

@protocol ZTEEmojiTabBarDelegate <NSObject>
@optional
- (void)emotionTabBar:(ZTEEmojiTabBar *)tabBar didSelectButton:(ZTEEmojiTabBarButtonType)buttonType;  // 表情按钮的点击
- (void)emotionTabBar:(ZTEEmojiTabBar *)tabBar didSendButton:(UIButton*)sendButton;
@required  
- (NSArray*)emojiTabBarTitleArr;
@end

@interface ZTEEmojiTabBar : UIView
@property(nonatomic,strong)NSArray *titleArr;  // 主题数组
@property(nonatomic,weak)id<ZTEEmojiTabBarDelegate> delegate;
- (void)reloadData;
@end
