//
//  FCYCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FCYCell.h"
#import "TestDataModel.h"

#define iconMarginLeft 10
#define iconMarginTop 10
#define iconW 40
#define nameLabelMarginTop 10
#define nameLableMarginLeft  10
#define nameLabelH 20
#define nameLabelW 200
#define grayMarginTop 10
#define grayH 10


@interface FCYCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)YYLabel *nameLabel;
@property(nonatomic,strong)YYLabel *timeLabel;
@property(nonatomic,strong)YYLabel *contentLabel;
@property(nonatomic,strong)UIView *grayView;
@end

@implementation FCYCell

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

    self.icon.frame = CGRectMake(iconMarginLeft, iconMarginTop, iconW, iconW);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+nameLableMarginLeft, nameLabelMarginTop, nameLabelW, nameLabelH);
    self.timeLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.nameLabel.frame), self.nameLabel.width, self.nameLabel.height);
    self.contentLabel.frame = CGRectMake(iconMarginLeft, CGRectGetMaxY(self.timeLabel.frame)+iconMarginLeft, kScreenWidth - iconMarginLeft*2, modelData.textHeight);
    self.grayView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame)+grayMarginTop, kScreenWidth, grayH);
}

#pragma mark 懒加载
- (UIImageView*)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (YYLabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[YYLabel alloc]init];
    }
    return _nameLabel;
}

- (YYLabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[YYLabel alloc]init];
    }
    return _timeLabel;
}

- (YYLabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.backgroundColor = [UIColor greenColor];
//        _contentLabel.adjustsFontSizeToFitWidth = YES;  //解决文本显示不全问题
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

