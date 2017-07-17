//
//  ZTESearchBar.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchBar)(NSString *text);

@interface ZTESearchBar : UIView

/** 占位提示文字 */
@property (nonatomic, copy)   NSString * placeholder;

/** 取消按钮的文字 */
@property (nonatomic, copy) NSString * searchText;

/** 占位提示文字的颜色 */
@property (nonatomic, strong) UIColor  * placeholderColor;

/** 搜索框(输入框除外)的背景颜色 */
@property (nonatomic, strong) UIColor  * barBackgroudColor;

/** 输入框的背景颜色 */
@property (nonatomic, strong) UIColor  * textBackgroudColor;

/** 输入文字的颜色 */
@property (nonatomic, strong) UIColor  * textColor;

/** 取消按钮文字的颜色 */
@property (nonatomic, strong) UIColor  * tintColor;

/** 占位提示文字的大小 */
@property (nonatomic, assign) CGFloat    placeholderFontSize;

/** 输入文字的大小 */
@property (nonatomic, assign) CGFloat    textFontSize;

@end
