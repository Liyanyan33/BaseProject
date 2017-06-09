//
//  UIBarButtonItem+Extension.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/** 仅有图片 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/** 仅有文字 */
+ (UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action text:(NSString*)text;

/** 既有图片 又有文字 */
+ (UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage text:(NSString*)text;



@end
