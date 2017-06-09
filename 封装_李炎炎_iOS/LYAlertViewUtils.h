//
//  LYAlertViewUtils.h
//  LYDemo
//
//  Created by lyy on 16/6/12.
//  Copyright © 2016年 ZXJK. All rights reserved.
//   弹出警告框工具类
//   描述: 当用户执行一些操作时 弹出一些警告或者提示信息

#import <Foundation/Foundation.h>

@interface LYAlertViewUtils : NSObject

/***********************************************iOS8之前版本 使用警告框****************** 回调使用Delegate************************************/

/**  没有回调 */
+ (void)showAlertTitle:(NSString*)titleName text:(NSString *)textStr certain:(NSString*)certain cancel:(NSString*)cancel;

/** 有回调 */
+ (void)showAlertTitle:(NSString *)titleName text:(NSString *)textStr certain:(NSString*)certain cancel:(NSString*)cancel  delegate:(id)delegate;


/***********************************************iOS8新特性 使用警告框********************** 回调使用Block*********************************/

/** 只有确定,没有回调  */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString*)message;

/** 只有确定 有回调 */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message certain:(void(^)(UIAlertAction *action))certain;

/** 有确定 有取消 有回调 */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message  certain:(void(^)(UIAlertAction *action))certain  cancel:(void(^)(UIAlertAction *action))cancel;

/** 带有一个输入框 有确定 有取消 有回调  需要将用户输入的字符串传递给外界*/
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message placeHolder:(NSString*)placeHolder certain:(void (^)(UIAlertAction *action, NSString *text))certain cancel:(void (^)(UIAlertAction *))cancel ;

/** 带有多个输入框 有确定 有取消 有回调 */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message placeHolderArray:(NSArray*)placeHolderArray certain:(void (^)(UIAlertAction *))certain cancel:(void (^)(UIAlertAction *))cancel;

@end
