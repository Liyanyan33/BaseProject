//
//  ZTEImageManager.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片处理 管理器

#import <Foundation/Foundation.h>
#import "ZTEAlbumModel.h"

@interface ZTEImageManager : NSObject

/** 单例构造方法 */
+ (instancetype)manager;

/** Get Album 获得相册 */
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(ZTEAlbumModel *model))completion;
/** 获取系统的相册数组 */
- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAlbumModel *> *models))completion;


@end
