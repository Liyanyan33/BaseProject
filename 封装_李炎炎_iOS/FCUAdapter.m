//
//  FCUAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FCUAdapter.h"
#import "FCUCell.h"
#import "TestDataModel.h"

@implementation FCUAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FCUCell *cell = [FCUCell cellWithTableView:tableView withReuseIdentify:self.cellIdentifiers];
    [cell configCellWithModel:self.sourceData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestDataModel *model = self.sourceData[indexPath.row];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"%s",__func__);
    return 180;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    headerImageView.image = [UIImage imageNamed:@"1.jpg"];
    return headerImageView;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
