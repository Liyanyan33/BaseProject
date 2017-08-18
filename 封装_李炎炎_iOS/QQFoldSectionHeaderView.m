//
//  QQFoldSectionHeaderView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "QQFoldSectionHeaderView.h"
#import "QQGroupModel.h"

@interface QQFoldSectionHeaderView ()
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIView *borderView;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)UILabel *groupLabel;
@end

@implementation QQFoldSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _view.frame = CGRectMake(0, 0, w, h);
    _borderView.frame = CGRectMake(0, h, w, 0.5);
    _arrowImageView.frame = CGRectMake(15, 19, 14, 12);
    _groupLabel.frame = CGRectMake(45, 0, w, h);
}

- (void)createUI{
    [self addSubview:self.view];
    [self.view addSubview:self.borderView];
    [self.view addSubview:self.arrowImageView];
    [self.view addSubview:self.groupLabel];
}

- (void)configHeaderView:(id)model indexPath:(NSIndexPath *)indexPath{
    QQGroupModel *groupModel = (QQGroupModel*)model;
    self.groupLabel.text = [NSString stringWithFormat:@"%@ -- [%@]",groupModel.group_name,groupModel.member_num];
    
    CGFloat rota;
    if (groupModel.isFold) {
        rota = 0;
    } else {
        rota = M_PI_2; //π/2
    }
    self.arrowImageView.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π/2
}

- (void)openClick:(UITapGestureRecognizer*)sender{
    if (_tapBlock) {
        _tapBlock();
    }
}

#pragma mak 懒加载
- (UIView*)view{
    if (!_view) {
        _view = [[UIView alloc]init];
        _view.backgroundColor = [UIColor whiteColor];
        _view.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openClick:)];
        // 给view添加手势
        [_view addGestureRecognizer:myTap];
    }
    return _view;
}

- (UIView*)borderView{
    if (!_borderView) {
        _borderView = [[UIView alloc]init];
        _borderView.backgroundColor = RGB_HEX(0xC8C7CC);
    }
    return _borderView;
}

- (UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"pulldownList.png"];
    }
    return _arrowImageView;
}

#pragma mak 懒加载
- (UILabel*)groupLabel{
    if (!_groupLabel) {
        _groupLabel = [[UILabel alloc]init];
        _groupLabel.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
        _groupLabel.font = [UIFont systemFontOfSize:16];
    }
    return _groupLabel;
}
@end
