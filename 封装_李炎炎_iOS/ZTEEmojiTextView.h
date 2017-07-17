//
//  ZTEEmojiTextView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTETextView.h"
#import "ZTEEmotionModel.h"

@interface ZTEEmojiTextView : ZTETextView

/** textView 插入表情数据(文字不用处理 直接调系统的方法,主要针对图片表情的处理) */
- (void)insertEmotionModel:(ZTEEmotionModel*)emotionModel;

/** 将属性字符串 转换成普通字符串(主要针对附件中的表情图片 >> 普通文本) 提交服务器 */
- (NSString*)fullText;

@end
