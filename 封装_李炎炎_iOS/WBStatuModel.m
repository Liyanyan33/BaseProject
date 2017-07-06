//
//  WBStatuModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "WBStatuModel.h"
#import "WBStatuHelper.h"

@implementation WBStatuModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls" : @"ZTEPhotoModel"};
}

/** 微博创建时间字符串的处理 */
- (NSString *)created_at{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

/** 处理来源 字符串 */
- (NSString*)source{
    if (_source.length>0) {
        NSRegularExpression *hrefRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=href=\").+(?=\" )" options:kNilOptions error:NULL];
        NSRegularExpression *textRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).+(?=<)" options:kNilOptions error:NULL];
        
        /** 只能匹配得到 字符串中的第一条数据 其他相同类型的数据不会得到 */
        NSTextCheckingResult *hrefResult = [hrefRegex firstMatchInString:_source options:kNilOptions range:NSMakeRange(0, _source.length)];
        NSTextCheckingResult *textResult = [textRegex firstMatchInString:_source options:kNilOptions range:NSMakeRange(0, _source.length)];
        
        NSString *href = [_source substringWithRange:hrefResult.range];
        NSString *text = [_source substringWithRange:textResult.range];
        NSLog(@"%@/n%@",href,text);
    
        if (text.length>0) {
             return [NSString stringWithFormat:@"来自%@",text];
        }
        return nil;
    }
    return nil;
}

/** 在json->model的时候就对属性字符串赋值 */
- (void)setText:(NSString *)text{
    _text = [text copy];
    if (_text.length == 0) {
        return;
    }
    _orginalAttrStr = [WBStatuHelper createAttrbutesStringIWithText:_text];
}
@end
