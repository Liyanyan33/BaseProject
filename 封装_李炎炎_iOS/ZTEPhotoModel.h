//
//  ZTEPhotoModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片模型数据 与 图片控件 ZTEPhotoView 一一对应
//  如果在其他项目中使用 需要根据服务端返回的图片数据字段 重新定义  图片模型(ZTEPhotoModel)的属性

#import <Foundation/Foundation.h>

@interface ZTEPhotoModel : NSObject
@property(nonatomic,copy)NSString *thumbnail_pic;
@end
