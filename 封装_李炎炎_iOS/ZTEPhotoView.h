//
//  ZTEPhotoView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  九宫格中的单张图片 view控件

#import <UIKit/UIKit.h>
#import "ZTEPhotoModel.h"

@interface ZTEPhotoView : UIImageView
@property (nonatomic, strong) ZTEPhotoModel *photo;
@end
