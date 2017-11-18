//
//  ZTEAlbumManager.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  相册管理者

#import "ZTEAlbumManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation ZTEAlbumManager
/** 屏幕宽度 */
CGFloat  ZTEScreenWidth;
/**  屏幕模式*/
CGFloat  ZTEScreenScale;
/** 图片(网格)的尺寸 */
CGSize ZTEAssetGridThumbnailSize;

+ (instancetype)shareAlbumManager{
    static ZTEAlbumManager *albumManager;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        albumManager = [[self alloc]init];
    });
    [albumManager configScreenParams];
    return albumManager;
}

/** 配置屏幕参数 */
- (void)configScreenParams{
    ZTEScreenWidth = kScreenWidth;
    ZTEScreenScale = 2.0;
    if (ZTEScreenWidth > 700) {
        ZTEScreenScale = 1.5;
    }
}

- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(ZTEAlbumModel *))completion{
    
}

- (void)getAssetModelArrFromFetchResult:(id)fetchResult allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAssetModel *> *))completion {
    NSMutableArray *assetArr = [[NSMutableArray alloc]init];
    if ([fetchResult isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *result = (PHFetchResult*)fetchResult;
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 将PHFetchResult中的资源数据 转换成ZTEAssetModel模型
            ZTEAssetModel *assetModel = [self generateAssetModelWithAsset:obj allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage];
            NSLog(@"assetModel本地的唯一标识 = %@",assetModel.identify);
            if (assetModel) {
                [assetArr addObject:assetModel];
            }
        }];
        if (completion) {
            completion(assetArr);
        }
    }else{
        
    }
}

//  根据系统资源 创建生成资源模型
- (ZTEAssetModel*)generateAssetModelWithAsset:(id)asset allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage{
    ZTEAssetModel *assetModel;
    ZTEAssetModelType assetModelType = [self getAssetModelTypeWithAsset:asset];
    if ([asset isKindOfClass:[PHAsset class]]) {
        if (!allowPickingVideo && assetModelType == ZTEAssetModelTypeVideo) {
            return nil;
        }
        if (!allowPickingImage && assetModelType == ZTEAssetModelTypeImage) {
            return nil;
        }
        if (!allowPickingImage && assetModelType == ZTEAssetModelTypeGifImage) {
            return nil;
        }
        PHAsset *phAsset = (PHAsset*)asset;
        NSString *identify = phAsset.localIdentifier;
#pragma mark 有个过滤操作 暂时不做了
        NSString *timeLength = assetModelType == ZTEAssetModelTypeVideo ? [NSString stringWithFormat:@"%0.0f",phAsset.duration] : @"";
        timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
        assetModel = [ZTEAssetModel assetModelWithAsset:asset assetType:assetModelType timeLength:timeLength identify:identify];
    }else{
        
        
    }
    return assetModel;
}

/** 获取资源的类型 */
- (ZTEAssetModelType)getAssetModelTypeWithAsset:(id)asset{
    ZTEAssetModelType type = ZTEAssetModelTypeImage;
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset*)asset;
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            type = ZTEAssetModelTypeVideo;
        }else if (phAsset.mediaType == PHAssetMediaTypeAudio){
            type = ZTEAssetModelTypeAudio;
        }else if (phAsset.mediaType == PHAssetMediaTypeImage){
            if ([[phAsset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
                type = ZTEAssetModelTypeGifImage;
            }
        }
    }else{
        
    }
    return type;
}

/** 时间换算  */
- (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"0:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"0:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}

