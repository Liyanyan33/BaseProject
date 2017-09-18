//
//  NSBundle+ZTEImagePicker.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/13.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "NSBundle+ZTEImagePicker.h"
#import "ZTEImagePickerController.h"

@implementation NSBundle (ZTEImagePicker)

+ (NSBundle*)zte_imagePickerBundle{
    NSBundle *bundle = [NSBundle bundleForClass:[ZTEImagePickerController class]];
    NSURL *url = [bundle URLForResource:@"ZTEImagePicker" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString*)zte_localizedStringForKey:(NSString *)key{
    return [self zte_localizedStringForKey:key value:@""];
}

+ (NSString*)zte_localizedStringForKey:(NSString *)key value:(NSString *)value{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // 判断当前系统的语言环境
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        }else{
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle zte_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}

@end
