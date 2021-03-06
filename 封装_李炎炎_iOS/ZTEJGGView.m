//
//  ZTEJGGView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEJGGView.h"
#import "ZTEPhotoView.h"

#define HWStatusPhotoWH (kScreenWidth - HWStatusPhotoMargin*4)/3
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation ZTEJGGView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    NSUInteger photosCount = photos.count;
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        ZTEPhotoView *photoView = [[ZTEPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        ZTEPhotoView *photoView = self.subviews[i];
        photoView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [photoView addGestureRecognizer:tap];
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        ZTEPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * HWStatusPhotoWH + HWStatusPhotoMargin * (col+1);
        
        int row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count{
    // 最大列数（一行最多有多少列）
    int maxCols = HWStatusPhotoMaxCol(count);
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

#pragma mark 监听事件
- (void)tapClick:(UITapGestureRecognizer*)sender{
    NSInteger imageViewIndex = sender.view.tag;
    if (self.clickImageBlock) {
        self.clickImageBlock(imageViewIndex);
    }
}
@end
