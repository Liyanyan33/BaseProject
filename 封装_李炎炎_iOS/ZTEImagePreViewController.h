//
//  ZTEImagePreViewController.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  图片浏览控制器

#import <UIKit/UIKit.h>

@interface ZTEImagePreViewController : UIViewController
/** 当前index位置 */
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSArray *modelArr;
@end
