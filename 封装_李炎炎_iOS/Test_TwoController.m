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
#import "VideoListViewModel.h"
#import "PlayerViewController.h"
#import "Masonry.h"
#import "PlayerViewController.h"
#import "PlayerViewModel.h"
#import "Constant.h"
#import "SuspendPlayView.h"
#import "VideoContainerView.h"
#import "VideoModel.h"
#import "UIView+Toast.h"

@interface Test_TwoController ()<ZTEImagePickerControllerDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UILabel *txtLabel;

@property (nonatomic, assign) BOOL willAppearFromPlayerView;
@property (nonatomic, strong) SuspendPlayView  *suspendView;
@property (nonatomic, strong) UIView *clearView;
@property (nonatomic, strong) PlayerViewController      *pvc;
@property (nonatomic, assign) BOOL isMoving;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (_willAppearFromPlayerView) {
        [self.view addSubview:self.clearView];
        [self.view addSubview:self.suspendView];
        [self.clearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        self.suspendView.frame = CGRectMake(0, 0, 200, 113);
        self.suspendView.center = self.view.center;
        
        [self.pvc.videoContainerView removeFromSuperview];
        [self.suspendView addSubview:self.pvc.videoContainerView];
        [self.suspendView sendSubviewToBack:self.pvc.videoContainerView];
        [self.pvc.videoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.suspendView);
        }];
        [self addChildViewController:self.pvc];
        [self.pvc.videoContainerView suspendHandler];
        self.willAppearFromPlayerView = NO;
        self.hasSuspendView = YES;
    }
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
        __weak typeof(self) weakSelf = self;
        _sureBtn = [UIButton buttonWtihNormalText:@"确定" font:ScreenFitFont(17) normalTextColor:[UIColor whiteColor]];
        [_sureBtn setCornerRadius:5.0 borderW:1.0 borderCorlor:[UIColor whiteColor]];
        _sureBtn.backgroundColor = [UIColor greenColor];
        [_sureBtn addClickBlock:^{
            ZTEImagePickerController *imagePickVC = [[ZTEImagePickerController alloc]initWithMaxImageCount:9 columnCount:4 pushPhotoPickerVc:YES];
            imagePickVC.minImagesCount = 4;
            imagePickVC.imagePickerDelegate = weakSelf;
            [weakSelf presentViewController:imagePickVC animated:YES completion:nil];
        }];
    }
    return _sureBtn;
}

- (UIButton*)cancleBtn{
    if (!_cancleBtn) {
        __weak typeof(self) weakSelf = self;
        _cancleBtn = [UIButton buttonWtihNormalText:@"取消" font:ScreenFitFont(17) normalTextColor:[UIColor whiteColor]];
        [_cancleBtn setCornerRadius:5.0f borderW:1.0 borderCorlor:[UIColor whiteColor]];
        [_cancleBtn addClickBlock:^{
            //    PlayerViewModel *playerViewModel = [[PlayerViewModel alloc] init];
            //    PlayerViewController *pvc = [[PlayerViewController alloc] initWithPlayerViewModel:playerViewModel];
            //    self.pvc = pvc;
            //    __weak typeof(self) weakSelf = self;
            //    pvc.willDisappearBlocked = ^{
            //        typeof(weakSelf) strongSelf = weakSelf;
            //        strongSelf.willAppearFromPlayerView = YES;
            //    };
            //    [self.navigationController pushViewController:pvc animated:YES];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"title,nil时不显示"
                                          delegate:nil
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"确定"
                                          otherButtonTitles:@"第一项", @"第二项",@"第一项", @"第二项",@"第一项", @"第二项",@"第一项", @"第二项",@"第一项", @"第二项",@"第一项", @"第二项",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:weakSelf.view];
        }];
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

- (SuspendPlayView *)suspendView  {
    if (!_suspendView) {
        _suspendView = [[NSBundle mainBundle] loadNibNamed:@"SuspendPlayView" owner:self options:nil].firstObject;
        [_suspendView.closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSuspendHandler)];
        [_suspendView addGestureRecognizer:tap];
    }
    return _suspendView;
}

- (void)tapSuspendHandler {
    self.willAppearFromPlayerView = YES;
    self.hasSuspendView = NO;
    [self.pvc.videoContainerView removeFromSuperview];
    [self.pvc removeFromParentViewController];
    [self.suspendView removeFromSuperview];
    [self.clearView removeFromSuperview];
    [self.pvc pushFromSuspendHandler];
    [self.pvc.videoContainerView recoveryHandler];
    [self.navigationController pushViewController:self.pvc animated:YES];
}

- (UIView *)clearView {
    if (!_clearView) {
        _clearView = [[UIView alloc] init];
        _clearView.backgroundColor = [UIColor clearColor];
    }
    return _clearView;
}

- (void)closeButtonAction {
    [self.pvc.videoContainerView removeFromSuperview];
    [self.pvc removeFromParentViewController];
    [self.suspendView removeFromSuperview];
    [self.clearView removeFromSuperview];
    [self.pvc stopSuspend];
    self.pvc = nil;
    self.hasSuspendView = NO;
}

#pragma mark -- touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGPoint convertPoint = [self.view convertPoint:point toView:self.suspendView];
    if (convertPoint.x > 0 && convertPoint.y > 0) {
        self.isMoving = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if(!_isMoving){
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGPoint center = self.suspendView.center;
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
    
    if (center.x + offset.x >= 0 && center.x + offset.x <= self.view.frame.size.width &&
        center.y + offset.y >= 0 && center.y + offset.y <= self.view.frame.size.height - 64
        ) {
        self.suspendView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.isMoving = NO;
}
@end
