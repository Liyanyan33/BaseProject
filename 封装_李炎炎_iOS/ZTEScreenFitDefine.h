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
  设备                     逻辑分辨率   屏幕模式                           屏幕物理尺寸
 iPhone4,                //320*480        @x                                   3.5英寸
 iPhone5,5s            //320*568        @2x                                 4英寸
 iPhone6,6s,7         //375*667        @2x                                 4.7英寸
 iPhone6+,6s+,7+   //414*736        @3x                                 5.5英寸
 iPad ,2                   //768*1024      @x                                   9.7英寸
 iPad mini,2,3,4      //768*1024      @x(第一代)  @2x(其他)   7.9英寸
 iPad Air,2               //768*1024      @2x                                 9.7英寸
 iPad Pro 9.7          //768*1024      @2x                                  9.7英寸
 iPad Pro 10.5        //834 x 1112    @2x                                  10.5英寸
 iPad Pro 12.9        //1024*1336    @2x                                  12.9英寸
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

#define ScreenFitFont(value)    [UIFont systemFontOfSize:value * fontSizeScale]

/** 
 * CGRect 适配 以iPhone6的宽高为基准
 */
#define IPHONE6W 375
#define IPHONE6H  667

/** 宽高的比例系数 */
#define ZTEScaleX (kScreenWidth / IPHONE6W)
#define ZTEScaleY (kScreenHeight / IPHONE6H)

/** 
 * 经过适配(乘以比例系数)之后的 x y w h
 * iPhone5     X轴比例 = 0.853333 -- Y轴比例 = 0.851574
 * iPhone6     X轴比例 = 1.000000 -- Y轴比例 = 1.000000
 * iPhone6P   X轴比例 = 1.104000 -- Y轴比例 = 1.103448
 */
#define ScreenFitX(x)  (x * ZTEScaleX)
#define ScreenFitY(y)  (y * ZTEScaleY)
#define ScreenFitW(w) (w * ZTEScaleX)
#define ScreenFitH(h)  (h * ZTEScaleY)
#define LineFont(value)  [UIFont systemFontOfSize:value * ZTEScaleX]

/** 
 为了解决（小宽度） 乘以 scale比例系数基本没效果     --需要 发大比例系数
 或者（大宽度） 乘以 scale比例系数 又过分了的问题， -- 需要 缩小比例系数 (发大与缩小主要是由设置的参量的数值大小决定的)
 又定义了这样一个宏，给scale再乘一个（自己制定的系数）
 主要针对是 大屏的UI显示问题  scale * scale 双比例
 */
#define ScaleScreenFitX(x,scale)  (ZTEScaleX > 1 ? (x * ZTEScaleX) : (x * ZTEScaleX * scale))

/** 设备系统 */
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)


#endif /* ZTEScreenFitDefine_h */
