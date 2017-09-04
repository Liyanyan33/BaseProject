//
//  ZTEPhotoContentView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEPhotoContentView.h"
#import "ZTEPhotoBrowserCell.h"

@interface ZTEPhotoContentView ()<UIScrollViewDelegate>
/** 滚动视图控件 横向滚动 查看图片 */
@property(nonatomic,strong)UIScrollView *scrollView;
/** 存储控件中的所有可视cell */
@property(nonatomic,strong)NSMutableSet *visiableCells;
/** 存储所有可重用的cell */
@property(nonatomic,strong)NSMutableSet *reusableCells;

@property(nonatomic,assign) BOOL isIgnoreScroll;

@property(nonatomic,assign) BOOL isIgnorePreOperate;

@property(nonatomic,assign) BOOL isNotFirstSetCurrentIndex;

@end

@implementation ZTEPhotoContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-  (void)createUI{
    self.isIgnoreScroll = NO;
    self.isNotFirstSetCurrentIndex = NO;
    self.clipsToBounds = YES;
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    NSInteger cellCount = [self.dataSource cellCountOfZTEPhotoContentView:self];
    
    self.scrollView.frame = CGRectMake(-self.padding, 0, w + 2*self.padding, h);
    NSLog(@"滚动视图的 farme = %@",NSStringFromCGRect(self.scrollView.frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * cellCount, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.currentIndex * self.scrollView.width, 0);
    
    CGRect bounds = self.scrollView.bounds;
    for (ZTEPhotoBrowserCell *cell in self.visiableCells) {
       cell.frame = CGRectMake(CGRectGetWidth(bounds)*kCellIndex(cell)+self.padding, CGRectGetMinY(bounds), CGRectGetWidth(bounds)-2*self.padding, CGRectGetHeight(bounds));
    }
}

- (void)reloadData{
    self.isNotFirstSetCurrentIndex = NO;
    self.isIgnoreScroll = NO;
    
    // 更换数据源 重新刷新UI 需要清空之前所有存储的数据
    for (ZTEPhotoBrowserCell *cell in self.visiableCells) {
        [cell removeFromSuperview];
    }
    [self.visiableCells removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    NSInteger cellCount = [self getCellCount];

    if (_isAutoRoll && cellCount >=4) {
        self.currentIndex = 1;
    }else{
        self.currentIndex = 0; // 默认显示 第一个cell
    }
    // 数据源更换了 需要重新设置 scrollView的contentSize --> 调用layoutSubViews方法
    [self setNeedsLayout];
    [self layoutIfNeeded];
    // scrollView 滚动到指定的位置
    [self scrollToLocaionIndex:self.currentIndex animated:NO];
}

#pragma mark private methods
// 获取总的cell数量
- (NSInteger)getCellCount{
    NSInteger cellCount = [self.dataSource cellCountOfZTEPhotoContentView:self];
    return cellCount;
}
// scrollView 滚动到指定的位置
- (void)scrollToLocaionIndex:(NSInteger)locationIndex animated:(BOOL)animated{
    [self.scrollView setContentOffset:CGPointMake(locationIndex * CGRectGetWidth(self.scrollView.frame), 0) animated:animated];
    [self showCells];
}

- (void)showCells{
    // 判断处理
    NSInteger cellCount = [self getCellCount];
    if (cellCount <= 0) {
        return;
    }
    // 界定scrollView 滚动到 第几屏(所有可视cell的index范围)
    CGRect visibleBounds = self.scrollView.bounds;
    NSInteger firstIndex = (NSInteger)floor((CGRectGetMinX(visibleBounds)+self.padding*2) / CGRectGetWidth(visibleBounds));
    NSInteger lastIndex  = (NSInteger)floor((CGRectGetMaxX(visibleBounds)-1 - self.padding*2) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= cellCount) firstIndex = cellCount - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= cellCount) lastIndex = cellCount - 1;
    if (firstIndex>lastIndex) {
        return;
    }
    // 根据可视cell的index范围 重置可视cell集合与可重用cell集合
    NSInteger cellIndex;
    for (ZTEPhotoBrowserCell *cell in self.visiableCells) {
        cellIndex = kCellIndex(cell);
        if (cellIndex < firstIndex || cellIndex > lastIndex) {
            [self.reusableCells addObject:cell];
            [cell removeFromSuperview];
        }
    }
    [self.visiableCells minusSet:self.reusableCells];
    
    // 所有可视cell的index范围 -- > 展示可视范围之内的cell
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        [self showCellAtIndex:index];
    }
}

// 根据当前的可视cell的index 创建对应的cell控件
- (void)showCellAtIndex:(NSInteger)index{
    // 检测处理
    for (ZTEPhotoBrowserCell *cell in self.visiableCells) {
        if (kCellIndex(cell) == index) {
            return;
        }
    }
    NSInteger cellIndex = index;
    ZTEPhotoBrowserCell *cell = [self.dataSource photoContentView:self cellAtPageIndex:cellIndex];
    cell.tag = kCellTagOffset + cellIndex;
    // 设置cell的位置
    CGRect scrollVIewBounds = self.scrollView.bounds;
    cell.frame = CGRectMake(CGRectGetWidth(scrollVIewBounds)*index + self.padding, CGRectGetMinY(scrollVIewBounds), CGRectGetWidth(scrollVIewBounds) - 2*self.padding, CGRectGetHeight(scrollVIewBounds));
    NSLog(@"cell.frame = %@",NSStringFromCGRect(cell.frame));
    [self.visiableCells addObject:cell];
    [self.scrollView addSubview:cell];
}

/** 根据可重用标识 去可重用缓存池里面去 取cell */
- (id)dequeueReuseIdentifierCell:(NSString*)reuseIdentifier{
    ZTEPhotoBrowserCell *cell = nil;
    for (ZTEPhotoBrowserCell *reuseCell in self.reusableCells) {
        if ([reuseCell.reuseIdentifier isEqualToString:reuseIdentifier]) {
            cell = reuseCell;
            break;
        }
    }
    // 如果在缓存池 找到对应类型的cell 将其返回 (此cell接下来是要在屏幕上显示的 --> 会将其添加到可视cell数组中并且从可重用cell数组中移除)
    if (cell) {
        [self.reusableCells removeObject:cell];
    }
    return cell;
}

- (void)scrolToCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated{
    [self scrollToLocaionIndex:currentIndex animated:animated];
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark setter getter
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
}

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.autoresizesSubviews = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingNone;
        _scrollView.clipsToBounds = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableSet*)visiableCells{
    if (!_visiableCells) {
        _visiableCells = [[NSMutableSet alloc]init];
    }
    return _visiableCells;
}

- (NSMutableSet*)reusableCells{
    if (!_reusableCells) {
        _reusableCells = [[NSMutableSet alloc]init];
    }
    return _reusableCells;
}
@end
