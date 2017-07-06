//
//  ZTEJGGView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  九宫格 展示图片

#import <UIKit/UIKit.h>

@interface ZTEJGGView : UIView

/** 图片数组 根据图片数组的个数 创建内部控件的个数 */
@property (nonatomic, strong) NSArray *photos;

/** 根据图片个数计算九宫格的尺寸 */
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
