//
//  BaseTableViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseTableController.h"
#import "BaseTableAdapter.h"

@interface BaseTableController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSMutableArray *_array;
    int _loadType;   // 请求数据的方式  1 上拉刷新  2 下拉加载
}
@property(nonatomic,strong)UIImageView *noDataImageView;
@property(nonatomic,strong)BaseTableAdapter *adapter;
@end

@implementation BaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [[NSMutableArray alloc]init];
    _loadType = 1;
    [self.view addSubview:self.tableView];
//    [self setNoDataView];
    [self.tableView addSubview:self.noDataImageView];
    // 默认情况下 上拉和下拉刷新都存在
    [self setHeaderRefresh:YES footerRefresh:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWork:) name:@"NetWorkingStatu" object:nil];
}

- (void)setNoDataView{
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (NSAttributedString*)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc]initWithString:@"你满B"];
}

/** tableView 默认类型 */
- (UITableViewStyle)getTableViewStytle{
    return UITableViewStylePlain;
}

- (void)netWork:(NSNotification*)notification{
    NSString *netStatu = notification.userInfo[NetWorkingStatu];
    if ([netStatu isEqualToString:@"noNet"]) {
        [self showNoNet];
    }else if ([netStatu isEqualToString:@"yesNet"]){
        [self showYesNet];
    }
}

- (void)showNoNet{
    UIView *netView = [self getNetView];
    netView.hidden = NO;
    _tableView.y = CGRectGetMaxY(netView.frame);
}

- (void)showYesNet{
    UIView *netView = [self getNetView];
    netView.hidden = YES;
    _tableView.y = 64;
}

- (void)showNetAlert:(NSString*)title type:(int)type{
    if (type == 1) {
        
    }else{
        [self showAlert:title];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

/** 设置是否上下拉刷新 */
- (void)setHeaderRefresh:(BOOL)headerRefresh footerRefresh:(BOOL)footerRefresh{
    if (headerRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    }else{
        self.tableView.mj_header = nil;
    }
    if (footerRefresh) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }else{
        self.tableView.mj_footer = nil;
    }
}

- (void)showDataArrayWithAdapter:(id)adapter{
    _tableView.dataSource = adapter;
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];
}

- (void)showDataWithArray:(NSMutableArray *)dataArray{
    NSLog(@"数组元素的个数  = %ld",dataArray.count);
    _array = dataArray;
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];
}

- (void)showDataWithArray:(NSMutableArray *)dataArray adapter:(id)adapter identifier:(NSString *)identifier{
    _array = dataArray;
    [_tableView.mj_header endRefreshing];
    [_tableView reloadData];
}

- (NSMutableArray*)getData{
    return _array;
}

// 下拉刷新最新数据
- (void)refreshData{
    _loadType = 1;  
    _pageNum = 1;
}

//上拉加载更多数据
- (void)loadMoreData{
    _loadType = 2;
    _pageNum++;
}

- (UITableView*)getTableView{
    if (_tableView) {
        return _tableView;
    }else{
        return self.tableView;
    }
}

- (UIImageView*)getNoDataImageView{
    if (_noDataImageView) {
        return _noDataImageView;
    }else{
        return self.noDataImageView;
    }
}

- (void)showNoDataImageView{
    _noDataImageView.hidden = NO;
}

- (void)hideNoDataImageView{
    _noDataImageView.hidden = YES;
}

- (id)createAdapter{
    return nil;
}

- (void)onFalid{
    [_tableView.mj_header endRefreshing];
}

- (void)onSuccessWithData:(NSArray *)dataArray{
    // 结束刷新动画
    if (_tableView.mj_header) {
        [_tableView.mj_header endRefreshing];
    }
    
    // 网络请求获取的数据 本地化
    if (_loadType == 1) {
        _array = (NSMutableArray*)dataArray;
    }else{
        [_array addObjectsFromArray:dataArray];
    }
    
    // 判断是否显示 无数据时的视图
    if (_array.count == 0) { // 表明没有数据  显示无数据时的视图
        [self showNoDataImageView];
    }
    
    // 根据获取的网络数据 创建 tableView的适配器
    if (!_adapter) { // adapter不存在时创建 存在直接刷新表格
        _adapter = [self createAdapter];
        _tableView.dataSource = _adapter;
        _tableView.delegate = _adapter;
    }
    // 需要将数据传递给adapter
    _adapter.sourceData = _array;
    [_tableView reloadData];
}

#pragma mark 监听事件
- (void)tapToLoadData:(UITapGestureRecognizer*)sender{
    NSLog(@"%s",__func__);
    [self refreshData];
}

#pragma mark 懒加载
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:[self getTableViewStytle]];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = 0.1f;
        _adapter = [self createAdapter];   // 解决消除UITableViewGroupStytle 顶部默认间距 在此处就设置 tableView的代理对象 而不是 等拿到网络数据时才设置(如果那样会出现问题 顶部间距 无论怎么设置 都不能使之消除)
        _tableView.delegate = _adapter;
        _tableView.dataSource = _adapter;
    }
    return _tableView;
}

- (UIImageView*)noDataImageView{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _noDataImageView.image = [UIImage imageNamed:@"base_no_data.png"];
        _noDataImageView.hidden = YES;  //隐藏
        _noDataImageView.userInteractionEnabled = YES; // 开启交互事件
        // 给无数据的视图 添加一个手势 点击时可以重新加载数据
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToLoadData:)];
        [_noDataImageView addGestureRecognizer:tap];
    }
    return _noDataImageView;
}
@end
