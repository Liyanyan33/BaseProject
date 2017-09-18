//  ZTEImagePickerController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEImagePickerController.h"
#import "ZTEAlbumTypeController.h"

@interface ZTEImagePickerController ()

@end

@implementation ZTEImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    
    // Default appearance, you can reset these after this method
    // 默认的外观，你可以在这个方法后重置
    self.oKButtonTitleColorNormal   = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0];
    self.oKButtonTitleColorDisabled = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5];
    
    if (iOS7Later) {
        self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount{
    return [self initWithMaxImageCount:maxImageCount columnCount:4 pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount columnCount:(NSInteger)columnCount{
    return  [self initWithMaxImageCount:maxImageCount columnCount:columnCount pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount columnCount:(NSInteger)columnCount pushPhotoPickerVc:(BOOL)pushPhotoPickerVc{
    ZTEAlbumTypeController *albumVC = [[ZTEAlbumTypeController alloc]init];
    albumVC.columnCount = columnCount;
    self = [super initWithRootViewController:albumVC];
    if (self) {
        _selectedAssetArr = [[NSMutableArray alloc]init];
        _maxImageCount = maxImageCount;
        
        [self configDefaultSetting];
    }
    return self;
}

#pragma mark private method
- (void)showAlertView:(NSString *)title{
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (void)configDefaultSetting {
    self.photoWidth = 828.0;
    self.naviTitleColor = [UIColor whiteColor];
    self.naviTitleFont = [UIFont systemFontOfSize:17];
    self.barItemTextFont = [UIFont systemFontOfSize:15];
    self.barItemTextColor = [UIColor whiteColor];
}


#pragma mark 监听事件回调

#pragma mark 代理回调

#pragma mark setter getter

@end
