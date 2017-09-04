//
//  FriendAdapter.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "BaseTableAdapter.h"
@class FriendAdapter;
@protocol FriendAdapterBottomToolBarDelegate <NSObject>
@optional
- (void)bottomToolBarClickTag:(NSInteger)btnTag friendAdapter:(FriendAdapter*)friendAdapter indexPath:(NSIndexPath*)indexPath;

@end

@interface FriendAdapter : BaseTableAdapter
@property(nonatomic,weak)id<FriendAdapterBottomToolBarDelegate> bottomToolBarClickDelegate;

@end
