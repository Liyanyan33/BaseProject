//
//  FriendController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FriendController.h"
#import "FriendAdapter.h"

@interface FriendController ()

@end

@implementation FriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    [self deletVCInNavStackWithVCName:@"NewFeatureController"];
}

- (id)createAdapter{
    FriendAdapter *fAdapter = [[FriendAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"friend_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return fAdapter;
}

- (void)refreshData{
    
}

- (void)loadMoreData{
    
}




@end
