//
//  ZTEPickView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/23.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEPickView.h"
#define contentViewH 250
#define topH 45

@interface ZTEPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIView         *backView;
@property (strong, nonatomic) UIView         *contentView;
@property (strong, nonatomic) UIButton       *cancelBtn;
@property (strong, nonatomic) UIButton       *sureBtn;
@property (strong, nonatomic) UILabel        *addressLabel;
@property (strong, nonatomic) UIPickerView   *pickerView;
@property (strong, nonatomic) UIBezierPath   *bezierPath;
@property (strong, nonatomic) CAShapeLayer   *shapeLayer;
@end

@implementation ZTEPickView

+ (instancetype)pickView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.backView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.sureBtn];
    [self.contentView addSubview:self.pickerView];
    
    [self bezierPath];
    [self shapeLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.backView addGestureRecognizer:tap];
}

- (void)show{
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25f animations:^{
        _contentView.y = kScreenHeight - _contentView.height;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.25f animations:^{
        _contentView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark 监听事件
- (void)tap:(UITapGestureRecognizer*)sender{
    [self dismiss];
}

- (void)cancle:(UIButton*)sender{
    [self dismiss];
}

- (void)sure:(UIButton*)sender{
    
}

#pragma mark UIPickerViewDataSource UIPickerViewDelegate
// 返回选择器的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// 返回选择器 每列的 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}

// 返回选择器 每一列 对应的行数的 内容
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"绝顶高手";
}

// 返回选择器中 每列每行 对应的控件View
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel            = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel                 = [[UILabel alloc] init];
        pickerLabel.textAlignment   = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font            = [UIFont systemFontOfSize:17.0];
    }
    pickerLabel.text                = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor redColor];
        }
    }
    return pickerLabel;
}

//// 返回选择器中 每列每行的高度
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 44;
//}

#pragma mark 懒加载
/**背景View */
- (UIView *)backView {
    if (!_backView) {
        _backView                 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha           = 0.3;
    }
    return _backView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, contentViewH);
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    return _bezierPath;
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = _contentView.bounds;
        _shapeLayer.path = _bezierPath.CGPath;
        _contentView.layer.mask = _shapeLayer;
    }
    return _shapeLayer;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView                 = [[UIPickerView alloc]init];
        _pickerView.frame           = CGRectMake(0, topH, kScreenWidth, contentViewH - topH);
        _pickerView.delegate        = self;
        _pickerView.dataSource      = self;
        _pickerView.backgroundColor = RGBColor(245, 239, 245);
        _pickerView.showsSelectionIndicator = YES; // 显示 选中框
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, topH, topH);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn       = [UIButton buttonWithType:UIButtonTypeSystem];
        _sureBtn.frame = CGRectMake(kScreenWidth - topH, 0, topH, topH);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.frame = CGRectMake(topH, 0, kScreenWidth - topH*2, topH);
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _addressLabel;
}
@end
