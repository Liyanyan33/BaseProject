//
//  ZTEAssetModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/10.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEAssetModel.h"

@implementation ZTEAssetModel

+ (instancetype)assetModelWithAsset:(id)asset assetType:(ZTEAssetModelType)assetType timeLength:(NSString *)timeLength{
    return [self assetModelWithAsset:asset assetType:assetType timeLength:timeLength identify:nil];
}

+ (instancetype)assetModelWithAsset:(id)asset assetType:(ZTEAssetModelType)assetType timeLength:(NSString *)timeLength identify:(NSString *)identify{
    ZTEAssetModel *model = [[ZTEAssetModel alloc]init];
    model.asset = asset;
    model.type = assetType;
    model.timeLength = timeLength;
    model.isSelected = NO;  // 默认非选中状态
    model.identify = identify;
    return model;
}

@end
