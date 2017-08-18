//
//  QQContactModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  QQ列表 分组内部 单个联系人模型

#import <Foundation/Foundation.h>

@interface QQContactModel : NSObject
@property(nonatomic,copy)NSString *contact_id;
@property(nonatomic,copy)NSString *head_img;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *active_time;
@end
