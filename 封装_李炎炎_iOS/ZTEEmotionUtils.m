
//
//  ZTEEmotionUtils.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情处理 工具类

#import "ZTEEmotionUtils.h"

// 定义三个静态变量数组 (在类方法中访问)
static NSArray *_emojiEmotions, *_defaultEmotions, *_lxhEmotions;

@implementation ZTEEmotionUtils

+ (NSArray*)emojiEmotions{
    if (!_emojiEmotions) {
        // 创建指定的文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emotionArr = [NSArray arrayWithContentsOfFile:path];
        _emojiEmotions = [ZTEEmotionModel mj_objectArrayWithKeyValuesArray:emotionArr];
    }
    return _emojiEmotions;
}

+ (NSArray*)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultArr = [NSArray arrayWithContentsOfFile:path];
        _defaultEmotions = [ZTEEmotionModel mj_objectArrayWithKeyValuesArray:defaultArr];
    }
    return _defaultEmotions;
}

+ (NSArray*)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhArr = [NSArray arrayWithContentsOfFile:path];
        _lxhEmotions = [ZTEEmotionModel mj_objectArrayWithKeyValuesArray:lxhArr];
    }
    return _lxhEmotions;
}

+ (ZTEEmotionModel*)emotionWithChs:(NSString *)chs{
    /** emoji表情数据 */
    NSArray *emotionArr = [self emojiEmotions];
    for (ZTEEmotionModel *emotionModel in emotionArr) {
        if ([emotionModel.chs isEqualToString:chs]) {
            return emotionModel;
        }
    }
    /** 默认表情数据 */
    NSArray *defaultArr = [self defaultEmotions];
    for (ZTEEmotionModel *emotionModel in defaultArr) {
        if ([emotionModel.chs isEqualToString:chs]) {
            return emotionModel;
        }
    }
    return nil;
}
@end
