//
//  AAUAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AAUAdapter.h"
#import "AAUCell.h"

@implementation AAUAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AAUCell *cell = [AAUCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;  //出现卡顿 用户体验极差
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
