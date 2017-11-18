//
//  LYDate.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/7.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDateUtil : NSObject

/** 根据指定的日期格式 获取当前时间 */
+ (NSString*)getCurrentTime:(NSString*)format;

+ (BOOL)containWithTime:(NSString*)time;

+ (NSString*)getTimeWithStr:(NSString*)str;

@end
