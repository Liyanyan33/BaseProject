//
//  ZTEScreenFitDefine.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/23.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  有关屏幕以及屏幕适配的参数配置

#ifndef ZTEScreenFitDefine_h
#define ZTEScreenFitDefine_h

/** 屏幕尺寸*/
#define mainScreenBounds        [UIScreen mainScreen].bounds                            //主屏幕
#define kScreenWidth                 mainScreenBounds.size.width                             //屏幕宽度
#define kScreenHeight                mainScreenBounds.size.height                           //屏幕高度
#define kScreenMaxLength        (MAX(kScreenWidth,kScreenHeight))                 //获取屏幕的最大尺寸
#define kScreenMinLength         (MIN(kScreenWidth,kScreenHeight))                  //获取屏幕的最小尺寸

/** 设备类型判断 */
#define isiPad_ZTE         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isiPhone              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isRetain               ([[UIScreen mainScreen] scale] >= 2.0)

/** 设备型号判断
 iPhone4,         //320*480
 iPhone5,5s     //320*568
 iPhone6,         //375*667
 iPhone6Plus,  //414*736
 iPad                //768*1024
 */
#define IS_IPHONE4   (isiPhone && kScreenMaxLength  <  568.0)
#define IS_IPHONE5   (isiPhone && kScreenMaxLength == 568.0)
#define IS_IPHONE6   (isiPhone && kScreenMaxLength  == 667.0)
#define IS_IPHONE6_PLUS  (isiPhone && kScreenMaxLength  == 736.0)
#define IS_PAD          (isiPad_ZTE && kScreenMaxLength  == 1024.0)

/**
 字体大小的适配
 以iPhone6为基准 
 */
#define fontSizeScale \
({\
CGFloat fontSizeScale_var = 0;\
if (IS_IPHONE4||IS_IPHONE5)\
fontSizeScale_var = 0.9;\
else if (IS_IPHONE6)\
fontSizeScale_var = 1;\
else if (IS_IPHONE6_PLUS)\
fontSizeScale_var = 1.2;\
else if (IS_PAD)\
fontSizeScale_var = 2;\
(fontSizeScale_var);\
})\

#define kFont(value)    [UIFont systemFontOfSize:value * fontSizeScale]


#define GetURLWith(tag) \
({\
NSString *url=@"";\
if (tag==1)\
url=@"http://www.xxx.com:";\
else if (tag==2)\
url=@"http://www.xxx-test.com:";\
else if(tag==3)\
url=@"http://www.xxx-test2.com:";\
(url);\
})\

#endif /* ZTEScreenFitDefine_h */
