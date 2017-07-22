//
//  UIDropdownMenu.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/27.
//  Copyright © 2016年 ZXJK. All rights reserved.
//  下拉菜单

#import <UIKit/UIKit.h>

@class ZTEDropMenu;
@protocol ZTEDropMenuDelegate <NSObject>
@optional
// 下拉菜单即将显示时调用
- (void)dropdownMenuWillShow:(ZTEDropMenu*)dropdownMenu;
// 下拉菜单已经显示时调用
- (void)dropdownMenuDidShow:(ZTEDropMenu *)dropdownMenu;
// 下拉菜单即将消失时调用
- (void)dropdownMenuWillHide:(ZTEDropMenu *)dropdownMenu;
// 下拉菜单已经消失时调用
- (void)dropdownMenuDidHide:(ZTEDropMenu *)dropdownMenu;
// 下拉菜单中选中某一行时调用
- (void)dropdownMenu:(ZTEDropMenu*)dropdownMenu didSelectedRowAtIndex:(NSInteger)index;
@end

@interface ZTEDropMenu : UIView

@property(nonatomic,strong)UIButton *mainBtn;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,weak)id<ZTEDropMenuDelegate> delegate;

- (void)setTitle:(NSArray*)titleArray rowHeight:(CGFloat)rowHeight;

@end
