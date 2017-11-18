//  ZTEImagePreViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片浏览控制器

#import "ZTEImagePreViewController.h"
#import "ZTEPreViewNavBar.h"
#import "ZTEPreViewBottomBar.h"
#import "ZTEImagePreViewCell.h"
#import "ZTEAssetModel.h"

@interface ZTEImagePreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZTEPreViewNavBar *navBar;
@property(nonatomic,strong)ZTEPreViewBottomBar *bottomBar;
@end

@implementation ZTEImagePreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark private method
- (void)createUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.bottomBar];
}

#pragma mark 监听事件回调

#pragma mark 代理回调
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTEImagePreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image_preview_cell" forIndexPath:indexPath];
    ZTEAssetModel *model = _modelArr[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

#pragma mark setter getter
- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[ZTEImagePreViewCell class] forCellWithReuseIdentifier:@"image_preview_cell"];
    }
    return _collectionView;
}

- (ZTEPreViewNavBar*)navBar{
    if (!_navBar) {
        __weak typeof(self) weakSelf = self;
        _navBar = [[ZTEPreViewNavBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _navBar.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:0.7];
        _navBar.buttonClickBlock = ^(NSInteger tag){
            if (tag == ZTEPreViewNavBarButtonTypeBack) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
        };
    }
    return _navBar;
}

- (ZTEPreViewBottomBar*)bottomBar{
    if (!_bottomBar) {
        _bottomBar = [[ZTEPreViewBottomBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
        _bottomBar.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:0.7];
    }
    return _bottomBar;
}
@end
