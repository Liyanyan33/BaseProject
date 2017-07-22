//
//  LYActionSheet.m
//  自定义Sheet
//
//  Created by lyy on 17/3/2.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import "ZTEActionSheet.h"
#import "ZTEActionCell.h"

/** 屏幕尺寸宏 */
#define mainScreenBounds        [UIScreen mainScreen].bounds                            //主屏幕
#define kScreenWidth                 mainScreenBounds.size.width                             //屏幕宽度
#define kScreenHeight                mainScreenBounds.size.height                           //屏幕高度
#define cellHeight   44  //按钮的高度
#define grayHeight  8   // 灰色间隔高度
#define cellCount    6   // 显示的cell的最大数量

@interface ZTEActionSheet ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *btnArr;
@property(nonatomic,strong)UIView *contentView;  // 内容容器视图 执行整体动画
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ZTEActionSheet

- (ZTEActionSheet*)initWithButtonsArray:(NSArray *)btnArray{
    ZTEActionSheet *lyac = [[ZTEActionSheet alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _btnArr = btnArray;
    return lyac;
}

- (instancetype)initWithFrame:(CGRect)frame withButtonsArr:(NSArray *)btnArr{
    self = [super initWithFrame:frame];
    if (self) {
        _btnArr = btnArr;
        [self createUI];
        [self actionAnimate];
    }
    return self;
}

- (instancetype)initWithButtonsArr:(NSArray *)btnArr{
    _btnArr = btnArr;
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self actionAnimate];
    }
    return self;
}

+ (instancetype)actionsheetWithBtnArr:(NSArray *)btnArr{
    ZTEActionSheet *sheet = [[ZTEActionSheet alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    sheet.btnArr = btnArr;
    return sheet;
}

- (void)createUI{
    // 灰色背景
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backView.backgroundColor  = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];
    //内容视图 初始化时 在屏幕的底部
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, (_btnArr.count+1)*cellHeight+grayHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    // 内容控件
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_contentView addSubview:_tableView];
    
    if (_btnArr.count > cellCount) {
        CGSize size = CGSizeZero;
        size.height = cellCount * cellHeight;
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, size.height);
    }else{
        CGSize size = CGSizeZero;
        size.height = _btnArr.count * cellHeight;
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, size.height);
    }
    
    // 灰色间隔子控件
    UIView  *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), kScreenWidth, grayHeight)];
    grayView.backgroundColor = [UIColor grayColor];
    [_contentView addSubview:grayView];
    // 取消按钮
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView.frame), kScreenWidth, cellHeight)];
    [cancleBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    cancleBtn.tag = 100;
    [cancleBtn addTarget:self action:@selector(tapGesture:) forControlEvents:(UIControlEventTouchUpInside)];
    [_contentView addSubview:cancleBtn];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark UITableViewDataSource  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _btnArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTEActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ZTEActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.txt = _btnArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell点击不变色
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellClickBlock) {
        _cellClickBlock(_btnArr[indexPath.row],indexPath.row);
    }
    [self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    [window addSubview:self];
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        _contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, (_btnArr.count+1)*cellHeight+grayHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        // actionSheet已经移除
        if (_disAppearBlock) {
            _disAppearBlock();
        }
    }];
}

- (void)actionAnimate{
    [UIView animateWithDuration:0.2 animations:^{
        if (_btnArr.count > cellCount) {
            _contentView.frame = CGRectMake(0, kScreenHeight - (cellCount+1)*cellHeight - grayHeight, kScreenWidth, (cellCount+1)*cellHeight+grayHeight);
        }else{
          _contentView.frame = CGRectMake(0, kScreenHeight - ((_btnArr.count+1)*cellHeight+grayHeight), kScreenWidth, (_btnArr.count+1)*cellHeight+grayHeight);
        }
    } completion:^(BOOL finished) {
        // actionSheet已经出现
        if (_appearBlock) {
            _appearBlock();
        }
    }];
}

- (void)tapGesture:(UITapGestureRecognizer*)sender{
    [self dismiss];
}
@end
