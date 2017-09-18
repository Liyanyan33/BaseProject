//
//  NSBundle+ZTEImagePicker.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/13.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (ZTEImagePicker)
+ (NSBundle *)zte_imagePickerBundle;

+ (NSString *)zte_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)zte_localizedStringForKey:(NSString *)key;

@end
