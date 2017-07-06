//
//  WBTextPartModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  微博内容经过正则表达式切割之后的 片段文本(主要包括四种规则的片段)

#import <Foundation/Foundation.h>

@interface WBTextPartModel : NSObject
@property(nonatomic,copy)NSString *text;         // 文本内容
@property(nonatomic,assign)NSRange range;   // 片段文本在整个文本中的位置
@property(nonatomic,assign)BOOL isSpecialText;  // 是否为特殊文本
@property(nonatomic,assign)BOOL isEmotion;    // 是否为表情数据
@end