// 获取相册资源集合  info文件中必须要添加对应的权限字段 否则程序会报错
- (void)getAllAlbumsAllowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<ZTEAlbumModel *>  *models))completion{
    NSMutableArray *albumArr = [[NSMutableArray alloc]init];
    if (iOS8Later) {
        PHFetchOptions *option = [[PHFetchOptions alloc]init];
        // 设置获取资源的约束条件
        if (allowPickingVideo) {
            option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d",PHAssetMediaTypeVideo];
        }
        if (allowPickingImage) {
            option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d",PHAssetMediaTypeImage];
        }
        // 对获取的资源进行排序
        if (1==1) {
            option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        }
        // 获取资源集合 相册集合分为不同的类型 (主类型 --> 子类型)
        // 获取的 PHFetchResult(集合/数组) 里面的存放的元素是 PHAssetCollection
        // 层级关系 【 资源集合(也可以认为是相册的集合) PHFetchResult -->存放相册PHAssetCollection --> 存放PHAsset(资源数据最基本的单位)具体的资源数据(单个的图片,视频等等)】
        PHFetchResult *myPhotoStreamAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
        PHFetchResult *smartAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchResult *topLevelUserCollections = [PHCollectionList  fetchTopLevelUserCollectionsWithOptions:nil];
        PHFetchResult *syncedAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
        PHFetchResult *sharedAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumCloudShared options:nil];
        // 组装成资源集合数组
        NSArray *albums = @[myPhotoStreamAlbum,smartAlbum,topLevelUserCollections,syncedAlbum,sharedAlbum];

        // PHCollection是个基类，有PHAssetCollection(相册)和PHCollectionList(文件夹)两个子类，分别代表 Photos 里的相册和文件夹  (大相册 小相册)
        for (PHFetchResult *fetchResult in albums) {
            NSLog(@"fetchResult = %@",fetchResult);
            for (PHAssetCollection *assetCollection in fetchResult) {
                NSLog(@"assetCollection = %@",assetCollection);
                // 做一个类型上的过滤
                if ([assetCollection isKindOfClass:[PHAssetCollection class]]) {
                    // 单个小相册 (其中包含图片数据)
                    PHFetchResult *albumResult = [PHAsset  fetchAssetsInAssetCollection:assetCollection options:option];
                    // 相册中的图片数量为0 直接跳出当前循环
                    if (albumResult.count < 1) {
                        NSLog(@"相册中的图片为0的相册名称 = %@",assetCollection.localizedTitle);
                        continue;
                    }
                    // 过滤掉 已隐藏和最近删除的资源文件
                    // assetCollection.localizedTitle 表示相册在手机系统中的名称
                    if ([self theString:assetCollection.localizedTitle isContianStirng:@"Hidden"] || [assetCollection.localizedTitle isEqualToString:@"已隐藏"]) {
                        continue;
                    }
                    if ([self theString:assetCollection.localizedTitle isContianStirng:@"Deleted"] || [assetCollection.localizedTitle isEqualToString:@"最近删除"]) {
                        continue;
                    }
                    // 将所获取的系统相册资源 转换成自定义资源模型
                    ZTEAlbumModel *aModel = [self generateAlbumCollectionModel:albumResult withAlbumName:assetCollection.localizedTitle];
                    [albumArr addObject:aModel];
                }
            }
        }
        // 执行block回调
        if (completion && albumArr.count > 0) {
            completion(albumArr);
        }
    }else{
   
    }
}

/** 获取指定相册的封面图片 */
- (void)getCoverImageOfAlbum:(ZTEAlbumModel *)albumModel completion:(void (^)(UIImage *image))completion{
    if (iOS8Later) {
        id asset = [albumModel.result lastObject];
        if (!self.sortAscendingByModificationDate) {
            asset = [albumModel.result firstObject];
        }
        // 根据指定条件 获取图片
        [self getImageWithAsset:asset imageWidth:80.0f complettion:^(UIImage *image, NSDictionary *info) {
            if (completion) {
                completion(image);
            }
        }];
    }else{
   
    }
}

/** 根据指定条件 获取图片 */
- (void)getImageWithAsset:(id)asset imageWidth:(CGFloat)imageWidth complettion:(void(^)(UIImage *image,NSDictionary *info))completion{
    [self getImageWithAsset:asset imageWidth:imageWidth complettion:completion progressHandler:nil networkAccessAllow:YES];
}

