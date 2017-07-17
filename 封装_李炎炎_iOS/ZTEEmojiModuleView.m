//
//  ZTEEmojiModuleView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  表情键盘上部分 显示表情的View (这里分为四个模块 View (最近,默认,Emoji,浪小花))
//  里面有两个 子控件 (滚动视图和pageControl)

#import "ZTEEmojiModuleView.h"
#import "ZTEEmojiPageView.h"

@interface ZTEEmojiModuleView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation ZTEEmojiModuleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    // 1.pageControl
    self.pageControl.width = w;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = h - self.pageControl.height;
    
    // 2.scrollView
    self.scrollView.width = w;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        ZTEEmojiPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

- (void)setEmojiArr:(NSArray *)emojiArr{
    _emojiArr = emojiArr;
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger pageCount = emojiArr.count%ZTEEmotionPageSize == 0 ? emojiArr.count/ZTEEmotionPageSize : (emojiArr.count/ZTEEmotionPageSize)+1;
    // 设置分页页数
    _pageControl.numberOfPages = pageCount;
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i < pageCount; i++) {
        ZTEEmojiPageView *pageView = [[ZTEEmojiPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * ZTEEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emojiArr.count - range.location;
        if (left >= ZTEEmotionPageSize) { // 这一页足够20个
            range.length = ZTEEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emojiArr = [emojiArr subarrayWithRange:range];
        pageView.emojiBtnClick = ^(ZTEEmotionModel* emojiModel){
            if (_emojiBtnClick) {
                _emojiBtnClick(emojiModel);
            }
        };
        pageView.deleteBtnClick = ^(){
            if (_deleteBtnClick) {
                _deleteBtnClick();
            }
        };
        [self.scrollView addSubview:pageView];
    }
    
    // 1页20个
    // 总共55个
    // 第0页：20个
    // 第1页：20个
    // 第2页：15个
    [self setNeedsLayout];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    int currentPage = (int)(pageNo + 0.5);
    self.pageControl.currentPage = currentPage;
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NNSLog(@"%s",__func__);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / scrollView.width;
    NNSLog(@"index = %d",index);
}

#pragma mak 懒加载
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl*)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidesForSinglePage = YES; // 一个page时 隐藏控件
        // KVO 设置控件属性
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
    }
    return _pageControl;
}
@end
