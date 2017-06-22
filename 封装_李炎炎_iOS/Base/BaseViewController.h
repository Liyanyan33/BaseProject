//
//  BaseViewController.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/26.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/** 网络监测 回调 显示横幅 */
- (UIView*)getNetView;

-(void)showAlert:(NSString *)str;

/** 导航栏左右按钮点击事件监听 */
- (void)navBarRightClick;
- (void)navBarLeftClick;

/** 获取数据 */
- (void)requestData;

/** 搭建控制器的View 的内部控件 */
- (void)createUI;

@end
