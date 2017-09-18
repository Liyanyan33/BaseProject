//  ZTEImageCollecionController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#define bottomViewH 44
#define itemMargin 5

#import "ZTEImageCollecionController.h"
#import "ZTEImageCollectionCell.h"
#import "ZTEImageCollectinBottomVIew.h"
#import "ZTEImagePreViewController.h"
#import "ZTEAlbumManager.h"
#import "ZTEImagePickerController.h"
#import "NSBundle+ZTEImagePicker.h"

@interface ZTEImageCollecionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZTEImageCollectinBottomVIew *bottomView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ZTEImageCollecionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - bottomViewH);
    self.bottomView.frame = CGRectMake(0, kScreenHeight  - bottomViewH, kScreenWidth, bottomViewH);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestAssetModel];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark private method
- (void)createUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
}

- (void)requestAssetModel{
    ZTEImagePickerController *pickController = (ZTEImagePickerController*)self.navigationController;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[ZTEAlbumManager shareAlbumManager] getAssetModelArrFromFetchResult:_albumModel.result allowPickingVideo:YES allowPickingImage:YES completion:^(NSArray<ZTEAssetModel *> *assetModels) {
            _dataArr = [NSMutableArray arrayWithArray:assetModels];
            [self resetAssetModelStatu];
            
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
            [_bottomView updateBottomViewStatu:pickController.selectedAssetArr];
        });
    });
}

// 重置assetModel的状态
- (void)resetAssetModelStatu{
    for (ZTEAssetModel *model in _dataArr) {
        model.isSelected = NO;
        ZTEImagePickerController *pickController = (ZTEImagePickerController*)self.navigationController;
        NSMutableArray *navSelectedAssetModelArr = [[NSMutableArray alloc]init];
        for (ZTEAssetModel *selectedModel in pickController.selectedAssetArr) {
            [navSelectedAssetModelArr addObject:selectedModel.asset];
        }
        // 每次进入此页面 都会重新去加载数据 那么ZTEAssetModel分配的内存空间 前后会完全不同 但是资源数据本身却是相同的 asset
        if ([[ZTEAlbumManager shareAlbumManager] isAssetsArray:navSelectedAssetModelArr containAsset:model.asset]) {
            model.isSelected = YES;
        }
    }
}

#pragma mark 监听事件回调

#pragma mark 代理回调
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTEImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image_collecion_cell" forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    ZTEAssetModel *assetModel = _dataArr[indexPath.row];
    [cell configCellWithDataModel:assetModel indexPath:indexPath];
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    ZTEImagePickerController *pickControllerNav = (ZTEImagePickerController*)self.navigationController;
    cell.ImageCellClickSelBtn = ^(BOOL isSelAsset){
        if (isSelAsset) { // 选中
            if (pickControllerNav.selectedAssetArr.count < pickControllerNav.maxImageCount) {// 在选择数量范围之内
                assetModel.isSelected = YES;
                [pickControllerNav.selectedAssetArr addObject:assetModel];
                [_bottomView updateBottomViewStatu:pickControllerNav.selectedAssetArr];
            }else{ // 超过最大选择阈值 弹出提示框
                weakCell.isSelected = isSelAsset;
                NSString *title = [NSString stringWithFormat:[NSBundle zte_localizedStringForKey:@"Select a maximum of %zd photos"], pickControllerNav.maxImageCount];
                [pickControllerNav showAlertView:title];
            }
        }else{ // 取消
            // 每次进入此页面 都会重新去加载数据 那么ZTEAssetModel分配的内存空间 前后会完全不同 但是资源数据本身却是相同的 asset
            // 利用 资源数据的 唯一标识 identify  定位删除目标数据 否则会出现 选择的模型数据无法删除  被选中数组的数量会越来越多
            // 始终待在此页面 不会出现问题  如果发生页面的切换 再次回到此页面 会重新加载所有数据 重新分配内存空间 如果再使用模型进行数据删除就会出现问题
            for (ZTEAssetModel *selectedModel in pickControllerNav.selectedAssetArr) {
                if ([[[ZTEAlbumManager shareAlbumManager] getAssetModelIdentify:selectedModel.asset] isEqualToString:[[ZTEAlbumManager shareAlbumManager] getAssetModelIdentify:assetModel.asset]]) {
                    [pickControllerNav.selectedAssetArr removeObject:selectedModel];
                    break;
                }
            }
            assetModel.isSelected = NO;
            [_bottomView updateBottomViewStatu:pickControllerNav.selectedAssetArr];
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTEImagePreViewController *ipc = [[ZTEImagePreViewController alloc]init];
    ipc.modelArr = _dataArr;
    [self.navigationController pushViewController:ipc animated:YES];
}

/** 提交用户选择的资源数组 */
- (void)submitAsset{
    ZTEImagePickerController *imagePickController = (ZTEImagePickerController*)self.navigationController;
    if (imagePickController.minImagesCount && imagePickController.selectedAssetArr.count < imagePickController.minImagesCount) {
        NSString *title = [NSString stringWithFormat:[NSBundle zte_localizedStringForKey:@"Select a minimum of %zd photos"],imagePickController.minImagesCount];
        [imagePickController showAlertView:title];
        return;
    }
    NSLog(@"已经进入准备提交阶段");
    
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    NSMutableArray *assetArr = [[NSMutableArray alloc]init];
    NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < imagePickController.selectedAssetArr.count; i++) {
        [imageArr addObject:@1];
        [assetArr addObject:@1];
        [infoArr addObject:@1];
    }
    // 根据资源asset 去获取我们最终需要的图片UIImage
    for (int i = 0; i < imagePickController.selectedAssetArr.count; i++) {
        ZTEAssetModel *assetModel = imagePickController.selectedAssetArr[i];
        [[ZTEAlbumManager shareAlbumManager] getImageWithAsset:assetModel.asset completion:^(UIImage *image, NSDictionary *info) {
            if (info) {
                [infoArr replaceObjectAtIndex:i withObject:info];
            }
            // 设置图片的尺寸
            if (image) {
                CGSize imageSize = CGSizeMake(imagePickController.photoWidth, (int)(imagePickController.photoWidth * image.size.height / image.size.width));
                UIImage *newImage = [self scaleImage:image toSize:imageSize];
                [imageArr replaceObjectAtIndex:i withObject:newImage];
            }
            [assetArr replaceObjectAtIndex:i withObject:assetModel.asset];
            
            for (id item in imageArr) {
               if ([item isKindOfClass:[NSNumber class]])
               return;
            }
            // 获取了 所有数据 将数据传递给 监听者
            [self didGetAllImage:imageArr assetArr:assetArr infoArr:infoArr];
        } progressHandler:^(double progress) {
            
        } networkAccessAllowed:YES];
    }

}

