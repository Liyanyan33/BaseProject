//
//  ZTEEmotionModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情数据模型

#import <Foundation/Foundation.h>
#import "ZTEEmotionModel.h"

@interface ZTEEmotionModel : NSObject
@property(nonatomic,copy)NSString *chs;  //描述文字
@property(nonatomic,copy)NSString *cht;  // 描述文字
@property(nonatomic,copy)NSString *gif;   // 动态图
@property(nonatomic,copy)NSString *png;  //静态图
@property(nonatomic,assign)int type;          //类型
@property(nonatomic,copy)NSString *code;  // 编码(只针对Emoji表情才有)
@end
