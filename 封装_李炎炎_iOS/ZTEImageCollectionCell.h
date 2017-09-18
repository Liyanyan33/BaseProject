//
//  ZTEImageCollectionCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 选择按钮的点击回调  (是否选中当前图片)*/
typedef void(^ImageCellClickSelBtn)(BOOL isSelAsset);

@interface ZTEImageCollectionCell : UICollectionViewCell
@property(nonatomic,copy)ImageCellClickSelBtn ImageCellClickSelBtn;
/** 资源是否被选中 */
@property(nonatomic,assign)BOOL isSelected;

- (void)configCellWithDataModel:(id)dataModel indexPath:(NSIndexPath*)indexPath;
@end
