//
//  LYAlertViewUtils.m
//  LYDemo
//
//  Created by lyy on 16/6/12.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "LYAlertViewUtils.h"

@implementation LYAlertViewUtils

/**********************************************iOS8之前版本 使用警告框****************** 回调使用Delegate********************************/

/**  没有回调 */
+ (void)showAlertTitle:(NSString*)titleName text:(NSString *)textStr certain:(NSString*)certain cancel:(NSString*)cancel{
    [self showAlertTitle:titleName text:textStr certain:certain cancel:cancel delegate:nil];
}

/** 有确定 有取消 有回调 */
+ (void)showAlertTitle:(NSString *)titleName text:(NSString *)textStr certain:(NSString*)certain cancel:(NSString*)cancel  delegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titleName message:textStr delegate:delegate cancelButtonTitle:cancel otherButtonTitles: certain, nil];
    [alert show];
}


/***********************************************iOS8新特性 使用警告框********************** 回调使用Block*********************************/

/** 只有确定,没有回调  */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString*)message{
    [self showAlertInVC:vc title:title message:message certain:nil];
}

/** 只有确定 有回调 */
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message certain:(void(^)(UIAlertAction *action))certain{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(action);
        }
    }]];
    [vc.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

/** 有确定 有取消 有回调*/
+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message  certain:(void(^)(UIAlertAction *action))certain  cancel:(void(^)(UIAlertAction *action))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(action);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel(action);
        }
    }]];
    [vc.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message placeHolder:(NSString*)placeHolder certain:(void (^)(UIAlertAction *action, NSString *text))certain cancel:(void (^)(UIAlertAction *action))cancel {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alert.textFields.firstObject.text;
        if (certain) {
            certain(action,text);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel(action);
        }
    }]];
    [vc.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message placeHolderArray:(NSArray *)placeHolderArray certain:(void (^)(UIAlertAction *))certain cancel:(void (^)(UIAlertAction *))cancel{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < placeHolderArray.count; i++) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeHolderArray[i];
        }];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (certain) {
            certain(action);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel(action);
        }
    }]];
    [vc.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
