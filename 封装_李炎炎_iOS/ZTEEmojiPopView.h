//
//  ZTEEmojiPopView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/23.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  长按表情面板 弹出视图

#import <UIKit/UIKit.h>
#import "ZTEEmojiButton.h"

@interface ZTEEmojiPopView : UIView

+ (instancetype)popView;

- (void)showFrom:(ZTEEmojiButton*)fromView;

- (void)dismiss;

@end
