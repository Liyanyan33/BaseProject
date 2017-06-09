//
//  BaseResponseModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseResponseModel.h"

@implementation BaseResponseModel

- (BOOL)isSuccess{

    return [self.ret isEqualToString:@"0"];
}

- (BOOL)hasData{

    return self.data.count > 0;
}

@end
