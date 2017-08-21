//
//  BaseCollectionAdapter.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/21.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^BaseTableCellSelectedBlock)(NSIndexPath *indexPath);            // 点击cell的回调
typedef void(^BaseTableCellBtnBlock)(int row,int tag);        // 点击cell中按钮的回调

@interface BaseCollectionAdapter : NSObject<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, copy) NSArray *sourceData;                     // cell数据
@property (nonatomic, copy) BaseTableCellSelectedBlock cellSelectedBlock;   // cell点击事件
@property(nonatomic,copy)BaseTableCellBtnBlock cellBtnClickBlock;
- (instancetype)initWithCellBlock:(BaseTableCellSelectedBlock)cellBock;
@end
