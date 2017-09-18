//
//  ZTEImagePickerController.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片选择器

#import <UIKit/UIKit.h>
#import "ZTEAssetModel.h"

@class ZTEImagePickerController;
@protocol ZTEImagePickerControllerDelegate <NSObject>
@optional
- (void)imagePickerController:(ZTEImagePickerController*)imagePickerController didFinshedSelectedImages:(NSArray<UIImage*>*)imageArr;
- (void)imagePickerController:(ZTEImagePickerController *)imagePickerController didFinshedSelectedImages:(NSArray<UIImage *> *)imageArr didFinshedSelectedAssets:(NSArray*)assetArr;
- (void)imagePickerController:(ZTEImagePickerController *)imagePickerController didFinshedSelectedImages:(NSArray<UIImage *> *)imageArr didFinshedSelectedAssets:(NSArray*)assetArr didFinshedSelectedInfo:(NSArray*)infoArr;
@end

@interface ZTEImagePickerController : UINavigationController
/** 用户选择图片的最大数量 默认为9 */
@property(nonatomic,assign)NSInteger maxImageCount;
/** 用户选择图片的最小数量 默认是0 */
@property (nonatomic, assign) NSInteger minImagesCount;

/** 导出图片的宽度，默认828像素宽 */
@property (nonatomic, assign) CGFloat photoWidth;
/** 代理对象 */
@property(nonatomic,weak)id<ZTEImagePickerControllerDelegate> imagePickerDelegate;
/** 构造方法 */
- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount;
- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount columnCount:(NSInteger)columnCount;
- (instancetype)initWithMaxImageCount:(NSInteger)maxImageCount columnCount:(NSInteger)columnCount  pushPhotoPickerVc:(BOOL)pushPhotoPickerVc;
/** 用户选中的资源数组 */
@property(nonatomic,strong)NSMutableArray<ZTEAssetModel*> *selectedAssetArr;

/// Appearance / 外观颜色 + 按钮文字
@property (nonatomic, strong) UIColor *oKButtonTitleColorNormal;
@property (nonatomic, strong) UIColor *oKButtonTitleColorDisabled;
@property (nonatomic, strong) UIColor *naviBgColor;
@property (nonatomic, strong) UIColor *naviTitleColor;
@property (nonatomic, strong) UIFont *naviTitleFont;
@property (nonatomic, strong) UIColor *barItemTextColor;
@property (nonatomic, strong) UIFont *barItemTextFont;

/** 弹出提示框 */
- (void)showAlertView:(NSString*)title;

@end
