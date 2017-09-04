//
//  FriendCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "BaseCell.h"
#import "WBBottomToolBar.h"

typedef void(^FriendCellInBottomToolBarClick)(NSInteger tag);

@interface FriendCell : BaseCell
@property(nonatomic,copy)FriendCellInBottomToolBarClick friendCellInBottomToolBarClick;
@end
