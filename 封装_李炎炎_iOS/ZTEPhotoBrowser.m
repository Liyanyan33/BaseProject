//  ZTEPhotoBrowser.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/30.
//  Copyright © 2017年 ZXJK. All rights reserved.

#define photoAccessoryViewH 44

#import "ZTEPhotoBrowser.h"
#import "ZTEPhotoContentView.h"
#import "ZTEPhotoAccessoryView.h"
#import "ZTEBrowserPhotoModel.h"
#import "ZTEPhotoBrowserCell.h"

@interface ZTEPhotoBrowser ()<ZTEPhotoContentViewDataSource>
/** 存放/浏览所有图片的控件 */
@property(nonatomic,strong)ZTEPhotoContentView *photoContentView;
/** 配件控件 */
@property(nonatomic,strong)ZTEPhotoAccessoryView *photoAccessoryView;
/** 加载显示图片浏览器 的活动窗口*/
@property(nonatomic,strong)UIWindow *actionWindow;
@end

@implementation ZTEPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.photoContentView];
    [self.view addSubview:self.photoAccessoryView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.photoContentView.frame = self.view.bounds;
    self.photoAccessoryView.frame = CGRectMake(0, kScreenHeight - photoAccessoryViewH, kScreenWidth, photoAccessoryViewH);
}

#pragma mark private method
- (void)showPhotoBrowserWithImageUrls:(NSArray *)imageUrls clickImageIndex:(NSInteger)clickImageIndex{
    NSMutableArray *photoModelArr = [NSMutableArray arrayWithCapacity:imageUrls.count];
    for (int i = 0; i < imageUrls.count; i++) {
        ZTEBrowserPhotoModel *photoModel = [[ZTEBrowserPhotoModel alloc]init];
        id imageUrl = imageUrls[i];
        if ([imageUrl isKindOfClass:[NSString class]]) { // 图片名称 数组
            photoModel.url = [NSURL URLWithString:imageUrl];
        }else if ([imageUrl isKindOfClass:[NSURL class]]){ // 图片的URL 数组
            photoModel.url = imageUrl;
        }else{ // 就是图片的本身 数组
            photoModel.image = imageUrl;
        }
        [photoModelArr addObject:photoModel];
    }
    // 数据的本地化存储
    self.photoModelArr = photoModelArr;
    // photoContentView刷新数据源
    [self.photoContentView reloadData];
    // photoContentView 滚动到当前点击的index位置
    [self.photoContentView scrolToCurrentIndex:clickImageIndex animated:YES];
    // 图片浏览器的显示
    [self showWithAnimated:YES];
}

// 图片浏览器的显示
- (void)showWithAnimated:(BOOL)animated{
    if (!self.photoModelArr || self.photoModelArr.count <= 0) {
        return;
    }
    for (ZTEBrowserPhotoModel *model in self.photoModelArr) {
        if (![model isKindOfClass:[ZTEBrowserPhotoModel class]]) {
            NSAssert(NO, @"传递的图片类型不正确有不属于ZTEBrowserPhotoModel");
        }
    }
    if (animated) {
        self.actionWindow.layer.opacity = 0.1f;
        [UIView animateWithDuration:0.35f animations:^{
            self.actionWindow.layer.opacity = 1.0f;
        }];
    }
}

#pragma mark 监听事件回调

#pragma mark 代理回调 ZTEPhotoContentViewDataSource
- (NSInteger)cellCountOfZTEPhotoContentView:(ZTEPhotoContentView *)ZTEPhotoContentView{
    return self.photoModelArr.count;
}

- (ZTEPhotoBrowserCell*)photoContentView:(ZTEPhotoContentView *)photoContentView cellAtPageIndex:(NSUInteger)pageIndex{
    ZTEPhotoBrowserCell *cell = [photoContentView dequeueReuseIdentifierCell:@"zte_photo_browser_cell"];
    if (!cell) {
        cell = [[ZTEPhotoBrowserCell alloc]initWithReuseIdentifier:@"zte_photo_browser_cell"];
    }
    [cell configCellWithDataModel:self.photoModelArr[pageIndex]];
    return cell;
}

#pragma mark setter getter
- (void)setPhotoModelArr:(NSArray *)photoModelArr{
    if (_photoModelArr == photoModelArr) {
        return;
    }
    _photoModelArr = photoModelArr;
    for (int i = 0; i < photoModelArr.count; i++) {
        ZTEBrowserPhotoModel *photoModel = photoModelArr[i];
        photoModel.index = i; //设置图片模型数据的index
    }
}

- (ZTEPhotoContentView*)photoContentView{
    if (!_photoContentView) {
        _photoContentView = [[ZTEPhotoContentView alloc]init];
        _photoContentView.padding = 10.0f;
        _photoContentView.backgroundColor = [UIColor blackColor];
        _photoContentView.dataSource = self;
        // 设置frame
        _photoContentView.frame = self.view.bounds;
    }
    return _photoContentView;
}

- (ZTEPhotoAccessoryView*)photoAccessoryView{
    if (!_photoAccessoryView) {
        _photoAccessoryView = [[ZTEPhotoAccessoryView alloc]init];
    }
    return _photoAccessoryView;
}

- (UIWindow*)actionWindow{
    if (!_actionWindow) {
        _actionWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _actionWindow.opaque = YES;
        UIWindowLevel level = UIWindowLevelStatusBar;
        _actionWindow.windowLevel = level;
        _actionWindow.backgroundColor = [UIColor blackColor];
        _actionWindow.hidden = NO;
        _actionWindow.rootViewController = self;
        [_actionWindow makeKeyAndVisible];
    }
    return _actionWindow;
}
@end
