//
//  WBUserModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "WBUserModel.h"

@implementation WBUserModel

- (NSString*)name_end{
    if (self.remark.length) {
        _name_end = self.remark;
    } else if (self.screen_name.length) {
        _name_end = self.screen_name;
    } else {
        _name_end = self.name;
    }
    return _name_end;
}

- (WBUserVerifyType)userVerifyType{
    // 这个不一定准。。
    if ([_verified boolValue]) {
        _userVerifyType = WBUserVerifyTypeStandard;
    } else if ([_verified_type integerValue]== 220) {
        _userVerifyType = WBUserVerifyTypeClub;
    } else if ([_verified_type integerValue] == -1 && [_verified_level integerValue]  == 3) {
        _userVerifyType = WBUserVerifyTypeOrganization;
    } else {
        _userVerifyType = WBUserVerifyTypeNone;
    }
    return _userVerifyType;
}
@end
