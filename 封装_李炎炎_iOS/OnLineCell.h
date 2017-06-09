//
//  OnLineCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseCell.h"

typedef void(^OnLineCellBtnBlock)(int tag);
typedef void(^ClickContentLabelBlock)(NSIndexPath *indexPath);

@interface OnLineCell : BaseCell
@property(nonatomic,copy)ClickContentLabelBlock clickContentLabelBlock;
@property(nonatomic,copy)OnLineCellBtnBlock btnBlock;

@end
