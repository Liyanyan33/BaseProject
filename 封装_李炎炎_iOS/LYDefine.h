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
// RGB颜色(16进制)
#define RGB_HEX(rgbValue) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// 等比例适配系数
#define kScaleFit (kScreenWidth / 375.0f)

/** 判断设备系统宏 */
#define is_iOS8   [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define loadTitle  @"正在加载中......"
#define busyTitle @"网络繁忙请稍后...."

#define  AXLocalizedString(key) NSLocalizedString(key,nil)

#define  AXLogFunc AXLog(@"%s",__func__);

#define axLong_dealloc AXLog(@"dealloc %@",self.class)

// 弱引用 宏定义
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif





