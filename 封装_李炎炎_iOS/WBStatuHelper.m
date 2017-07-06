//
//  WBStatuHelper.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  处理微博数据的帮助类

#import "WBStatuHelper.h"
#import "RegexKitLite.h"
#import "WBTextPartModel.h"
#import "ZTEEmotionUtils.h"
#import "WBSpecailModel.h"

@implementation WBStatuHelper

+ (NSAttributedString*)createAttrbutesStringIWithText:(NSString *)text{
    if (text.length == 0) {
        return nil;
    }
    NSMutableArray *partTextModelArr = [[NSMutableArray alloc]init];
    //1> 创建正则表达式的规则
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionRegularEx,atRegularEx,topicRegularEx,urlRegularEx];
    // 2>遍历特殊规则的字符串 生成片段模型 用数组保存
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return;
        }
        WBTextPartModel *partModel = [[WBTextPartModel alloc]init];
        partModel.isSpecialText = YES;
        partModel.text = *capturedStrings;
        partModel.isEmotion = [partModel.text hasPrefix:@"["] && [partModel.text hasSuffix:@"]"];
        partModel.range = *capturedRanges;
        [partTextModelArr addObject:partModel];
    }];
    // 3.遍历所有普通字符串(普通文本 还包括空格字符串)
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) {
            return;
        }
        WBTextPartModel *partModel = [[WBTextPartModel alloc]init];
        partModel.text = *capturedStrings;
        partModel.range = *capturedRanges;
        [partTextModelArr addObject:partModel];
    }];
    // 4.数组的重新排序
    [partTextModelArr sortUsingComparator:^NSComparisonResult(WBTextPartModel *part1, WBTextPartModel *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]init];
    UIFont *font = [UIFont systemFontOfSize:15];
    // 存储特殊字符片段的数组
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    for (WBTextPartModel *part in partTextModelArr) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // [表情数据]
            //创建此对象 能将图片 渲染在 文本控件上
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 根据表情文字 找到与之相对应的图片 (本地已经存储了表情文字与图片的一一对应的数据列表)
            NSString *name = [ZTEEmotionUtils emotionWithChs:part.text].png;
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.isSpecialText) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
            // 创建特殊对象
            WBSpecailModel *s = [[WBSpecailModel alloc] init];
            s.text = part.text;
            NSUInteger loc = attrString.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            [specials addObject:s];
        } else { // 非特殊文字(普通文本)
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attrString appendAttributedString:substr];
    }
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attrString;
}
@end
