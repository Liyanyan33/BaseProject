//
//  VoiceAdapter.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/3.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "VoiceAdapter.h"
#import "VoiceCell.h"

#import "RecordPlayManager.h"

@implementation VoiceAdapter

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    VoiceCell *cell = [VoiceCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RecordPlayManager *rpm = self.serverData[indexPath.row];
    cell.sdModel = rpm.sdModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 85;
}

@end
