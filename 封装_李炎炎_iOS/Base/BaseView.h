//
//  BaseView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

/** 创建内部的组件 让子类去实现 */
- (void)createUI;

/** 根据传输的数据（viewModel）配置view */
- (void)configWithViewModel:(id)viewModel;

@end
