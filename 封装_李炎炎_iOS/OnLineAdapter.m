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

@interface OnLineAdapter ()
@end

@implementation OnLineAdapter

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnLineCell *cell = [OnLineCell cellWithTableView:tableView];
    cell.backgroundColor = randomColor;
    AddressModel *model = self.serverData[indexPath.row];
    // cell 传入数据模型 进行UI展示 
    [cell configCellWithModel:model indexPath:indexPath];
    
    cell.btnBlock = ^(int tag){
        if (self.cellBtnClickBlock) {
            self.cellBtnClickBlock((int)indexPath.row,tag);
        }
    };
    cell.clickContentLabelBlock = ^(NSIndexPath *indexPath_select){
        model.isExpand = !model.isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath_select] withRowAnimation:(UITableViewRowAnimationNone)];
    };

    return cell;
}

#pragma mark 根据返回的数据内容动态计算cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnLineCell *cell = (OnLineCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

@end
