//
//  ZTEImageCollectinBottomVIew.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTEAssetModel.h"

typedef void(^doneBtnClickBlock)(void);

@interface ZTEImageCollectinBottomVIew : UIView
@property(nonatomic,copy)doneBtnClickBlock doneBtnClickBlock;
/** 根据参数 刷新改变底部栏的数据状态 */
- (void)updateBottomViewStatu:(NSArray<ZTEAssetModel*>*)selectedAssetArr;
@end
