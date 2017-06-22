//
//  AAUCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AAUCell.h"
#import "TestDataModel.h"

#define iconMarginLeft 10
#define iconMarginTop 10
#define iconW 40
#define nameLabelMarginTop 10
#define nameLableMarginLeft  10


@interface AAUCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIView *grayView;
@end

@implementation AAUCell

- (void)createUI{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.grayView];
}

- (void)masonrySubView{

}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    TestDataModel *modelData = (TestDataModel*)model;
    self.icon.image = [UIImage imageNamed:modelData.imageName];
    self.nameLabel.text = modelData.title;
    self.timeLabel.text = modelData.time;
    self.contentLabel.text = modelData.content;
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(iconMarginLeft);
        make.width.height.mas_equalTo(iconW);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(nameLableMarginLeft);
        make.top.mas_equalTo(self.icon);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark 懒加载
- (UIImageView*)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}

- (UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
    }
    return _timeLabel;
}

- (UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.backgroundColor = [UIColor greenColor];
        _contentLabel.adjustsFontSizeToFitWidth = YES;  //解决文本显示不全问题 
    }
    return _contentLabel;
}

- (UIView*)grayView{
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor grayColor];
    }
    return _grayView;
}
@end
