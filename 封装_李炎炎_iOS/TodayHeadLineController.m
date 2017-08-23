//
//  TodayHeadLineController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/20.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TodayHeadLineController.h"
#import "TodayHeadLineCell.h"
#import "TodayHeadModel.h"

/** 可拖拽cell 的移动方向 */
typedef NS_ENUM(NSUInteger, DragCollectionCellMoveDirection){
    DragCollectionCellScorllDirectionNone,
    DragCollectionCellScorllDirectionUp,    // 上
    DragCollectionCellScorllDirectionDown, // 下
    DragCollectionCellScorllDirectionLeft,    //左
    DragCollectionCellScorllDirectionRight,  // 右
};

@interface TodayHeadLineController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** 集合控件的 流式布局 */
@property(nonatomic,strong)UICollectionViewFlowLayout *collectionViewLayout;
/** 集合控件 */
@property(nonatomic,strong)UICollectionView *collectionView;
/** 数据源数组 */
@property(nonatomic,strong)NSMutableArray *sourceData;
/** 长按手势 */
@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
/** 旧的indexPath */
@property(nonatomic,strong)NSIndexPath *oldIndexPath;
/** 是否可以拖拽 默认值为YES 可以拖拽 */
@property(nonatomic,assign)BOOL canDrag;
/** cell是否正在拖动 */
@property(nonatomic,assign)BOOL isDraging;
/** cell中心点的原始位置 */
@property(nonatomic,assign)CGPoint cellOldCenterPoint;
/** cell的截图快照 */
@property(nonatomic,strong)UIView *cellSnapView;
/** 长按拖拽时Cell缩放比例 默认是：1.2 */
@property (nonatomic, assign) CGFloat dragZoomScale;
/**  拖拽的Cell在拖拽移动时的透明度 默认是： 1.0 */
@property (assign, nonatomic) CGFloat dragCellAlpha;
/** 边缘检测定时器 */
@property(nonatomic,strong)CADisplayLink *edgeTimer;
@end

@implementation TodayHeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日头条频道选择与删除";
    _canDrag = YES;
    _dragZoomScale = 1.2;
    _dragCellAlpha = 1.0;
    [self createUI];
    [self initData];
}

#pragma mark private method
- (void)createUI{
    [self.view addSubview:self.collectionView];
}

- (void)initData{
     // 模拟网络请求 获取数据源
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (_sourceData == nil) {
            _sourceData = [[NSMutableArray alloc]init];
        }
        for (int i = 0; i < 2; i++) {
            NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
            if (i == 0) {
                for (int j = 0; j < 10; j++) {
                    TodayHeadModel *model = [[TodayHeadModel alloc]init];
                    model.title = [NSString stringWithFormat:@"(%d--%d)",i,j];
                    [sectionArr addObject:model];
                }
            }else{
                for (int j = 0; j < 20; j++) {
                    TodayHeadModel *model = [[TodayHeadModel alloc]init];
                    model.title = [NSString stringWithFormat:@"(%d--%d)",i,j];
                    [sectionArr addObject:model];
                }
            }
            [_sourceData addObject:sectionArr];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
    });
}

