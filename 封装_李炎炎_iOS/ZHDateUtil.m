//
//  LYDate.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/7.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "ZHDateUtil.h"

@implementation ZHDateUtil

+ (NSString*)getCurrentTime:(NSString *)format{
    // 获取系统的当前时间
    NSDate *now = [NSDate date];
    // 初始化日期格式对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日期格式对象的格式属性
    [dateFormatter setDateFormat:format];
    // 将系统时间 按指定的日期格式返回
    return  [dateFormatter stringFromDate:now];
}


+ (void)getCurrentTime{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];

    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];

    NSLog(@"year is: %ld", (long)year);
    NSLog(@"month is: %ld", (long)month);
    NSLog(@"day is: %ld", (long)day);
    NSLog(@"hour is: %ld", (long)hour);
    NSLog(@"minute is: %ld", (long)minute);
    NSLog(@"second is: %ld", (long)second);
}

+ (BOOL)containWithTime:(NSString*)time{

    /** Nov 1, 2016 6:06:42 PM */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *td = [dateFormatter dateFromString:time];
    NSLog(@"td = %@",td);
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    NSInteger year = [dateComponent year];
    
    NSString *dateFrom = [NSString stringWithFormat:@"%ld-01-01",year];
    NSDate *from = [dateFormatter dateFromString:dateFrom];
    
    NSString *dateTo = [NSString stringWithFormat:@"%ld-12-31",year];
    NSDate *to = [dateFormatter dateFromString:dateTo];
    
    if ([td compare:from]==NSOrderedDescending && [td compare:to]==NSOrderedAscending){
        NSLog(@"该时间在 %@:00-%@:00 之间！", from, to);
        return YES;
    }
    return NO;
}

/** Nov 1, 2016 6:06:42 PM */
+ (NSString*)getTimeWithStr:(NSString*)str{

    NSArray *strArray = [str componentsSeparatedByString:@","];
    
    for (NSString *string in strArray) {
        NSLog(@"string = %@",string);
    }

    NSArray *s1 = [[strArray firstObject] componentsSeparatedByString:@" "];
    for (NSString *string in s1) {
        NSLog(@"string1 = %@",string);
    }
    
    NSString *month = nil;
    if ([[s1 firstObject] isEqualToString:@"Jan"]) {
        month = @"01";
    }else if([[s1 firstObject] isEqualToString:@"Feb"]){
        month = @"02";
    }else if([[s1 firstObject] isEqualToString:@"Mar"]){
        month = @"03";
    }else if([[s1 firstObject] isEqualToString:@"Apr"]){
        month = @"04";
    }else if([[s1 firstObject] isEqualToString:@"May"]){
        month = @"05";
    }else if([[s1 firstObject] isEqualToString:@"Jun"]){
        month = @"06";
    }else if([[s1 firstObject] isEqualToString:@"Jul"]){
        month = @"07";
    }else if([[s1 firstObject] isEqualToString:@"Aug"]){
        month = @"08";
    }else if([[s1 firstObject] isEqualToString:@"Sep"]){
        month = @"09";
    }else if([[s1 firstObject] isEqualToString:@"Oct"]){
        month = @"10";
    }else if([[s1 firstObject] isEqualToString:@"Nov"]){
        month = @"11";
    }else if([[s1 firstObject] isEqualToString:@"Dec"]){
        month = @"12";
    }
    
    NSString *date = [s1 lastObject];

   NSArray * s2 =  [[strArray lastObject] componentsSeparatedByString:@" "];
    for (NSString *string in s2) {
        NSLog(@"string2 = %@",string);
    }
    NSString *year = s2[1];
    
    return [NSString stringWithFormat:@"%@-%@-%@",year,month,date];
}
@end
