//
//  BaseTableAdapter.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/21.
//  Copyright © 2016年 ZXJK. All rights reserved.

// 针对tableView显示 的基类适配器

#import <Foundation/Foundation.h>

typedef void(^BaseTableCellSelectedBlock)(NSIndexPath *indexPath);            // 点击cell的回调
typedef void(^BaseTableCellBtnBlock)(int row,int tag);        // 点击cell中按钮的回调


@interface BaseTableAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *cellIdentifiers;                // cell样式选择
@property (nonatomic, copy) NSMutableArray *sourceData;                     // cell数据
@property (nonatomic, copy) BaseTableCellSelectedBlock cellSelectedBlock;   // cell点击事件
@property(nonatomic,copy)BaseTableCellBtnBlock cellBtnClickBlock;

/**
 *  初始化dataSource
 *
 *  @param serverData  服务器返回数据
 *  @param identifiers cell类型
 *
 *  @return Datasource
 */
- (instancetype)initWithSourceData:(NSMutableArray *)sourceData andCellIdentifiers:(NSString *)identifiers withCellBlock:(BaseTableCellSelectedBlock)cellBlock;

@end
