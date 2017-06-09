//
//  BaseResponseModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponseModel : NSObject

@property(nonatomic,copy)NSString *ret;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)NSArray *data;

- (BOOL)isSuccess;

- (BOOL)hasData;

@end
