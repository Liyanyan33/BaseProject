//
//  ZTEPhotoContentView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  显示图片的内容视图

#import <UIKit/UIKit.h>
#import "ZTEPhotoBrowserCell.h"

#define kCellTagOffset 1000
#define kCellIndex(cell) ([cell tag] - kCellTagOffset)

@class ZTEPhotoContentView;
@protocol ZTEPhotoContentViewDataSource <NSObject>
@required
/** 返回多少cell */
- (NSInteger)cellCountOfZTEPhotoContentView:(ZTEPhotoContentView*)ZTEPhotoContentView;
/** 返回指定类型的cell  */
- (ZTEPhotoBrowserCell*)photoContentView:(ZTEPhotoContentView*)photoContentView cellAtPageIndex:(NSUInteger)pageIndex;
@end

@interface ZTEPhotoContentView : UIView
/** 数据源 */
@property(nonatomic,weak)id<ZTEPhotoContentViewDataSource> dataSource;
/** 当前显示的cell的index */
@property(nonatomic,assign)NSInteger currentIndex;
/** 内容间距padding */
@property (nonatomic,assign) CGFloat padding;
/** 是否自动滚动 */
@property(nonatomic,assign) BOOL isAutoRoll;
/** 根据数据源 刷新UI */
- (void)reloadData;
/** 根据可重用标识 去可重用缓存池中 去取cell */
- (id)dequeueReuseIdentifierCell:(NSString*)reuseIdentifier;

- (void)scrolToCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated;

@end
