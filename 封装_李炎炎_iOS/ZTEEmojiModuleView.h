//
//  ZTEEmojiModuleView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘上部分 显示表情的View (这里分为四个模块 View (最近,默认,Emoji,浪小花))

#import <UIKit/UIKit.h>

@class ZTEEmotionModel;
/** 表情按钮点击 回调 */
typedef void(^emojiBtnClick)(ZTEEmotionModel *emojiModel);
/** 删除按钮点击 回调 */
typedef void(^deleteBtnClick)(void);

@interface ZTEEmojiModuleView : UIView
@property(nonatomic,strong)NSArray *emojiArr;
@property(nonatomic,copy)emojiBtnClick emojiBtnClick;
@property(nonatomic,copy)deleteBtnClick deleteBtnClick;
@end
