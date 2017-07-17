//
//  LYDefine.h
//  JiCheng
//
//  Created by lyy on 16/4/3.
//  Copyright © 2016年 ZXJK. All rights reserved.
//  定义宏文件

/** 打印宏 */
#if (DEBUG || TESTCASE)
#define LYLog(format, ...) NSLog(format,##__VA_ARGS__)
#else
#define LYLog(format,...)
#endif

#ifdef DEBUG

#define NNSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define NNSLog(...)

#endif

/** 日志输出宏   第一个参数: 类 第二个参数: 方法 */
#define BASE_LOG(cls,sel)                           LYLog(@"%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error)   LYLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),error)
#define BASE_INFO_LOG(cls,sel,info)         LYLog(@"INFO:%@-%@-%@",NSStringFromClass(cls),NSStringFromSelector(sel),info)

/** 日志输出函数宏 */
#if (DEBUG || TESTCASE)
#define BASE_LOG_FUN(self,_cmd)                   BASE_LOG([self class],_cmd)
#define BASE_ERROR_FUN(self,_cmd,error)     BASE_ERROR_LOG([self class],_cmd,error)
#define BASE_INFO_FUN(self,_cmd,info)           BASE_INFO_LOG([self class],_cmd,info)
#else
#define BASE_LOG_FUN(self,_cmd)
#define BASE_ERROR_FUN(self,_cmd,error)
#define BASE_INFO_FUN(self,_cmd,info)
#endif

/** 通知的注册 与 销毁宏 */
#define PostNotify(_name,params)            [[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:params];
#define RegisterNotify(_name,_selector)   [NSNotificationCenter defaultCenter] addObserver:self selector:_selector) name:_name object:nil];
#define RemoveNotify                                [[NSNotificationCenter defaultCenter] removeObserver:self];

/** 网络状态宏 */
#define NetWorkingStatu             @"NetWorkingStatu"
#define NetWorkingNotifyName   @"NetWorkingStatuChanged"

/** 颜色宏 */
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r, g, b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alp]
#define randomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:(256)/255.0 alpha:1.0]

/** 屏幕尺寸宏 */
#define mainScreenBounds        [UIScreen mainScreen].bounds                            //主屏幕
#define kScreenWidth                 mainScreenBounds.size.width                             //屏幕宽度
#define kScreenHeight                mainScreenBounds.size.height                           //屏幕高度
#define kScreenMaxLength        (MAX(kScreenWidth,kScreenHeight))                 //获取屏幕的最大尺寸
#define kScreenMinLength         (MIN(kScreenWidth,kScreenHeight))                  //获取屏幕的最小尺寸

/** 设备类型判断宏 */
#define isiPad_ZTE         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isiPhone    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isRetain     ([[UIScreen mainScreen] scale] >= 2.0)

/** 设备型号判断宏 
 iPhone4,         //320*480
 iPhone5,5s     //320*568
 iPhone6,         //375*667
 iPhone6Plus,  //414*736
 iPad                //768*1024
 */
#define isiPhone4   (isiPhone && kScreenMaxLength  <  568.0)
#define isiPhone5   (isiPhone && kScreenMaxLength == 568.0)
#define isiPhone6   (isiPhone && kScreenMaxLength  == 667.0)
#define isiPhone6P (isiPhone && kScreenMaxLength  == 736.0)
#define isiPad          (isiPad_ZTE && kScreenMaxLength  == 1024.0)

/** 判断设备系统宏 */
#define is_iOS8   [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define loadTitle  @"正在加载中......"
#define busyTitle @"网络繁忙请稍后...."

/** 新浪微博的key,密钥,回调地址 */
#define XLAppKey       @"677145421"
#define XLAppSecret   @"704facabd462129f68afaca2a3d04f72"
#define XLRedirectUR @"http://baidu.com"




