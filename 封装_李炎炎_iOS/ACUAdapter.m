//
//  ACUAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  这里共用了 AAUCell

#import "ACUAdapter.h"
#import "AAUCell.h"
#import "TestDataModel.h"

@implementation ACUAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AAUCell *cell = [AAUCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestDataModel *model = self.sourceData[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
