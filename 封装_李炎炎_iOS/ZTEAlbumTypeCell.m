//  ZTEAlbumTypeCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/6.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEAlbumTypeCell.h"
#import "ZTEAlbumModel.h"
#import "ZTEAlbumManager.h"

@interface ZTEAlbumTypeCell ()
@property(nonatomic,strong)UIImageView*icon;
@property(nonatomic,strong)UILabel *txtLabel;
@property(nonatomic,strong)UIButton *selectedConutBtn;
@property(nonatomic,strong)ZTEAlbumModel *model;
@end

@implementation ZTEAlbumTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.icon];
    [self addSubview:self.txtLabel];
    [self addSubview:self.selectedConutBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.icon.frame = CGRectMake(0, 0, h, h);
    self.txtLabel.frame = CGRectMake(h +10, 0, w - h - 10, 30);
    self.txtLabel.centerY = h/2;
    self.selectedConutBtn.frame = CGRectMake(w - 28 - 30, 0, 28, 28);
    self.selectedConutBtn.centerY = h/2;
}

- (void)configCellWithDataModel:(id)dataModel{
    _model = (ZTEAlbumModel*)dataModel;
    self.txtLabel.attributedText = _model.attStr;
    [[ZTEAlbumManager shareAlbumManager] getCoverImageOfAlbum:_model completion:^(UIImage *image) {
        self.icon.image = image;
    }];
    if (_model.selectCount) {
        self.selectedConutBtn.hidden = NO;
        [self.selectedConutBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_model.selectCount] forState:(UIControlStateNormal)];
    }else{
        self.selectedConutBtn.hidden = YES;
    }
}

#pragma mark setter getter
- (UIImageView*)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
        _txtLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _txtLabel;
}

- (UIButton*)selectedConutBtn{
    if (!_selectedConutBtn) {
        _selectedConutBtn = [ZTEUIKit buttonWtihNormalText:@"10" font:ScreenFitFont(14) normalTextColor:[UIColor whiteColor] normalImage:nil];
        _selectedConutBtn.backgroundColor = [UIColor greenColor];
        [_selectedConutBtn setCornerRadius:15 borderW:1 borderCorlor:[UIColor greenColor]];
    }
    return _selectedConutBtn;
}

@end
