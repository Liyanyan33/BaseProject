//
//  BaseCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

/** 代码创建cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView*)tableView withReuseIdentify:(NSString*)reuseIdentify{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (cell == nil) {
        cell = [[[self class] alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentify];
    }
    return cell;
}

/** 系统的构造方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle = UITableViewCellSelectionStyleNone; //cell点击不变色
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
}

/**从 xib 文件创建cell */
+ (instancetype)cellLoadXibWithTableView:(UITableView *)tableView{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    
}

- (void)configCellWithViewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath{
    
}

+ (CGFloat)calCellHeightWithModel:(id)modelData{
    CGFloat cellHeight = 0;
    return cellHeight;
}
@end
