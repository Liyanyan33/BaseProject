//
//  ZTEAlbumManager.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  相册管理者

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "ZTEAlbumModel.h"
#import "ZTEAssetModel.h"

@interface ZTEAlbumManager : NSObject

/** 单例构造方法 */
+ (instancetype)shareAlbumManager;
/** 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个 */
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;

/** 获取图片时 指定的图片宽度 */
@property(nonatomic,assign)CGFloat photoWidth;
/** 图片浏览的最大宽度 默认值为600 */
@property(nonatomic,assign)CGFloat photoPreviewMaxWidth;
/** 图片的显示列数 */
@property(nonatomic,assign)NSInteger columCount;

/** Get Album 获得相册 */
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(ZTEAlbumModel *model))completion;

/** 获取系统的相册数组 */
- (void)getAllAlbumsAllowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAlbumModel *> *models))completion;

/** 获取系统指定相册的封面图片 */
- (void)getCoverImageOfAlbum:(ZTEAlbumModel*)albumModel completion:(void(^)(UIImage *Image))completion;

/** 根据指定条件 获取图片 */
- (void)getImageWithAsset:(id)asset imageWidth:(CGFloat)imageWidth complettion:(void(^)(UIImage *image,NSDictionary *info))completion;
- (void)getImageWithAsset:(id)asset completion:(void (^)(UIImage *image,NSDictionary *info))completion;
- (void)getImageWithAsset:(id)asset completion:(void (^)(UIImage *image,NSDictionary *info))completion progressHandler:(void (^)(double progress))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;

/** 获取图片/视频 资源模型数组 */
- (void)getAssetModelArrFromFetchResult:(id)fetchResult allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAssetModel*> *assetModels))completion;

/** 检测数组中是否包含元素 */
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset;

/** 获取资源模型的唯一标识 */
- (NSString*)getAssetModelIdentify:(id)asset;

/** 计算被选择的总资源 所占磁盘空间大小 */
- (void)calAssetBytes:(NSArray<ZTEAssetModel*>*)selectedAssetArr complettion:(void(^)(NSString* totalBytes))completion;

@end
