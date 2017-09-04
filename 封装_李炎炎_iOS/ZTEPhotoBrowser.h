//
//  ZTEPhotoBrowser.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/30.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  自定义的图片浏览器

#import <UIKit/UIKit.h>

@interface ZTEPhotoBrowser : UIViewController
/** 图片模型数组 */
@property(nonatomic,strong)NSArray *photoModelArr;
/** 当前显示的图片的index */
@property(nonatomic,assign)NSInteger currentPhotoIndex;
/** 展示图片浏览器 */
- (void)showPhotoBrowserWithImageUrls:(NSArray*)imageUrls clickImageIndex:(NSInteger)clickImageIndex;

@end
