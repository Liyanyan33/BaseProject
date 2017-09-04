//
//  OrginalStatuView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  原创微博View

#import "OrginalStatuView.h"
#import "WBStatuViewModel.h"
#import "StatuTextView.h"
#import "ZTEJGGView.h"
#import "ZTEPhotoBrowser.h"

@interface OrginalStatuView ()
@property(nonatomic,strong)StatuTextView *textView;
@property(nonatomic,strong)UILabel *txtLabel;
@property(nonatomic,strong)ZTEJGGView *jggView;
@property(nonatomic,strong)WBStatuViewModel *sViewModel;
@end

@implementation OrginalStatuView

- (void)createUI{
    [self addSubview:self.textView];
    [self addSubview:self.jggView];
}

- (void)configWithViewModel:(id)viewModel{
    _sViewModel = (WBStatuViewModel*)viewModel;
    
    _textView.attributedText = _sViewModel.statuModel.orginalAttrStr;
    _textView.frame = _sViewModel.orginalTxtFrame;
    
    _jggView.photos = _sViewModel.statuModel.pic_urls;
    _jggView.frame = _sViewModel.orginalJGGFrame;
}

#pragma mark private method
- (NSArray*)generateImageUrlStrArr{
    NSMutableArray *imageUrlArr = [[NSMutableArray alloc]init];
    for (ZTEPhotoModel *model in _sViewModel.statuModel.pic_urls) {
        [imageUrlArr addObject:model.thumbnail_pic];
    }
    return imageUrlArr;
}

#pragma mak 懒加载
- (StatuTextView*)textView{
    if (!_textView) {
        _textView = [[StatuTextView alloc]init];
    }
    return _textView;
}
- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]init];
        _txtLabel.numberOfLines = 0;
        _txtLabel.backgroundColor = [UIColor greenColor];
    }
    return _txtLabel;
}

- (ZTEJGGView*)jggView{
     __weak __typeof(self)weakSelf = self;
    if (!_jggView) {
        _jggView = [[ZTEJGGView alloc]init];
        _jggView.clickImageBlock = ^(NSInteger clickImageIndex){
            ZTEPhotoBrowser *photoBrowser = [[ZTEPhotoBrowser alloc]init];
            [photoBrowser showPhotoBrowserWithImageUrls:[weakSelf generateImageUrlStrArr] clickImageIndex:clickImageIndex];
            
        };
    }
    return _jggView;
}
@end
