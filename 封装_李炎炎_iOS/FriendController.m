//
//  FriendController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FriendController.h"
#import "FriendAdapter.h"
#import "AccountDB.h"
#import "WBTimelineModel.h"
#import "WBStatuViewModel.h"

@interface FriendController ()<FriendAdapterBottomToolBarDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation FriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    [self deletVCInNavStackWithVCName:@"NewFeatureController"];
}

- (id)createAdapter{
    FriendAdapter *fAdapter = [[FriendAdapter alloc]initWithCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    fAdapter.bottomToolBarClickDelegate = self;
    return fAdapter;
}

- (void)refreshData{
    [super refreshData];
    if (![ZteNetWorkUtils isNetworkExist]) {
        [ZTEToast showBottomWithText:@"没有网络，请检查网络设置" duration:2.0];
        return;
    }else{
        // https://api.weibo.com/2/statuses/user_timeline.json  获取用户发布的所有微博
        NSString *urlStr = @"https://api.weibo.com/2/statuses/user_timeline.json";
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"access_token"] = [AccountDB getAccountAccess_token];
        
        [NetWorking GETWithUrl:urlStr paramas:params resultClass:[WBTimelineModel class] success:^(id json) {
            [LYHud hideAtView:self.navigationController.view statu:Success];
            [ZTEToast showBottomWithText:@"网络数据加载成功" duration:4.0];
            WBTimelineModel *response = (WBTimelineModel*)json;
            // 模型转化 model --> viewModel
            _dataArr = [[NSMutableArray alloc]init];
            for (WBStatuModel *sModel in response.statuses) {
                WBStatuViewModel *sViewModel = [[WBStatuViewModel alloc]initWithStatuModel:sModel];
                [_dataArr addObject:sViewModel];
            }
            [self onSuccessWithData:_dataArr];
        } failure:^(id error) {
            [LYHud hideAtView:self.navigationController.view];
            [self onFalid];
        }];
    }
}

- (void)loadMoreData{
    
}

#pragma mark FriendAdapterBottomToolBarDelegate
- (void)bottomToolBarClickTag:(NSInteger)btnTag friendAdapter:(FriendAdapter *)friendAdapter indexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s--%ld -- %ld",__func__,(long)btnTag,(long)indexPath.row);
}
@end
