//
//  ZTEPhotoView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEPhotoView.h"

@interface ZTEPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation ZTEPhotoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
        // 开启事件交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setPhoto:(ZTEPhotoModel *)photo{
    _photo = photo;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 显示\隐藏gif控件
    // 判断是够以gif或者GIF结尾
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

#pragma mark 懒加载
- (UIImageView *)gifView{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}
@end
