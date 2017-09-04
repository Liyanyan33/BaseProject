//
//  UIScrollView+AXEmptyDataSet.h
//  ZBP2P
//
//  Created by Mole Developer on 2017/2/20.
//  Copyright © 2017年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface UIScrollView (AXEmptyDataSet)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/**
 设置空集合view
 
 @param reloadBlock 刷新回调
 */
-(void)ax_emptyDataSetWithReloadBlock:(void(^)())reloadBlock;

/**
 设置空集合view
 
 @param imageName 占位图片名称
 @param title 占位文字
 @param reloadBlock 刷新回调
 */
-(void)ax_emptyDataWithImageName:(NSString *)imageName titlte:(NSString *)title reloadBlock:(void(^)())reloadBlock;

@end
