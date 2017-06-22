//
//  FCYAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FCYAdapter.h"
#import "FCYCell.h"
#import "TestDataModel.h"

@implementation FCYAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FCYCell *cell = [FCYCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
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
