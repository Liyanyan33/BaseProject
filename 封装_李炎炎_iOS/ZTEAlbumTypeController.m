//  ZTEAlbumTypeController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEAlbumTypeController.h"
#import "ZTEAlbumTypeCell.h"
#import "ZTEAlbumManager.h"
#import "ZTEImageCollecionController.h"
#import "ZTEImagePickerController.h"

@interface ZTEAlbumTypeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ZTEAlbumTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadSystemAblum];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
}

#pragma mark private method
- (void)createUI{
    [self.view addSubview:self.tableView];
}

// 加载手机系统的相册
- (void)loadSystemAblum{
    ZTEImagePickerController *pickController = (ZTEImagePickerController*)self.navigationController;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[ZTEAlbumManager shareAlbumManager] getAllAlbumsAllowPickingVideo:YES allowPickingImage:YES completion:^(NSArray<ZTEAlbumModel *> *models) {
            // 获取相册数组
            _dataArr = [NSMutableArray arrayWithArray:models];
            for (ZTEAlbumModel *albumModel in _dataArr) {
                albumModel.assetSelectedArr = pickController.selectedAssetArr;
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_tableView == nil) {
                [self createUI];
            }else{
                [_tableView reloadData];
            }
        });
    });
}

#pragma mark 监听事件回调

#pragma mark 代理回调
#pragma mark UITableViewDataSource  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTEAlbumTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ZTEAlbumTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ZTEAlbumModel *albumModel = _dataArr[indexPath.row];
    [cell configCellWithDataModel:albumModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTEImageCollecionController *imageCollection = [[ZTEImageCollecionController alloc]init];
    imageCollection.columCount = self.columnCount;
    imageCollection.albumModel = _dataArr[indexPath.row];
    [self.navigationController pushViewController:imageCollection animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenFitH(70);
}

#pragma mark setter getter
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 设置尾视图
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
