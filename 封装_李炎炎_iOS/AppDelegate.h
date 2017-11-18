//
//  AppDelegate.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL allowRotation;
@property (nonatomic, strong) SettingModel *settingModel;
@end

