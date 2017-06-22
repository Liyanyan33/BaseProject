//
//  FriendAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FriendAdapter.h"
#import "FriendCell.h"

@implementation FriendAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCell *cell = [FriendCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    return cell;
}

@end
