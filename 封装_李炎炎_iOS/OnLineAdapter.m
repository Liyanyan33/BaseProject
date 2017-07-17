//
//  OnLineAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "OnLineAdapter.h"
#import "OnLineCell.h"
#import "OnLineResponModel.h"
#import "AdressViewModel.h"

@interface OnLineAdapter ()

@end

@implementation OnLineAdapter

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnLineCell *cell = [OnLineCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    cell.backgroundColor = randomColor;
    AdressViewModel *viewModel = self.sourceData[indexPath.row];
    // cell 传入数据模型 进行UI展示 
    [cell configCellWithModel:viewModel indexPath:indexPath];
    cell.btnBlock = ^(int tag){
        if (self.cellBtnClickBlock) {
            self.cellBtnClickBlock((int)indexPath.row,tag);
        }
    };
    cell.clickContentLabelBlock = ^(NSIndexPath *indexPath_select){
        viewModel.isExpand = !viewModel.isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath_select] withRowAnimation:(UITableViewRowAnimationNone)];
    };
    return cell;
}

#pragma mark 根据返回的数据内容动态计算cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdressViewModel *viewModel = self.sourceData[indexPath.row];
    return viewModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    headerImageView.image = [UIImage imageNamed:@"1.jpg"];
    return headerImageView;
}

#pragma mark cell加载出现的动画效果
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
