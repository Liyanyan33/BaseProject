//
//  BaseTableAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/21.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseTableAdapter.h"

@implementation BaseTableAdapter
// 初始化
- (instancetype)initWithSourceData:(NSArray *)sourceData andCellIdentifiers:(NSString *)identifiers withCellBlock:(BaseTableCellSelectedBlock)cellBlock{
    self = [super init];
    if(self){
        self.sourceData = sourceData;           // 数据
        self.cellIdentifiers = identifiers;           // 复用
        self.cellSelectedBlock = cellBlock;     // cell点击事件
    }
    return self;
}

- (instancetype)initWithCellIdentifiers:(NSString *)identifiers withCellBlock:(BaseTableCellSelectedBlock)cellBlock{
    self = [super init];
    if (self) {
        self.cellIdentifiers = identifiers;
        self.cellSelectedBlock = cellBlock;
    }
    return self;
}

- (instancetype)initWithCellBlock:(BaseTableCellSelectedBlock)cellBock{
    self = [super init];
    if (self) {
        self.cellSelectedBlock = cellBock;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:self.cellIdentifiers];
    }
    cell.textLabel.text = @"人参自古谁无死";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellSelectedBlock) {
        self.cellSelectedBlock(indexPath);
    }
}

#pragma mark cell加载出现的动画效果
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    /*! 第一种：3d xyz三维坐标刚出现0.1 0.1 1  0.5 s后正常 */
    //    cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1);
    //    [UIView animateWithDuration:0.6 animations:^{
    //
    //        cell.layer.transform = CATransform3DMakeScale(1,1,1);
    //
    //    }];
    
    /*! 第二种：卡片式动画 */
    //    static CGFloat initialDelay = 0.2f;
    //    static CGFloat stutter = 0.06f;
    //
    //    cell.contentView.transform =  CGAffineTransformMakeTranslation(BA_SCREEN_WIDTH, 0);
    //
    //    [UIView animateWithDuration:1.0f delay:initialDelay + ((indexPath.row) * stutter) usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
    //        cell.contentView.transform = CGAffineTransformIdentity;
    //    } completion:NULL];
    
    /*! 第三种：从下往上 */
    
    //    [UIView animateWithDuration:1 animations:^{
    //
    //        cell.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
    //
    //    }];
    
    /*! 第四种：右下角出来 */
    
    //    cell.layer.transform = CATransform3DMakeTranslation(SCREEN_WIDTH, SCREEN_HEIGHT, 0);
    //
    //    [UIView animateWithDuration:0.5 animations:^{
    //
    //        cell.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
    //
    //    }];
    
    /*! 第五种：右上角出现 */
    
    //    cell.layer.transform = CATransform3DMakeTranslation(SCREEN_WIDTH, -SCREEN_HEIGHT, 0);
    
    /*! 第六种：翻转动画 */
    //    CATransform3D rotation;
    //    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    //    rotation.m44 = 1.0/ -600;
    //    //阴影
    //    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    //
    //    //阴影偏移
    //    cell.layer.shadowOffset = CGSizeMake(10, 10);
    //    cell.alpha = 0;
    //    cell.layer.transform = rotation;
    //    //锚点
    //    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //    [UIView beginAnimations:@"rotation" context:NULL];
    //    [UIView setAnimationDuration:0.8];
    //    cell.layer.transform = CATransform3DIdentity;
    //    cell.alpha = 1;
    //    cell.layer.shadowOffset = CGSizeMake(0, 0);
    //    [UIView commitAnimations];
    
    /*! 第七种：扇形动画 */
    NSArray *array = tableView.indexPathsForVisibleRows;
    
    NSIndexPath *firstIndexPath = array[0];
    //设置anchorPoint﻿
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //为了防止cell视图移动，重新把cell放回原来的位置﻿
    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    //设置cell 按照z轴旋转90度，注意是弧度﻿
    if (firstIndexPath.row < indexPath.row)
    {
        cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
    }
    else
    {
        cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        
        cell.layer.transform = CATransform3DIdentity;
        
        cell.alpha = 1.0;
    }];
}

@end
