//
//  HtmlAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "HtmlAdapter.h"
#import "HtmlCell.h"

@implementation HtmlAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HtmlCell *cell = [HtmlCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    cell.backgroundColor = randomColor;
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HtmlCell calCellHeightWithModel:self.sourceData[indexPath.row]];
}

@end
