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
/** tableView子控件 */
@property(nonatomic,strong)UITableView *tableView;
/** 分页下载的数据记录数 */
@property(nonatomic,assign)int pageSize;
/** 分页下载的页数 */
@property(nonatomic,assign)int pageNum;

- (UITableView*)getTableView;
/** 设置tableView的类型 */
- (UITableViewStyle)getTableViewStytle;

- (void)showDataArrayWithAdapter:(id)adapter;

- (void)showDataWithArray:(NSMutableArray*)dataArray;

- (void)showDataWithArray:(NSMutableArray *)dataArray adapter:(id)adapter identifier:(NSString*)identifier;

/** 设置是否 上 下拉刷新 */
- (void)setHeaderRefresh:(BOOL)headerRefresh footerRefresh:(BOOL)footerRefresh;
/** 下拉刷新 回调 */
- (void)refreshData;
/** 上拉加载更多 回调 */
- (void)loadMoreData;
/** 获取数据源 */
- (NSMutableArray*)getData;
/** 获取无数据展示的视图控件 */
- (UIImageView*)getNoDataImageView;

- (void)showNoDataImageView;

- (void)hideNoDataImageView;

/** 创建tableView的适配器 */
- (id)createAdapter;
/** 数据加载成功之后的回调(刷新表格) */
- (void)onSuccessWithData:(NSArray*)dataArray;
/** 数据加载失败之后的回调 弹出提示 */
- (void)onFalid;

@end
