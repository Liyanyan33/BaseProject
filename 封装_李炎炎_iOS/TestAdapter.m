//
//  TestAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/11.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "TestAdapter.h"
#import "OneLabelCell.h"

@implementation TestAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneLabelCell *cell = [OneLabelCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OneLabelCell calCellHeightWithModel:self.sourceData[indexPath.row]];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"%s",__func__);
    return 180;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    headerImageView.image = [UIImage imageNamed:@"1.jpg"];
    return headerImageView;
}
@end
