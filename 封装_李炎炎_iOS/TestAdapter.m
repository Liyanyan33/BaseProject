//
//  TestAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/11.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TestAdapter.h"

@implementation TestAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifiers];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:self.cellIdentifiers];
    }
    cell.textLabel.text = self.sourceData[indexPath.row];
    return cell;
}


@end
