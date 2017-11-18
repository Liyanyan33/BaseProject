//
//  FPSDisplay.h
//  DisplayLayout
//
//  Created by Mr.LuDashi on 16/9/8.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//  FTP显示
#import <UIKit/UIKit.h>

@interface FPSDisplayUtils: NSObject
+ (instancetype)shareFPSDisplay;

- (void)addView;

- (void)remove;

@end
