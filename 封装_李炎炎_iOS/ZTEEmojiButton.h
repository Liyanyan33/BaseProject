//
//  ZTEEmojiButton.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/6.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘中的 表情按钮

#import <UIKit/UIKit.h>
#import "ZTEEmotionModel.h"
@interface ZTEEmojiButton : UIButton
@property (nonatomic, strong) ZTEEmotionModel *emotjiModel;
@end
