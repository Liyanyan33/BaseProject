//
//  NSString+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/1.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "NSString+Extension.h"

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
@end
