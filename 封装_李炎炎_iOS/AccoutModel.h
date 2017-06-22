//
//  AccoutModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccoutModel : NSObject
/**  账户的登录口令*/
@property(nonatomic,copy)NSString *access_token;
/** 账户过期的秒数 */
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *remind_in;
@property(nonatomic,copy)NSString *uid;

/** 本地存储账号的时间 */
@property(nonatomic,strong)NSDate *create_time;

@end
