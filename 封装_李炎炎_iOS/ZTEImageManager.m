//
//  ZTEImageManager.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  

#import "ZTEImageManager.h"

@implementation ZTEImageManager
static ZTEImageManager *manager;
static dispatch_once_t onceToken;

+ (instancetype)manager{
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAlbumModel *> *))completion{
    
}

- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(ZTEAlbumModel *))completion{
    
}

@end
