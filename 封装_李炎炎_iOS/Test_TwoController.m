//
//  Test_TwoController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//
#define marginLeft 10
#define marginRight 10
#define buttonH 35
#define buttonPadding 15

#import "Test_TwoController.h"
#import "ZTEAlbumManager.h"
#import "ZTEImagePickerController.h"

@interface Test_TwoController ()<ZTEImagePickerControllerDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UILabel *txtLabel;
@end

@implementation Test_TwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试控制器_02";
//    NSLog(@"执行片段>>>");
    [self createUI];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 耗时操作
//        NSURL *url = [NSURL URLWithString:@"http://img.ztehealth.com/Uploads/2016129155635a.png"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@"执行片段<<<");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 更新UI
//            NSLog(@"执行片段xxx");
//            self.imageView.image = image;
//        });
//    });
//    NSLog(@"执行片段---");
//    
//    CGFloat x =  ScaleScreenFitX(10, 1.5);
//    NSLog(@" x = %f",x);
//    
//    NSLog(@"屏幕的宽度 = %f -- 屏幕的高度 = %f",kScreenWidth,kScreenHeight);
    
    [[ZTEAlbumManager shareAlbumManager] getAllAlbumsAllowPickingVideo:YES allowPickingImage:YES completion:^(NSArray<ZTEAlbumModel *> *models) {
        NSArray *albumModelArr = [NSArray arrayWithArray:models];
        for (ZTEAlbumModel *model in albumModelArr) {
            NSLog(@"%@",model.name);
        }
        ZTEAlbumModel *fModel = albumModelArr.firstObject;
        self.txtLabel.attributedText = fModel.attStr;
    }];
}

- (void)createUI{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.cancleBtn];
    [self.view addSubview:self.txtLabel];
    [self layoutUI];
}

- (void)layoutUI{
    _sureBtn.frame = CGRectMake(ScreenFitX(marginLeft), 300, (kScreenWidth - 2*ScreenFitX(marginRight) - ScreenFitW(buttonPadding))/2, ScreenFitH(buttonH));
    _cancleBtn.frame = CGRectMake(kScreenWidth - ScreenFitX(marginLeft) - _sureBtn.width, 300, _sureBtn.width, ScreenFitH(buttonH));
    
    _txtLabel.frame = CGRectMake(10, 200,kScreenWidth - 20, 30);
}

#pragma mark 监听事件
- (void)sureClick:(UIButton*)sender{
    ZTEImagePickerController *imagePickVC = [[ZTEImagePickerController alloc]initWithMaxImageCount:9 columnCount:4 pushPhotoPickerVc:YES];
    imagePickVC.minImagesCount = 4;
    imagePickVC.imagePickerDelegate = self;
    [self presentViewController:imagePickVC animated:YES completion:nil];
}

#pragma mark ZTEImagePickerControllerDelegate
- (void)imagePickerController:(ZTEImagePickerController *)imagePickerController didFinshedSelectedImages:(NSArray<UIImage *> *)imageArr didFinshedSelectedAssets:(NSArray *)assetArr didFinshedSelectedInfo:(NSArray *)infoArr{
    NSLog(@"选择的图片的数量 == %ld",imageArr.count);
}

#pragma mak 懒加载
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 150)];
    }
    return _imageView;
}

- (UIButton*)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [ZTEUIKit buttonWtihNormalText:@"确定" font:ScreenFitFont(17) normalTextColor:[UIColor whiteColor]];
        [_sureBtn setCornerRadius:5.0 borderW:1.0 borderCorlor:[UIColor whiteColor]];
        _sureBtn.backgroundColor = [UIColor greenColor];
        [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureBtn;
}

- (UIButton*)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [ZTEUIKit buttonWtihNormalText:@"取消" font:ScreenFitFont(17) normalTextColor:[UIColor whiteColor]];
        [_cancleBtn setCornerRadius:5.0f borderW:1.0 borderCorlor:[UIColor whiteColor]];
        _cancleBtn.backgroundColor = [UIColor grayColor];
    }
    return _cancleBtn;
}

- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
    }
    return _txtLabel;
}

@end
