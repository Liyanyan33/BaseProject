//
//  AccountDB.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  本地缓存 账户信息

#import <Foundation/Foundation.h>
#import "AccoutModel.h"

@interface AccountDB : NSObject

// 存储
+ (void)saveAccountModel:(AccoutModel*)aModel;

// 获取
+ (NSString*)getAccountAccess_token;

+ (NSString*)getAccountExpires_in;

+ (NSString*)getAccountRemind_in;

+ (NSString*)getAccountUid;

+ (NSDate*)getAccountCreateTime;

// 清除
+ (void)cleanAccountModel;

+ (BOOL)accountIsExpires;

@end
