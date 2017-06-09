//
//  LYDate.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/7.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYDate : NSObject

+ (void)getCurrentTime;

+ (BOOL)containWithTime:(NSString*)time;

+ (NSString*)getTimeWithStr:(NSString*)str;

@end
