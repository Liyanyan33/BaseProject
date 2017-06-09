//
//  AppDelegate+Extension.m
//  LYDemo
//
//  Created by lyy on 16/4/8.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "AFNetworking.h"

@implementation AppDelegate (Extension)

- (void) detectionNetWorking{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //网络实时检测
    //1> 创建网络状态检测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    //2> 监听网络的状态
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
//                LYLog(@"未知网络");
                params[NetWorkingStatu] = @"AFNetworkReachabilityStatusUnknown";
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkingNotifyName object:nil userInfo:params];
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                LYLog(@"没有网络");
                params[NetWorkingStatu] = @"AFNetworkReachabilityStatusNotReachable";
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkingNotifyName object:nil userInfo:params];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                LYLog(@"3G|4G");
                params[NetWorkingStatu] = @"AFNetworkReachabilityStatusReachableViaWWAN";
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkingNotifyName object:nil userInfo:params];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                LYLog(@"WIFI");
                params[NetWorkingStatu] = @"AFNetworkReachabilityStatusReachableViaWiFi";
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkingNotifyName object:nil userInfo:params];
                break;
            default:
                break;
        }
    }];
    [manger startMonitoring];
}

- (void)registerLocalNotification
{
    /** 创建消息上面要添加的动作 */
    // 第一个动作
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = kNotificationActionIdentifileStar;
    action1.title = @"赞";
    
    //当点击的时候不启动程序，在后台处理
    action1.activationMode = UIUserNotificationActivationModeBackground;
    
    //需要解锁才能处理(意思就是如果在锁屏界面收到通知，并且用户设置了屏幕锁，用户点击了赞不会直接进入我们的回调进行处理，而是需要用户输入屏幕锁密码之后才进入我们的回调)，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action1.authenticationRequired = YES;
    
    /*
     destructive属性设置后，在通知栏或锁屏界面左划，按钮颜色会变为红色
     如果两个按钮均设置为YES，则均为红色（略难看）
     如果两个按钮均设置为NO，即默认值，则第一个为蓝色，第二个为浅灰色
     如果一个YES一个NO，则都显示对应的颜色，即红蓝双色 (CP色)。
     */
    action1.destructive = NO;
    
    
    //第二个动作
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = kNotificationActionIdentifileComment;
    action2.title = @"评论";
    
    //当点击的时候不启动程序，在后台处理
    action2.activationMode = UIUserNotificationActivationModeBackground;
    
    //设置了behavior属性为 UIUserNotificationActionBehaviorTextInput 的话，则用户点击了该按钮会出现输入框供用户输入
    action2.behavior = UIUserNotificationActionBehaviorTextInput;
    
    //这个字典定义了当用户点击了评论按钮后，输入框右侧的按钮名称，如果不设置该字典，则右侧按钮名称默认为 “发送”
    action2.parameters = @{UIUserNotificationTextInputActionButtonTitleKey: @"评论"};
    
    //创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    
    //这组动作的唯一标示
    category.identifier = kNotificationCategoryIdentifile;
    
    //最多支持两个，如果添加更多的话，后面的将被忽略
    [category setActions:@[action1, action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    //创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObject:category]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
}
@end
