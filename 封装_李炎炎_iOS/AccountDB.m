//
//  AccountDB.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AccountDB.h"

static NSUserDefaults *_userDefault;

@implementation AccountDB
+ (void)initialize{
    _userDefault = [NSUserDefaults standardUserDefaults];
}

+ (void)saveAccountModel:(AccoutModel*)aModel{
    aModel.create_time = [NSDate date];
    [_userDefault setObject:aModel.access_token forKey:@"access_token"];
    [_userDefault setObject:aModel.expires_in forKey:@"expires_in"];
    [_userDefault setObject:aModel.remind_in forKey:@"remind_in"];
    [_userDefault setObject:aModel.uid forKey:@"uid"];
    [_userDefault setObject:aModel.create_time forKey:@"create_time"];
}

+ (NSString*)getAccountAccess_token{
   return  [_userDefault objectForKey:@"access_token"];
}

+ (NSString*)getAccountExpires_in{
    return [_userDefault objectForKey:@"expires_in"];
}

+ (NSString*)getAccountRemind_in{
    return [_userDefault objectForKey:@"remind_in"];
}

+ (NSString*)getAccountUid{
    return [_userDefault objectForKey:@"uid"];
}

+ (NSDate*)getAccountCreateTime{
    return [_userDefault objectForKey:@"create_time"];
}

+ (void)cleanAccountModel{
    [_userDefault setObject:nil forKey:@"access_token"];
    [_userDefault setObject:nil forKey:@"expires_in"];
    [_userDefault setObject:nil forKey:@"remind_in"];
    [_userDefault setObject:nil forKey:@"uid"];
    [_userDefault setObject:nil forKey:@"create_time"];
}

+ (BOOL)accountIsExpires{
    NSString *expires_in = [AccountDB getAccountExpires_in];
    NSDate *create_time = [AccountDB getAccountCreateTime];
    
    if (!expires_in) {
        return YES;
    }else{
        // 过期的秒数
        long long expires_in_sec = [expires_in longLongValue];
        // 获得过期时间
        NSDate *expiresTime = [create_time dateByAddingTimeInterval:expires_in_sec];
        // 获得当前时间
        NSDate *now = [NSDate date];
        
        // 如果expiresTime <= now，过期
        /**
         NSOrderedAscending = -1L, 升序，右边 > 左边
         NSOrderedSame, 一样
         NSOrderedDescending 降序，右边 < 左边
         */
        NSComparisonResult result = [expiresTime compare:now];
        if (result != NSOrderedDescending) { // 过期
            return YES;
        }
    }
    return NO;
}
@end
