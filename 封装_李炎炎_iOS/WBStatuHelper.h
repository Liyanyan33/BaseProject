//
//  WBStatuHelper.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//   微博模型数据处理的帮助类

#import <Foundation/Foundation.h>

@interface WBStatuHelper : NSObject

/** 根据微博服务端获取的文本 创建生成富文本属性字符串 */
+ (NSAttributedString*)createAttrbutesStringIWithText:(NSString*)text;

@end
