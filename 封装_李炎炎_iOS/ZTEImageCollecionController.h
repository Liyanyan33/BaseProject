//
//  ZTEImageCollecionController.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  相册中的图片展示 以collectionView控件进行显示

#import <UIKit/UIKit.h>
#import "ZTEAlbumModel.h"

@interface ZTEImageCollecionController : UIViewController
/** 图片的列数 */
@property(nonatomic,assign)NSInteger columCount;
/** 相册模型 */
@property(nonatomic,strong)ZTEAlbumModel *albumModel;
@end
