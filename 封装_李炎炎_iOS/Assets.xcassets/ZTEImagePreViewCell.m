//
//  ZTEImagePreViewCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEImagePreViewCell.h"
#import "ZTEAssetModel.h"
#import "ZTEAlbumManager.h"

#define kIsFullWidthForLandScape NO
#define kMaxZoomScale 2.5f
#define kMinZoomScale 1.0f

@interface ZTEImagePreViewCell ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ZTEImagePreViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self addTapGesture];
    }
    return self;
}

#pragma mark private method
- (void)createUI{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

- (void)addTapGesture{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:singleTap];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
}

- (void)configCellWithModel:(id)model{
    ZTEAssetModel *assetModel = (ZTEAssetModel*)model;
    if (assetModel.type == ZTEAssetModelTypeImage) {
        [[ZTEAlbumManager shareAlbumManager] getImageWithAsset:assetModel.asset completion:^(UIImage *image, NSDictionary *info) {
            self.imageView.image = image;
            [self adjustFrame];
        }];
    }
}

// 调整内部控件的frame 
- (void)adjustFrame{
    CGRect scrollFrame = self.scrollView.frame;
    if (self.imageView.image) {
        //  获取图片的尺寸大小
        CGSize imageSize = self.imageView.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (kIsFullWidthForLandScape) { //横屏
            CGFloat radio = scrollFrame.size.width/imageFrame.size.width;
            imageFrame.size.width = imageFrame.size.width * radio;
            imageFrame.size.height = imageFrame.size.height * radio;
        }else{ // 竖屏 宽度 < 高度
            // 防止图片失真模糊 进行等比例拉伸
            if (scrollFrame.size.width <= scrollFrame.size.height) {
                CGFloat radio = scrollFrame.size.width / imageFrame.size.width;
                imageFrame.size.width = imageFrame.size.width * radio;
                imageFrame.size.height = imageFrame.size.height * radio;
            }else{ // 横屏 宽度 > 高度
                CGFloat radio = scrollFrame.size.height / imageFrame.size.height;
                imageFrame.size.height = imageFrame.size.height * radio;
                imageFrame.size.width = imageFrame.size.width * radio;
            }
        }
        self.imageView.frame = imageFrame;
        self.scrollView.contentSize = self.imageView.frame.size;
        // imageView定位设置
        self.imageView.center = [self centerOfInScrollView:self.scrollView];
        
        // 设置scrollView的缩放比例系数 以scrollView与imageView的宽度比与高度比 比例较大的那个作为scrollView的最大缩放系数
        CGFloat maxScale = scrollFrame.size.height / imageFrame.size.height;
        maxScale = maxScale > scrollFrame.size.width / imageFrame.size.width ? maxScale : scrollFrame.size.width / imageFrame.size.width;
        maxScale = maxScale > kMaxZoomScale ? kMaxZoomScale : maxScale;
        
        self.scrollView.maximumZoomScale = maxScale;
        self.scrollView.minimumZoomScale = kMinZoomScale;
        self.scrollView.zoomScale = 1.0f;
    }else{
        scrollFrame.origin = CGPointZero;
        self.imageView.frame = scrollFrame;
        self.scrollView.contentSize = self.imageView.frame.size;
    }
    self.scrollView.contentOffset = CGPointZero;
}

// 根据scrollView的frame与scrollView的contentSize比较结果 计算imageView的位置
- (CGPoint)centerOfInScrollView:(UIScrollView*)scrollView{
    CGPoint point = CGPointZero;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    if (scrollView.frame.size.width > scrollView.contentSize.width) {
        offsetX = scrollView.frame.size.width/2 - scrollView.contentSize.width/2;
    }else{
        offsetX = 0;
    }
    if (scrollView.frame.size.height > scrollView.contentSize.height) {
        offsetY = scrollView.frame.size.height/2 - scrollView.contentSize.height/2;
    }else{
        offsetY = 0;
    }
    point = CGPointMake(scrollView.contentSize.width/2+offsetX, scrollView.contentSize.height/2+offsetY);
    
    return point;
}


#pragma mark 监听事件
- (void)singleTap:(UITapGestureRecognizer*)sender{
    
}

- (void)doubleTap:(UITapGestureRecognizer*)sender{
    
}

#pragma mark setter getter
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.delegate = self;
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.scrollsToTop = NO;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
