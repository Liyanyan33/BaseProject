//
//  ZTEPickView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/23.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTEPickView : UIView

+ (instancetype)pickView;

+ (instancetype)pickViewWithData:(NSArray*)dataArr;

+ (instancetype)pickViewWithData:(NSArray *)dataArr title:(NSString*)title;

- (void)show;
- (void)dismiss;

@end