- (void)getImageWithAsset:(id)asset completion:(void (^)(UIImage *image, NSDictionary *info))completion{
    CGFloat fullScreenWidth = ZTEScreenWidth;
    if (fullScreenWidth > _photoPreviewMaxWidth) {
        fullScreenWidth = _photoPreviewMaxWidth;
    }
    [self getImageWithAsset:asset imageWidth:fullScreenWidth complettion:completion];
}

- (void)getImageWithAsset:(id)asset completion:(void (^)(UIImage *, NSDictionary *))completion progressHandler:(void (^)(double progerss))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed{
    CGFloat fullScreenWidth = ZTEScreenWidth;
    if (fullScreenWidth > _photoPreviewMaxWidth) {
        fullScreenWidth = _photoPreviewMaxWidth;
    }
    [self getImageWithAsset:asset imageWidth:fullScreenWidth complettion:completion progressHandler:progressHandler networkAccessAllow:networkAccessAllowed];
}


/** 根据指定条件(条件更多) 获取图片 */
- (void)getImageWithAsset:(id)asset imageWidth:(CGFloat)imageWidth complettion:(void (^)(UIImage *image, NSDictionary *info))completion progressHandler:(void(^)(double progress))progressHandler networkAccessAllow:(BOOL)networkAccessAllow{
    if ([asset isKindOfClass:[PHAsset class]]) {
        // 设置获取图片的尺寸大小(对获取的目标图片进行裁剪)
        CGSize imageSize;
        if (imageWidth < ZTEScreenWidth && imageWidth < _photoPreviewMaxWidth) {
            imageSize = ZTEAssetGridThumbnailSize;
        }else{
            PHAsset *phAsset = (PHAsset*)asset;
            // 资源的像素尺寸的宽高比
            // 下面的操作 是将像素坐标转换成点坐标
            CGFloat radio = phAsset.pixelWidth/phAsset.pixelHeight;
            CGFloat pixeWidth = imageWidth * ZTEScreenScale * 1.5;
            // 宽度是高度的1.8倍(超宽图片)
            if (radio > 1.8) {
                pixeWidth = pixeWidth * radio;
            }
            // 高度是宽的5倍(超高图片)
            if (radio < 0.2) {
                pixeWidth = pixeWidth * 0.5;
            }
            CGFloat pixeHeight = pixeWidth / radio;
            imageSize = CGSizeMake(pixeWidth, pixeHeight);
        }
        
        // 使用PHImageManager 请求图片(视频)
        __block UIImage *image;
        // 配置请求的参数
        PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc]init];
        //对请求的图像怎样缩放？有三种选择：(None: 不缩放；Fast: 尽快地提供接近或稍微大于要求的尺寸；Exact: 精准提供要求的尺寸)
        imageRequestOption.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 创建数据请求 最后以block参数形式 返回给我们需要的UIImage
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                image = result;
            }
            // NSDictionary info 字典主要是用来描述 请求的状态信息的
            // PHImageCancelledKey --> 请求是否被取消
            // PHImageErrorKey --> 请求是否出现错误
            // PHImageResultIsDegradedKey --> 当前递送的 UIImage 是否是最终结果的低质量格式。当高质量图像正在下载时，这个可以让你给用户先展示一个预览图像
            // 请求没有被取消并且请求没有出现错误 表明下载完成
            BOOL downFinished =  (![[info objectForKey:PHImageCancelledKey] boolValue] && ![[info objectForKey:PHImageErrorKey] boolValue]);
            if (downFinished && result) {
                result = [self fixImageOrientation:result];
                if (completion) {
                    completion(result,info);
                }
            }
            // 图片需要重新下载
            if ([info objectForKey:PHImageResultIsInCloudKey]&& !result &&networkAccessAllow) {
                PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc]init];
                imageRequestOptions.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (progressHandler) {
                            progressHandler(progress);
                        }
                    });
                };
                imageRequestOptions.networkAccessAllowed = YES;
                imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
                
              [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                  UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
                  resultImage = [self scaleImage:resultImage toSize:imageSize];
                  if (!resultImage) {
                      resultImage = image;
                  }
                  resultImage = [self fixImageOrientation:resultImage];
                  if (completion) {
                      completion(resultImage,info);
                  }
              }];
            }
        }];
    }else{
        
    }
}

