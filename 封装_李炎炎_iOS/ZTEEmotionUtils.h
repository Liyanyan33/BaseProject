//
//  ZTEEmotionUtils.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.

//   表情数据 通常分为两大类
//  1> emotji 表情看似图片其实是纯文字的
//  2> 图片表情 文字与图片是一一对应的 通常服务端给我们下发的是Unicode编码 然后我们APP端 把它转换成文字 我们APP本地存储了一张表情表(文字与图片一一对应的字典表格),根据文字与图片的对应的关系 我们找到 对应的图片,最后将表情图片显示.

#import <Foundation/Foundation.h>
#import "ZTEEmotionModel.h"

@interface ZTEEmotionUtils : NSObject

/** 表情数据 */
+ (NSArray *)emojiEmotions;

/** 默认表情数据 */
+ (NSArray *)defaultEmotions;

/** 浪小花数据 */
+ (NSArray *)lxhEmotions;

/** 通过表情描述获取对应的表情模型数据 */
+ (ZTEEmotionModel *)emotionWithChs:(NSString *)chs;

@end
