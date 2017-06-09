//
//  BaseCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

/** 实例化构造方法 */
+ (instancetype)cellWithTableView:(UITableView*)tableView;

/** 创建内部的组件 */
- (void)createUI;

/** cell的高度 */
@property(nonatomic,assign)float cellHeight;

/** 根据模型数据来配置cell */
- (void)configCellWithModel:(id)model indexPath:(NSIndexPath*)indexPath;

@end
