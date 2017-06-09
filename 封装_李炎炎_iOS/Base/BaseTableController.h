//
//  BaseTableViewController.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableController : BaseViewController

@property(nonatomic,assign)int pageSize;

@property(nonatomic,assign)int pageNum;

- (UITableView*)getTableView;

- (void)showDataArrayWithAdapter:(id)adapter;

- (void)showDataWithArray:(NSMutableArray*)dataArray;

- (void)showDataWithArray:(NSMutableArray *)dataArray adapter:(id)adapter identifier:(NSString*)identifier;

- (void)refreshData;

- (void)loadData;

/** 设置是否 上 下拉刷新 */
- (void)setHeaderRefresh:(BOOL)headerRefresh footerRefresh:(BOOL)footerRefresh;

- (NSMutableArray*)getData;

- (UIImageView*)getNoDataImageView;

- (void)showNoDataImageView;

- (void)hideNoDataImageView;

- (id)createAdapter;

- (void)onSuccessWithData:(NSArray*)dataArray;

- (void)onFalid;

@end
