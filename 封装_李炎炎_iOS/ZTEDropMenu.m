//
//  UIDropdownMenu.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/27.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "ZTEDropMenu.h"

#define animateTime 0.25

@interface ZTEDropMenu ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_arrow;       //  箭头
    UIView *_backView;           // 下拉的背景view
    UITableView *_tableView;  //  表格view
    NSArray *_titleArray;          //  tableView显示的数据
    CGFloat _rowHeight;         //  cell高度
}
@end

@implementation ZTEDropMenu

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self createUIWithFrame:frame];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame{
    UIButton *mainBtn  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [mainBtn setTitle:@"请选择" forState:(UIControlStateNormal)];
    [mainBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [mainBtn addTarget:self action:@selector(clickMainBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [mainBtn setCornerRadius:5.0f borderW:1.0f borderCorlor:[UIColor redColor]];
    mainBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 调整整体内容的位置(文字图片)
    mainBtn.titleEdgeInsets    = UIEdgeInsetsMake(0, 15, 0, 0);  //调整文字的位置
    mainBtn.selected = NO;   //设置按钮处于非选中状态
    [self addSubview:mainBtn];
    _mainBtn = mainBtn;
    
    _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 20, 0, 9, 9)];
    _arrow.centerY = frame.size.height/2;
    _arrow.image = [UIImage imageNamed:@"dropdownMenu_cornerIcon.png"];
    [_mainBtn addSubview:_arrow];
}

- (void)setTitle:(NSArray *)titleArray rowHeight:(CGFloat)rowHeight{
    if (!self) {
        return;
    }
    _titleArray = titleArray;
    _rowHeight = rowHeight;
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.frame), self.frame.size.width, 0)];
    _backView.clipsToBounds = YES;
    _backView.layer.masksToBounds = NO;
    _backView.layer.borderColor   = [UIColor lightTextColor].CGColor;
    _backView.layer.borderWidth   = 0.5f;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _backView.width, _backView.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [_backView addSubview:_tableView];
}

#pragma mark 监听事件
- (void)clickMainBtn:(UIButton*)sender{
    /** 将下拉的列表控件 添加到控件的父视图上面 (很重要) 响应点击事件*/
    [self.superview addSubview:_backView];
    if (sender.selected) {
        [self hideDropdownMenu];
    }else{
        [self showDropdownMenu];
    }
}

- (void)showDropdownMenu{
    [_backView.superview bringSubviewToFront:_backView];  //将backView移动到父控件的最上层
    // 下拉菜单即将出现
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillShow:)]) {
        [self.delegate dropdownMenuWillShow:self];
    }
    // 下拉菜单 以动画的形式出现
    [UIView animateWithDuration:animateTime animations:^{
        // 箭头方向翻转
        _arrow.transform = CGAffineTransformMakeRotation(M_PI);
        // 设置backView与tableView的frame
        _backView.frame = CGRectMake(_backView.x, _backView.y, self.frame.size.width, _titleArray.count*_rowHeight);
        _tableView.frame = CGRectMake(0, 0, _backView.width, _backView.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
            [self.delegate dropdownMenuDidShow:self];
        }
    }];
    _mainBtn.selected = YES;
}

- (void)hideDropdownMenu{
    if ([self.delegate respondsToSelector:@selector(dropdownMenuWillHide:)]) {
        [self.delegate dropdownMenuWillHide:self];
    }
    [UIView animateWithDuration:animateTime animations:^{
        _arrow.transform = CGAffineTransformIdentity;
        _backView.frame = CGRectMake(_backView.x, _backView.y, self.frame.size.width, 0);
        _tableView.frame = CGRectMake(0, 0, _backView.width, _backView.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(dropdownMenuDidHide:)]) {
            [self.delegate dropdownMenuDidHide:self];
        }
    }];
    _mainBtn.selected = NO;
}

- (NSString*)text{
    return [_mainBtn titleForState:(UIControlStateNormal)];
}

#pragma mark UITableViewDataSource  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = randomColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell点击不变色
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectedRowAtIndex:)]) {
        [self.delegate dropdownMenu:self didSelectedRowAtIndex:indexPath.row];
    }
    [_mainBtn setTitle:_titleArray[indexPath.row] forState:(UIControlStateNormal)];
    [self hideDropdownMenu];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight;
}
@end
