//
//  WBTimelineModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "WBTimelineModel.h"

@implementation WBTimelineModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ad" : @"WBAdModel",@"advertises":@"WBAdvertityModel",@"statuses":@"WBStatuModel"};
}

@end
