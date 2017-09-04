//
//  FriendAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FriendAdapter.h"
#import "FriendCell.h"
#import "WBStatuViewModel.h"

@implementation FriendAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCell *cell = [FriendCell cellWithTableView:tableView];
    cell.friendCellInBottomToolBarClick = ^(NSInteger tag){
        if ([self.bottomToolBarClickDelegate respondsToSelector:@selector(bottomToolBarClickTag:friendAdapter:indexPath:)]) {
            [self.bottomToolBarClickDelegate bottomToolBarClickTag:tag friendAdapter:self indexPath:indexPath];
        }
    };
    [cell configCellWithViewModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBStatuViewModel *sViewModel = self.sourceData[indexPath.row];
    return sViewModel.cellHeight;
}

@end
