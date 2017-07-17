//
//  ZTESearchBar.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTESearchBar.h"

@interface ZTESearchBar ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation ZTESearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.searchBar];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.searchBar.frame = CGRectMake(0, 0, w, h);
}

//获取输入框
- (UITextField *)searchBarTextFeild {
    UITextField * texFeild = nil;
    for (UIView* subview in [[_searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            texFeild = (UITextField*)subview;
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [subview removeFromSuperview];
        }
    }
    return texFeild;
}

#pragma mark UISearchDelegate
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

/** 键盘搜索按钮 点击回调 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@" "]) {
//        self.block(searchBar.text);
    }
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if (![searchBar.text isEqualToString:@""] && ![searchBar.text isEqualToString:@" "]) {
//        self.block(searchBar.text);
    }
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

// 重新设置 searchbar cancel按钮 为搜索
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    searchBar.showsBookmarkButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"搜索" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

#pragma mak 懒加载
- (UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

/** 设置占位提示文字 */
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _searchBar.placeholder = placeholder;
}

/** 设置占位提示文字的颜色 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [[self searchBarTextFeild] setValue:placeholderColor forKey:@"_placeholderLabel.textColor"];
}

/** 设置输入文字的颜色 */
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self searchBarTextFeild].textColor = textColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    _searchBar.tintColor = tintColor;
}

- (void)setBarBackgroudColor:(UIColor *)barBackgroudColor {
    _barBackgroudColor = barBackgroudColor;
    _searchBar.barTintColor = barBackgroudColor;
}

- (void)setTextBackgroudColor:(UIColor *)textBackgroudColor {
    _textBackgroudColor = textBackgroudColor;
    [[[_searchBar.subviews firstObject]subviews]lastObject].backgroundColor = textBackgroudColor;
}

@end
