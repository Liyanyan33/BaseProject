//
//  ZTEBrowserPhotoModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片浏览器中的 图片模型数据

#import <Foundation/Foundation.h>

@interface ZTEBrowserPhotoModel : NSObject
/** 在数组中的index */
@property(nonatomic,assign) NSUInteger index;
/** 图片的URL */
@property(nonatomic,strong) NSURL *url;
/** 图片本身 */
@property (nonatomic,strong) UIImage *image;
/** 图片是否下载 */
@property(nonatomic,assign) BOOL isLoaded;
@end
