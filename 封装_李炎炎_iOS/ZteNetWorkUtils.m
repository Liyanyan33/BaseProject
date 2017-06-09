//
//  ZteNetWorkUtils.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/8.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "ZteNetWorkUtils.h"
#import "Reachability.h"

@implementation ZteNetWorkUtils

+ (NSInteger)networkStatus
{
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    return reachability.currentReachabilityStatus;
}

+ (BOOL)isNetworkExist
{
    return [self networkStatus] > 0;
}


@end
