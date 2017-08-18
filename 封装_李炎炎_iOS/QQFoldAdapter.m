//
//  QQFoldAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.

#import "QQFoldAdapter.h"
#import "QQGroupModel.h"
#import "QQContactCell.h"
#import "QQFoldSectionHeaderView.h"

@implementation QQFoldAdapter

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"分组数量 = %lu",(unsigned long)self.sourceData.count);
    return self.sourceData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    QQGroupModel *groupModel = self.sourceData[section];
    if (groupModel.isFold) {
        return 0;
    }else{
        return groupModel.contacts.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QQContactCell *cell = [QQContactCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell点击不变色
    
    QQGroupModel *groupModel = self.sourceData[indexPath.section];
    QQContactModel *contactModel = groupModel.contacts[indexPath.row];
    [cell configCellWithModel:contactModel indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 * kScaleFit;
}

/** 返回分区头视图的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 * kScaleFit;
}

/** 返回分区尾视图的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10.0f;
    } else {
        return 1.0f;
    }
}

/** 返回头视图 */
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QQGroupModel *groupModel = self.sourceData[section];
    QQFoldSectionHeaderView *headerView = [[QQFoldSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50*kScaleFit)];
    [headerView configHeaderView:groupModel indexPath:nil];
    headerView.tapBlock = ^(){
        groupModel.isFold = !groupModel.isFold;
        [tableView reloadSection:section withRowAnimation:(UITableViewRowAnimationFade)];
    };
    return headerView;
}

/** 返回尾视图 */
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    return clearView;
}
@end
