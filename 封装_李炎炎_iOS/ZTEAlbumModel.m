//
//  ZTEAlbumModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEAlbumModel.h"
#import "ZTEAlbumManager.h"

@implementation ZTEAlbumModel

- (void)setResult:(id)result{
    _result = result;
    [[ZTEAlbumManager shareAlbumManager] getAssetModelArrFromFetchResult:result allowPickingVideo:YES allowPickingImage:YES completion:^(NSArray<ZTEAssetModel *> *assetModels) {
        _assetModeArr = assetModels;
        if (_assetSelectedArr) {
            [self checkSelectedModels];
        }
    }];
}

- (NSAttributedString*)attStr{
    NSString *name = self.name;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:name];
    [att addAttribute:NSFontAttributeName value:ScreenFitFont(16) range:NSMakeRange(0, name.length)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, self.name.length)];
    
    NSString *count = [NSString stringWithFormat:@"  (%ld)",self.count];
    NSMutableAttributedString *attCount = [[NSMutableAttributedString alloc]initWithString:count];
    [attCount addAttribute:NSFontAttributeName value:ScreenFitFont(14) range:NSMakeRange(0, count.length)];
    [attCount addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, count.length)];
    
    [att appendAttributedString:attCount];
    return att;
}

- (void)setAssetSelectedArr:(NSArray *)assetSelectedArr{
    _assetSelectedArr = assetSelectedArr;
    if (_assetModeArr) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels{
    self.selectCount = 0;
    NSMutableArray *assetSelectArr = [[NSMutableArray alloc]init];
    for (ZTEAssetModel *model in _assetSelectedArr) {
        [assetSelectArr addObject:model.asset];
    }
    for (ZTEAssetModel *model in _assetModeArr) {
        if ([[ZTEAlbumManager shareAlbumManager] isAssetsArray:assetSelectArr containAsset:model.asset]) {
            self.selectCount++;
        }
    }
}
@end
