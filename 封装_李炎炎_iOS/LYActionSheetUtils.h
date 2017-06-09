//
//  LYActionSheetUtils.h
//  LYDemo
//
//  Created by lyy on 16/6/13.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYActionSheetUtils : NSObject

/***********************************************iOS8新特性 使用多选框********************** 回调使用Block*********************************/
/** iOS8 使用 actionSheet */
+ (void)showSheetInVC:(UIViewController *)vc title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray certain:(void(^)(NSInteger index))certain;

@end