#pragma mark 针对cell 拖拽移动的方法
// 开启collectionViewcell 边缘滚动检测
- (void)setEdgeTimer{
    if (_edgeTimer == nil) {
        // 创建一个定时器
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(edgeTimerAction)];
        // 此定时器 一定要 添加到NSRunLoop中 否则无法生效
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (DragCollectionCellMoveDirection)getCellMoveDirection{
    CGFloat collectionViewHeight = self.collectionView.bounds.size.height;
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    CGFloat collectionViewOffsetY = self.collectionView.contentOffset.y;
    CGFloat collectionViewOffsetX = self.collectionView.contentOffset.x;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat cellSanpViewHeight = self.cellSnapView.bounds.size.height;
    CGFloat cellSnapViewWidth = self.cellSnapView.bounds.size.width;
    CGFloat cellSnapCenterY = self.cellSnapView.center.y;
    CGFloat cellSnapCenterX = self.cellSnapView.center.x;
    
    if (collectionViewHeight+ collectionViewOffsetY - cellSnapCenterY < cellSanpViewHeight/2 && collectionViewHeight + collectionViewOffsetY < collectionViewContentHeight) {
        return DragCollectionCellScorllDirectionDown;
    }
    if (cellSnapCenterY - collectionViewOffsetY < cellSanpViewHeight/2 && collectionViewOffsetY > 0) {
        return DragCollectionCellScorllDirectionUp;
    }
    if (collectionViewWidth + collectionViewOffsetX - cellSnapCenterX < cellSnapViewWidth/2 && collectionViewWidth + collectionViewOffsetX < collectionViewWidth) {
        return DragCollectionCellScorllDirectionRight;
    }
    if (cellSnapCenterX - collectionViewOffsetX < cellSnapViewWidth/2 && collectionViewOffsetX > 0) {
        return DragCollectionCellScorllDirectionLeft;
    }
    return DragCollectionCellScorllDirectionNone;
}

#pragma mark 监听事件
- (void)longPress:(UILongPressGestureRecognizer*)sender{
    /** 获取长按手势 在目标View上的 点击位置 */
    CGPoint point = [sender locationInView:self.collectionView];
    /** 根据点击位置 获取点击的indexPath */
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    /** 手势状态 */
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            _oldIndexPath = indexPath;
            // 用户没有按到 cell上的 按到cell之外的地方 直接break 中止下面的代码执行
            if (_oldIndexPath == nil) {
                self.longPress.enabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_canDrag) {
                        self.longPress.enabled = YES;
                    }
                });
                break;
            }
            // 代码能执行到这 说明 用户手指按在了cell上面
            // cell的状态标识(是否正在拖动 = NO --> cell没有被拖动)
            _isDraging = NO;
            // 获取用户正在长按的cell
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_oldIndexPath];
            self.cellOldCenterPoint = cell.center;
            // 获取cell的快照view
            self.cellSnapView = [cell snapshotViewAfterScreenUpdates:NO];
            self.cellSnapView.frame = cell.frame;
            [self.collectionView addSubview:self.cellSnapView];
            // 获取了当前长按cell的快照之后 要将当前cell隐藏
            cell.hidden = YES;
            
            // 获取当前用户手指触摸的中心点
            CGPoint currentPoint = point;
            // 将cell的快照View 动画放大和移动到触摸点下面
            [UIView animateWithDuration:0.25 animations:^{
                _cellSnapView.transform = CGAffineTransformMakeScale(_dragZoomScale, _dragZoomScale);
                _cellSnapView.center = CGPointMake(currentPoint.x, currentPoint.y);
                _cellSnapView.alpha = _dragCellAlpha;
            }];
            [self setEdgeTimer];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        default:
        {
        
        }
            break;
    }
}

- (void)edgeTimerAction{
    DragCollectionCellMoveDirection cellMoveDirection = [self getCellMoveDirection];
    switch (cellMoveDirection) {
        case DragCollectionCellScorllDirectionLeft:
        {
            
        }
            break;
        case DragCollectionCellScorllDirectionRight:
        {
            
        }
            break;
        case DragCollectionCellScorllDirectionUp:
        {
            
        }
            break;
        case DragCollectionCellScorllDirectionDown:
        {
        
        }
            break;
        default:
            break;
    }
}

#pragma mark 代理回调
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sourceData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [self.sourceData[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TodayHeadLineCell *cell = [TodayHeadLineCell cellWithCollectionView:collectionView indexPath:indexPath];
    TodayHeadModel *model = self.sourceData[indexPath.section][indexPath.item];
    [cell configCellWithModel:model indexPath:indexPath];
    cell.backgroundColor = randomColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        // 删除操作
        TodayHeadModel *todayHeadlinesDragModel = self.sourceData[indexPath.section][indexPath.row];
        NSMutableArray *secArray0 = self.sourceData[indexPath.section];
        NSMutableArray *secArray1 = self.sourceData[1];
        [secArray0 removeObject:todayHeadlinesDragModel];
        [secArray1 addObject:todayHeadlinesDragModel];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray1.count-1 inSection:1]];
    } else {
        // 添加操作
        TodayHeadModel *todayHeadlinesDragModel = self.sourceData[indexPath.section][indexPath.row];
        NSMutableArray *secArray0 = self.sourceData[0];
        NSMutableArray *secArray1 = self.sourceData[1];
        [secArray1 removeObject:todayHeadlinesDragModel];
        [secArray0 addObject:todayHeadlinesDragModel];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray0.count-1 inSection:0]];
    }
}

#pragma mark setter getter
- (UICollectionViewLayout*)collectionViewLayout{
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        /** 设置滚动方向 默认为竖直滚动 */
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionViewLayout.minimumLineSpacing = 1;
        _collectionViewLayout.minimumInteritemSpacing = 1;
        _collectionViewLayout.itemSize = CGSizeMake((kScreenWidth-4)/4.0, 55);
        _collectionViewLayout.headerReferenceSize = CGSizeMake(100, 40);
    }
    return _collectionViewLayout;
}

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) collectionViewLayout:self.collectionViewLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TodayHeadLineCell class] forCellWithReuseIdentifier:NSStringFromClass([TodayHeadLineCell class])];
        /** 添加长按手势 */
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.5f;
        [_collectionView addGestureRecognizer:longPress];
    }
    return _collectionView;
}
@end
