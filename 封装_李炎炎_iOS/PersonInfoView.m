//
//  PersonInfoView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  顶部信息模块

#import "PersonInfoView.h"
#import "WBStatuViewModel.h"

@interface PersonInfoView ()
@property(nonatomic,strong)UIImageView *avatarIcon;  // 头像
@property(nonatomic,strong)UILabel *nameLabel;          // 姓名
@property(nonatomic,strong)UIImageView *badgeIcon;  // 徽章
@property(nonatomic,strong)UILabel *sourceLabel;        // 来源
@property(nonatomic,strong)WBStatuViewModel *sViewModel;
@end

@implementation PersonInfoView

- (void)createUI{
    [self addSubview:self.avatarIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.badgeIcon];
    [self addSubview:self.sourceLabel];
}

- (void)configWithViewModel:(id)viewModel{
    _sViewModel = (WBStatuViewModel*)viewModel;
    WBStatuModel *stauModel = _sViewModel.statuModel;
    WBUserModel *userModel = stauModel.user;
    // 头像
    _avatarIcon.frame = _sViewModel.avatarIconFrame;
    [_avatarIcon sd_setImageWithURL:[NSURL URLWithString:stauModel.user.avatar_large] placeholderImage:nil];
    // 姓名
    _nameLabel.frame = _sViewModel.nameLabelFrame;
    _nameLabel.text = userModel.name_end;
    // 徽章
    _badgeIcon.frame = _sViewModel.badgeIconFrame;
    if ([userModel.mbrank integerValue] > 0) {
        _badgeIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%@",userModel.mbrank]];
    }
    // 来源
    _sourceLabel.frame = _sViewModel.sourceLabelFrame;
    _sourceLabel.text = [NSString stringWithFormat:@"%@ %@",stauModel.created_at,stauModel.source];
}

#pragma mark 懒加载
- (UIImageView*)avatarIcon{
    if (!_avatarIcon) {
        _avatarIcon = [[UIImageView alloc]init];
    }
    return _avatarIcon;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor orangeColor];
    }
    return _nameLabel;
}

- (UIImageView*)badgeIcon{
    if (!_badgeIcon) {
        _badgeIcon = [[UIImageView alloc]init];
    }
    return _badgeIcon;
}

- (UILabel*)sourceLabel{
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        _sourceLabel.textColor = [UIColor grayColor];
        _sourceLabel.adjustsFontSizeToFitWidth = YES;  // 解决宽度不够问题
    }
    return _sourceLabel;
}
@end
