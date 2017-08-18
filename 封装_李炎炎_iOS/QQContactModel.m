//
//  QQContactModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "QQContactModel.h"

@implementation QQContactModel
+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"contact_id":@"id",@"desc":@"description"};
}
@end