#pragma mark private method
- (BOOL)theString:(NSString*)str isContianStirng:(NSString*)string{
    if (iOS8Later) {
        return [str containsString:string];
    }else{
        NSRange range = [str rangeOfString:string];
        return range.location != NSNotFound;
     }
}

/** 根据所获取的系统资源数据 生成自定义的相册模型数据 */
- (ZTEAlbumModel*)generateAlbumCollectionModel:(id)albumResult withAlbumName:(NSString*)albumName{
    ZTEAlbumModel *acm = [[ZTEAlbumModel alloc]init];
    acm.name = albumName;
    acm.result = albumResult;
    if ([albumResult isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *result = (PHFetchResult*)albumResult;
        acm.count = result.count;
    }else{
   
    }
    return acm;
}

/** 修正图片的方向 */
- (UIImage*)fixImageOrientation:(UIImage*)image{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/** 重新设置图片的尺寸大小  */
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return image;
    }
}

// 判断一个assets数组是否包含这个asset
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset {
    if (iOS8Later) {
        return [assets containsObject:asset];
    } else {
        NSMutableArray *selectedAssetUrls = [NSMutableArray array];
        for (ALAsset *asset_item in assets) {
            [selectedAssetUrls addObject:[asset_item valueForProperty:ALAssetPropertyURLs]];
        }
        return [selectedAssetUrls containsObject:[asset valueForProperty:ALAssetPropertyURLs]];
    }
}

/** 获取资源数据的唯一标识 */
- (NSString*)getAssetModelIdentify:(id)asset{
    NSString *identify = nil;
    if (iOS8Later) {
        PHAsset *phAsset = (PHAsset*)asset;
        identify = phAsset.localIdentifier;
    }else{
        ALAsset *alAsset = (ALAsset*)asset;
        NSURL *url = [alAsset valueForKey:ALAssetPropertyAssetURL];
        identify = url.absoluteString;
    }
    return identify;
}

/** 计算被选择的总资源 所占磁盘空间大小 */
- (void)calAssetBytes:(NSArray<ZTEAssetModel*> *)selectedAssetArr complettion:(void (^)(NSString *))completion{
   __block NSInteger dataLength = 0;
   __block NSInteger assetCount = 0;
    for (int i = 0; i < selectedAssetArr.count; i++) {        
        ZTEAssetModel *model = selectedAssetArr[i];
        if ([model.asset isKindOfClass:[PHAsset class]]) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                if (model.type != ZTEAssetModelTypeVideo){
                    dataLength += imageData.length;
                }
                assetCount ++;
                if (assetCount >= selectedAssetArr.count) {
                    NSString *bytes = [self calAssetBytesFromDataLength:dataLength];
                    if (completion){
                        completion(bytes);
                    }
                }
            }];
        }else{
            
        }
    }
}

/** 根据NSData计算 资源的空间大小 */
- (NSString*)calAssetBytesFromDataLength:(NSInteger)dataLength{
    NSString *bytes = nil;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
    } else {
        bytes = [NSString stringWithFormat:@"%zdB",dataLength];
    }
    return bytes;
}

#pragma mark setter  getter
- (void)setColumCount:(NSInteger)columCount{
    _columCount = columCount;
    CGFloat margin = 4;
    CGFloat itemWH = (ZTEScreenWidth - 2 * margin - 4)/columCount - margin;
    ZTEAssetGridThumbnailSize = CGSizeMake(itemWH, itemWH);
}

- (void)setPhotoWidth:(CGFloat)photoWidth{
    _photoWidth = photoWidth;
}

- (void)setPhotoPreviewMaxWidth:(CGFloat)photoPreviewMaxWidth{
    _photoPreviewMaxWidth = photoPreviewMaxWidth;
}
@end
