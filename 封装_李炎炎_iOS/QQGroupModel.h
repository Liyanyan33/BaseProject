//
//  QQGroupModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  QQ列表分组模型

#import <Foundation/Foundation.h>
#import "QQContactModel.h"

@interface QQGroupModel : NSObject
@property(nonatomic,copy)NSString *group_id;
@property(nonatomic,copy)NSString *group_name;
@property(nonatomic,copy)NSString *group_type;
@property(nonatomic,copy)NSString *member_num;
@property(nonatomic,strong)NSArray<QQContactModel*> *contacts;

/** 自定义属性  是否折叠*/
@property(nonatomic,assign)BOOL isFold;
@end
