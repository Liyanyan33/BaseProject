//
//  AppDelegate.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//
#import "AppDelegate.h"
#import "LYNavController.h"
#import "OnLineController.h"
#import "TestController.h"
#import "FPSDisplayUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 监听网络变化 */
//    [self detectionNetWorking];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TestController *tvc = [[TestController alloc]init];
    
    LYNavController *nav = [[LYNavController alloc]initWithRootViewController:tvc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    [[FPSDisplayUtils shareFPSDisplay] addView];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    if (self.settingModel.recording) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
