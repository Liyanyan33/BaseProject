//
//  ZTEPhotoBrowserCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#define kIsFullWidthForLandScape NO
#define kMaxZoomScale 2.5f
#define kMinZoomScale 1.0f

#import "ZTEPhotoBrowserCell.h"
#import "ZTEBrowserPhotoModel.h"
#import "UIKit+AFNetworking.h"

@interface ZTEPhotoBrowserCell ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;
// 图片模型数据
@property(nonatomic,strong)ZTEBrowserPhotoModel *photoModel;
@end

@implementation ZTEPhotoBrowserCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)configCellWithDataModel:(id)dataModel{
    ZTEBrowserPhotoModel *model = dataModel;
    if (_photoModel == model) {
        return;
    }
    _photoModel = model;
    [self reloadImage];
}

- (void)createUI{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

// 重写frame方法
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    self.scrollView.frame = self.bounds;
    //调整内部控件的frame 主要针对imageView
    [self adjustFrame];
}

#pragma mark private methods
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
        
        [self resetScrollViewZoomScale];
    }
    self.scrollView.contentOffset = CGPointZero;
}

#pragma mnark private methods
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

// 重置scrollView的缩放系数
- (void)resetScrollViewZoomScale{
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.maximumZoomScale = self.scrollView.minimumZoomScale;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
}

// 设置图片
- (void)reloadImage{
    [self resetScrollViewZoomScale];
    if (self.photoModel.url) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.photoModel.url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        __weak __typeof(self)weakSelf = self;
        NSURL *recordImageURL = self.photoModel.url;
        //  开辟子线程 下载图片
        [self.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            if (![recordImageURL isEqual:weakSelf.photoModel.url]) {
                return;
            }
            weakSelf.imageView.image = image;
            [weakSelf adjustFrame];
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            if (![recordImageURL isEqual:weakSelf.photoModel.url]) {
                return ;
            }
        }];
    }else{
   
    }
    [self adjustFrame];
}

#pragma mark UISCrollViewDelegate
// 返回scrollView中需要进行缩放的目标控件
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

#pragma mark 监听事件
- (void)handleSingleTap:(UITapGestureRecognizer*)sender{
    
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)sender{
    
}

#pragma mark 懒加载
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self.scrollView addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:singleTap];
    }
    return _scrollView;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}
@end
