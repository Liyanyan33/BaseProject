//
//  LYActionSheetUtils.m
//  LYDemo
//
//  Created by lyy on 16/6/13.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "LYActionSheetUtils.h"

@implementation LYActionSheetUtils

/** Sheet */
+ (void)showSheetInVC:(UIViewController *)vc title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    
    for (NSInteger index=0; index<actionArray.count; index++) {
        
        NSString *title = actionArray[index];
        
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (certain) {
                certain(index);
            }
        }]];
    }
    [vc.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
