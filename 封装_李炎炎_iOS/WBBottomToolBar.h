//
//  WBBottomToolBar.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,WBBottomToolBarBtnType) {
    WBBottomToolBarBtnTypeReweet,
    WBBottomToolBarBtnTypeShare,
    WBBottomToolBarBtnTypeLike,
};

typedef void(^WBBottomToolBarClickBlock)(NSInteger tag);

@class WBBottomToolBar;
@protocol WBBottomToolBarDataSource <NSObject>
@required
- (NSArray*)bottomToolBarForTextArr:(WBBottomToolBar*)bottomToolBar;
- (NSArray*)bottomToolBarForImageArr:(WBBottomToolBar*)bottomToolBar;
@end

@interface WBBottomToolBar : UIView
@property(nonatomic,weak)id<WBBottomToolBarDataSource> dataSource;
@property(nonatomic,copy)WBBottomToolBarClickBlock bottomToolBarClickBlock;
- (void)reloadData;
@end
