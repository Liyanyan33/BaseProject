//
//  ZTEPreViewNavBar.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZTEPreViewNavBarButtonType){
    ZTEPreViewNavBarButtonTypeBack,   //返回
    ZTEPreViewNavBarButtonTypeSelected  // 选中
};

typedef void(^ZTEPreViewNavBarButtonClick)(ZTEPreViewNavBarButtonType type);

@interface ZTEPreViewNavBar : UIView
@property(nonatomic,copy)ZTEPreViewNavBarButtonClick buttonClickBlock;
@end
