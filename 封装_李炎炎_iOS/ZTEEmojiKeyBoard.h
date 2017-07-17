//
//  ZTEEmojiKeyBoard.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//   表情键盘(替换系统键盘 进行显示)

#import <UIKit/UIKit.h>

@class ZTEEmojiKeyBoard;
@class ZTEEmotionModel;

@protocol ZTEEmojiKeyBoardDelegate <NSObject>
/** 监听表情按钮的点击 */
- (void)zteEmojiKeyBoard:(ZTEEmojiKeyBoard*)zteEmojiKeyBoard emojiBtnClickModel:(ZTEEmotionModel*)model;
/** 监听删除按钮的点击 */
- (void)deleteBtnClickZteEmojiKeyBoard:(ZTEEmojiKeyBoard *)zteEmojiKeyBoard;
/** 发送按钮的点击 */
- (void)zteEmojiKeyBoard:(ZTEEmojiKeyBoard*)zteEmojiKeyBoard sendBtnClick:(UIButton*)sendButton;
@end

@interface ZTEEmojiKeyBoard : UIView
@property(nonatomic,weak)id<ZTEEmojiKeyBoardDelegate> delegate;
@end
