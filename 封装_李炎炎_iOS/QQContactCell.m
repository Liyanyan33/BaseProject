//
//  QQContactCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.

#import "QQContactCell.h"
#import "QQGroupModel.h"

@interface QQContactCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *activeTimeLabel;
@end

@implementation QQContactCell

- (void)createUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.describeLabel];
    [self addSubview:self.activeTimeLabel];
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    QQContactModel *groupModel = (QQContactModel*)model;
    _iconImageView.image = [UIImage imageNamed:@"default.jpg"];
    _nameLabel.text = groupModel.name;
    _describeLabel.text = groupModel.desc;
    _activeTimeLabel.text = groupModel.active_time;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(10, 6 * kScaleFit, 48 * kScaleFit, 48 * kScaleFit);
    self.nameLabel.frame = CGRectMake(10 + 56 * kScaleFit, 10 * kScaleFit, 150 * kScaleFit, 20 * kScaleFit);
    self.describeLabel.frame = CGRectMake(10 + 56 * kScaleFit, 35 * kScaleFit, 210 * kScaleFit, 15 * kScaleFit);
    self.activeTimeLabel.frame = CGRectMake(kScreenWidth - 100 * kScaleFit - 10, 10 * kScaleFit, 100 * kScaleFit, 20 * kScaleFit);
}

#pragma mark - 懒加载
- (UIImageView *)iconImageView {
    if(_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 24 / 375.0 * kScreenWidth;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if(_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)describeLabel {
    if(_describeLabel == nil) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
        _describeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _describeLabel;
}

- (UILabel *)activeTimeLabel {
    if(_activeTimeLabel == nil) {
        _activeTimeLabel = [[UILabel alloc] init];
        _activeTimeLabel.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
        _activeTimeLabel.textAlignment = NSTextAlignmentRight;
        _activeTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _activeTimeLabel;
}
@end
