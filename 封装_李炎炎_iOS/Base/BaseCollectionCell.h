//
//  BaseCollectionCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/20.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell
/** 实例化构造方法 */
+ (instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexPath:(NSIndexPath*)indexPath;

/** 创建内部的组件 让子类去实现 */
- (void)createUI;

/** 根据普通模型(model 只包含数据)来配置cell */
- (void)configCellWithModel:(id)model indexPath:(NSIndexPath*)indexPath;

/** 根据特殊模型(viewModel 包含数据与frame) 来配置cell */
- (void)configCellWithViewModel:(id)viewModel indexPath:(NSIndexPath*)indexPath;

/** 通过模型来计算cell的高度 */
+ (CGFloat)calCellHeightWithModel:(id)modelData;
@end