/// Scale image / 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 调用代理回调 传出 图片 asset  info 等参数信息
- (void)didGetAllImage:(NSArray*)imageArr assetArr:(NSArray*)assetArr infoArr:(NSArray*)infoArr{
    ZTEImagePickerController *imagePickController = (ZTEImagePickerController*)self.navigationController;
    if (imagePickController.imagePickerDelegate && [imagePickController.imagePickerDelegate respondsToSelector:@selector(imagePickerController:didFinshedSelectedImages:)]) {
        [imagePickController.imagePickerDelegate imagePickerController:imagePickController didFinshedSelectedImages:imageArr];
    }
    if (imagePickController.imagePickerDelegate && [imagePickController.imagePickerDelegate respondsToSelector:@selector(imagePickerController:didFinshedSelectedImages:didFinshedSelectedAssets:)]) {
        [imagePickController.imagePickerDelegate imagePickerController:imagePickController didFinshedSelectedImages:imageArr didFinshedSelectedAssets:assetArr];
    }
    if (imagePickController.imagePickerDelegate && [imagePickController.imagePickerDelegate respondsToSelector:@selector(imagePickerController:didFinshedSelectedImages:didFinshedSelectedAssets:didFinshedSelectedInfo:)]) {
        [imagePickController.imagePickerDelegate imagePickerController:imagePickController didFinshedSelectedImages:imageArr didFinshedSelectedAssets:assetArr didFinshedSelectedInfo:infoArr];
    }
}

#pragma mark setter getter
- (UICollectionView*)collectionView{
    if (!_collectionView) {
        // 创建流式布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 集合视图 是多行多列显示 collectionCell的
        // minimumLineSpacing 表示行与行之间的 最小间距
        layout.minimumLineSpacing = itemMargin;
        // minimumInteritemSpacing 表示列与列之间的 最小间距
        layout.minimumInteritemSpacing = itemMargin;
        // itemSize 返回每个collectionCell的尺寸大小
        CGFloat itemW = (kScreenWidth - (self.columCount+1)*itemMargin)/self.columCount;
        layout.itemSize = CGSizeMake(itemW, itemW);
        // scrollDirection 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 60) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin);
        [_collectionView registerClass:[ZTEImageCollectionCell class] forCellWithReuseIdentifier:@"image_collecion_cell"];
    }
    return _collectionView;
}

- (ZTEImageCollectinBottomVIew*)bottomView{
    __weak typeof(self) weakSelf = self;
    if (!_bottomView) {
        _bottomView = [[ZTEImageCollectinBottomVIew alloc]init];
        _bottomView.doneBtnClickBlock = ^(){ //点击done按钮
            [weakSelf submitAsset];
        };
    }
    return _bottomView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZTEImagePickerController *pickControllerNav = (ZTEImagePickerController*)self.navigationController;
    for (ZTEAssetModel *selectedModel in pickControllerNav.selectedAssetArr) {
        NSLog(@"%@",selectedModel);
    }
}
@end
