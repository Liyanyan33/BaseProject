//
//  ZTEImageCollectionCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEImageCollectionCell.h"
#import "ZTEAlbumManager.h"
#import "ZTEAssetModel.h"

@interface ZTEImageCollectionCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *button;
@end

@implementation ZTEImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.icon];
    [self addSubview:self.button];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.icon.frame = CGRectMake(0, 0, w, h);
    CGFloat buttonW = self.button.imageView.image.size.width;
    self.button.frame = CGRectMake(w - buttonW, 0, buttonW, buttonW);
}

- (void)configCellWithDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    ZTEAssetModel *model = (ZTEAssetModel*)dataModel;
    [[ZTEAlbumManager shareAlbumManager] getImageWithAsset:model.asset imageWidth:80.0f complettion:^(UIImage *image, NSDictionary *info) {
        self.icon.image = image;
    }];
    self.button.selected = model.isSelected;
}

#pragma mark 监听事件
- (void)selectImage:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) { // 由非选中状态 --> 选中状态 执行动画
        // 执行动画
        [UIView showOscillatoryAnimationWithLayer:sender.layer type:(ZTEOscillatoryAnimationToBigger)];
    }else{
        
    }
    // 选择图片按钮的点击回调
    if (_ImageCellClickSelBtn) {
        _ImageCellClickSelBtn(sender.selected);
    }
}

#pragma mark getter
- (UIImageView*)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds = YES;
    }
    return _icon;
}

- (UIButton*)button{
    if (!_button) {
        _button = [ZTEUIKit buttonWtihNormalText:@"" font:ScreenFitFont(16) normalTextColor:nil normalImage:@"photo_def_photoPickerVc.png"];
        [_button addTarget:self action:@selector(selectImage:) forControlEvents:(UIControlEventTouchUpInside)];
        [_button setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc.png"] forState:(UIControlStateSelected)];
    }
    return _button;
}

- (void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        _button.selected = !isSelected;
    }
}

@end
