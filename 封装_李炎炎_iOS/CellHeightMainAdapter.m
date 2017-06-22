//
//  CellHeightMainAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "CellHeightMainAdapter.h"
#import "OneLabelCell.h"

@implementation CellHeightMainAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneLabelCell *cell = [OneLabelCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OneLabelCell calCellHeightWithModel:self.sourceData[indexPath.row]];
}
@end
