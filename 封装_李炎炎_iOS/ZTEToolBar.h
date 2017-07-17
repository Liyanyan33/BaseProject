//
//  ZTEToolBar.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/12.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  聊天工具栏 主要包括 内容输入框 表情按钮  表情键盘面板 

#import <UIKit/UIKit.h>

@class ZTEToolBar;
/** 输入框的键盘状态 */
typedef NS_ENUM(NSUInteger,UITextViewInputState){
    UITextViewInputStateSystem,  // 系统键盘
    UITextViewInputStateEmoji,     // 表情键盘
};

@protocol ZTEToolBarDelegate <NSObject>
- (void)toolBar:(ZTEToolBar*)toolBar sendInputText:(NSString*)inputText;
@end

@interface ZTEToolBar : UIView
@property(nonatomic,assign)UITextViewInputState inputState;
@property(nonatomic,weak)id<ZTEToolBarDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withTargetVC:(UIViewController*)targetVC;

@end
