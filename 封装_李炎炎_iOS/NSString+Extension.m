//
//  NSString+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/1.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "NSString+Extension.h"

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Extension)

+ (NSString*)birthdayStrFromIdentityCard:(NSString *)iDNumberStr{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([iDNumberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [iDNumberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [iDNumberStr substringWithRange:NSMakeRange(6, 4)];
    month = [iDNumberStr substringWithRange:NSMakeRange(10, 2)];
    day = [iDNumberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

+ (NSString *)getIdentityCardAge:(NSString *)numberStr{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    formatterTow.dateFormat = @"yyyy-mm-dd";
    NSString *str = [self birthdayStrFromIdentityCard:numberStr];
    NSDate *bsyDate = [formatterTow dateFromString:str];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}

+ (CGSize)getBoundSizeWithText:(NSString*)text font:(UIFont*)font{
    NSMutableDictionary *attrDic = [[NSMutableDictionary alloc]init];
    attrDic[NSFontAttributeName] = font;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:text attributes:attrDic];
    return  attrStr.size;
}

/**
 * 根据文字属性 :计算文字所占区域 (系统重名)
 */
- (CGSize)sizeWithFont:(UIFont *)font withWidth:(CGFloat)width{
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc]init];
    attrs[NSFontAttributeName] = font;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font withHeight:(CGFloat)height{
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc]init];
    attrs[NSFontAttributeName] = font;
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)emoji{
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)isEmoji
{
    BOOL returnValue = NO;
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    return returnValue;
}
@end
