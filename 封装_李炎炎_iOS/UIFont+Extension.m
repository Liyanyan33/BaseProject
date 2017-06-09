
//
//  UIFont+Extension.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/26.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

// 根据屏幕的尺寸 设置控件的字体大小
+ (UIFont*)getFont{

    if (kScreenWidth == 320) {
        return [UIFont systemFontOfSize:16];
    }else if (kScreenWidth == 375){
        return [UIFont systemFontOfSize:18];
    }else if (kScreenWidth == 414){
        return [UIFont systemFontOfSize:19];
    }else if (kScreenWidth == 768){
        return [UIFont systemFontOfSize:21];
    }else{
        return nil;
    }
}

@end
