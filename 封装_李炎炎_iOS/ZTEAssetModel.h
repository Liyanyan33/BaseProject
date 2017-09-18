//
//  ZTEAssetModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/10.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  系统资源asset模型

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ZTEAssetModelType){
    ZTEAssetModelTypeImage,
    ZTEAssetModelTypeLiveImage,
    ZTEAssetModelTypeGifImage,
    ZTEAssetModelTypeVideo,
    ZTEAssetModelTypeAudio
};

@interface ZTEAssetModel : NSObject
/** 时间长度  针对音视频文件的播放时长 */
@property(nonatomic,copy)NSString *timeLength;
/** 是否选中 */
@property(nonatomic,assign)BOOL isSelected;
/** 资源本身 */
@property(nonatomic,strong)id  asset;
/** 资源类型 */
@property(nonatomic,assign)ZTEAssetModelType type;
/** 模型的唯一标识 */
@property(nonatomic,copy)NSString *identify;
/** 构造方法 */
+ (instancetype)assetModelWithAsset:(id)asset assetType:(ZTEAssetModelType)assetType timeLength:(NSString*)timeLength;
+ (instancetype)assetModelWithAsset:(id)asset assetType:(ZTEAssetModelType)assetType timeLength:(NSString*)timeLength identify:(NSString*)identify;
@end
