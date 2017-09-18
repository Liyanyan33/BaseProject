//
//  ZTEImageCollectinBottomVIew.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/8.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEImageCollectinBottomVIew.h"
#import "ZTEAlbumManager.h"

@interface ZTEImageCollectinBottomVIew ()
/** 顶部线条 */
@property(nonatomic,strong)UIView *topLine;
/** 左侧浏览按钮 */
@property(nonatomic,strong)UIButton *preViewBtn;
@property(nonatomic,strong)UIButton *fullImageBtn;
@property(nonatomic,strong)UILabel *imageSizeLabel;
@property(nonatomic,strong)UIImageView *dotImageView;
@property(nonatomic,strong)UILabel *imageCountLabel;
@property(nonatomic,strong)UIButton *doneBtn;
@property(nonatomic,strong)NSArray *selectedAssetArr;
@end

@implementation ZTEImageCollectinBottomVIew

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
    self.topLine.frame = CGRectMake(0, 0, w, 1);
    NSString *preViewStr = [self.preViewBtn titleForState:(UIControlStateNormal)];
    CGFloat preViewW = [preViewStr sizeWithFont:ScreenFitFont(16) withHeight:h-1].width + 2;
    self.preViewBtn.frame = CGRectMake(10, 1, preViewW, h - 1);
    NSString *fullStr = [self.fullImageBtn titleForState:(UIControlStateNormal)];
    CGFloat fullTxtW = [fullStr sizeWithFont:ScreenFitFont(16) withHeight:h-1].width;
    
    self.fullImageBtn.frame = CGRectMake(CGRectGetMaxX(self.preViewBtn.frame), 1, fullTxtW + 40, h-1);
    self.imageSizeLabel.frame = CGRectMake(CGRectGetMaxX(self.fullImageBtn.frame), 1, 100, h-1);
    
    self.doneBtn.frame = CGRectMake(w - 10 - (h-1), 1, h-1, h-1);
    self.imageCountLabel.frame = CGRectMake(w - 10 - (h-1) - 30, (h-30)/2, 30, 30);
    self.dotImageView.frame = self.imageCountLabel.frame;
}

- (void)createUI{
    [self addSubview:self.topLine];
    [self addSubview:self.preViewBtn];
    [self addSubview:self.imageSizeLabel];
    [self addSubview:self.fullImageBtn];
    [self addSubview:self.dotImageView];
    [self addSubview:self.imageCountLabel];
    [self addSubview:self.doneBtn];
}

- (void)updateBottomViewStatu:(NSArray<ZTEAssetModel*> *)selectedAssetArr{
    _selectedAssetArr = selectedAssetArr;
    self.doneBtn.enabled = selectedAssetArr.count;
    self.fullImageBtn.enabled = selectedAssetArr.count;
    self.dotImageView.hidden = selectedAssetArr.count <1;
    self.imageCountLabel.hidden = selectedAssetArr.count < 1;
    self.imageCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)selectedAssetArr.count];
    if (selectedAssetArr.count > 0 && self.fullImageBtn.selected) {
        self.imageSizeLabel.hidden = NO;
    }else{
        self.imageSizeLabel.hidden = YES;
    }
    
    [[ZTEAlbumManager shareAlbumManager] calAssetBytes:selectedAssetArr complettion:^(NSString *totalBytes) {
        self.imageSizeLabel.text = totalBytes;
    }];
    
    [UIView showOscillatoryAnimationWithLayer:self.dotImageView.layer type:ZTEscillatoryAnimationToSmaller];
}

#pragma mark 监听事件
- (void)clickFullBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected&&_selectedAssetArr.count > 0) {
        self.imageSizeLabel.hidden = NO;
    }else{
        self.imageSizeLabel.hidden = YES;
    }
}

- (void)preView:(UIButton*)sender{
    
}

- (void)clickDone:(UIButton*)sender{
    if (_doneBtnClickBlock) {
        _doneBtnClickBlock();
    }
}

#pragma mark getter
- (UIView*)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor =  [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    }
    return _topLine;
}
- (UIButton*)preViewBtn{
    if (!_preViewBtn) {
        _preViewBtn = [ZTEUIKit buttonWtihNormalText:@"PreView" font:ScreenFitFont(16) normalTextColor:[UIColor blackColor]];
        [_preViewBtn addTarget:self action:@selector(preView:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _preViewBtn;
}

- (UIButton*)fullImageBtn{
    if (!_fullImageBtn) {
        _fullImageBtn = [ZTEUIKit buttonWtihNormalText:@"full image" font:ScreenFitFont(16) normalTextColor:[UIColor lightGrayColor] normalImage:@"photo_original_def.png"];
        [_fullImageBtn setImage:[UIImage imageNamed:@"photo_original_sel.png"] forState:(UIControlStateSelected)];
        [_fullImageBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [_fullImageBtn addTarget:self action:@selector(clickFullBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        _fullImageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    }
    return _fullImageBtn;
}

- (UILabel*)imageSizeLabel{
    if (!_imageSizeLabel) {
        _imageSizeLabel = [ZTEUIKit labelWithText:@"(10M)" font:ScreenFitFont(15) textColor:[UIColor blackColor]];
    }
    return _imageSizeLabel;
}

- (UIButton*)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [ZTEUIKit buttonWtihNormalText:@"Done" font:ScreenFitFont(16) normalTextColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0] normalImage:@""];
        [_doneBtn setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5] forState:(UIControlStateDisabled)];
        [_doneBtn addTarget:self action:@selector(clickDone:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _doneBtn;
}

- (UIImageView*)dotImageView{
    if (!_dotImageView) {
        _dotImageView = [[UIImageView alloc]init];
        _dotImageView.image = [UIImage imageNamed:@"photo_number_icon.png"];
    }
    return _dotImageView;
}

- (UILabel*)imageCountLabel{
    if (!_imageCountLabel) {
        _imageCountLabel = [ZTEUIKit labelWithText:@"9" font:ScreenFitFont(15) textColor:[UIColor whiteColor]];
        _imageCountLabel.backgroundColor = [UIColor clearColor];
        _imageCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _imageCountLabel;
}
@end
