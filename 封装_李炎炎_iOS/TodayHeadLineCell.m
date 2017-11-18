//
//  TodayHeadLineCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/20.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TodayHeadLineCell.h"
#import "TodayHeadModel.h"

@interface TodayHeadLineCell ()
@property(nonatomic,strong)UILabel *txtLabel;
@end

@implementation TodayHeadLineCell

- (void)createUI{
    [self addSubview:self.txtLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _txtLabel.frame = CGRectMake(0, 0, w, h);
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    TodayHeadModel *todayModel = (TodayHeadModel*)model;
    _txtLabel.text = todayModel.title;
}

- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [UILabel labelWithText:@"" font:ScreenFitFont(17) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    }
    return _txtLabel;
}
@end
