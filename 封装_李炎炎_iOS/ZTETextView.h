//
//  ZTETextView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  带有占位文字的UITextView

#import <UIKit/UIKit.h>

@interface ZTETextView : UITextView
/** 占位文字 */
@property(nonatomic,copy)NSString *placeHolder;
/** 占位文字颜色 */
@property(nonatomic,strong)UIColor *placeHolderColor;

@end
