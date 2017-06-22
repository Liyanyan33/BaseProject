//
//  OnLineController.m
//  封装_李炎炎_iOS
//  Created by lyy on 16/10/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
#import "OnLineController.h"
#import "OnLineCell.h"
#import "OnLineResponModel.h"
#import "OnLineAdapter.h"
#import "VoiceController.h"
#import "AdressViewModel.h"

@interface OnLineController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation OnLineController
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    [self setHeaderRefresh:YES footerRefresh:NO];
    self.title = @"地址列表";
}

- (id)createAdapter{
    OnLineAdapter *oAdapter = [[OnLineAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"OnLineCell" withCellBlock:^(id obj) {
        NSLog(@"%@",obj);
    }];
    oAdapter.cellBtnClickBlock = ^(int index,int tag){
        NSLog(@"点击了第%d行cell中的按钮,第%d个按钮",index,tag - 100);
    };
    return oAdapter;
}

- (void)refreshData{
    [super refreshData];
    if (![ZteNetWorkUtils isNetworkExist]) {
        [LYToast showBottomWithText:@"没有网络，请检查网络设置" duration:2.0];
        return;
    }else{
        NSString *urlStr = @"http://test2.mobile.care.ztehealth.com/health/MyService/qryCustomerArea";
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        params[@"authMark"] = @"deeevabgksugcqxu";
        params[@"customerId"] = @"493058";
        [LYHud showAtView:self.navigationController.view title:@"正在加载数据" dimBackground:NO];
        [NetWorking POSTWithUrl:urlStr paramas:params resultClass:[OnLineResponModel class] success:^(id json) {
            [LYHud hideAtView:self.navigationController.view statu:Success];
            OnLineResponModel *olrm = json;
            if (olrm.isSuccess) {
                NSLog(@"数据请求成功！！！");
            }
            // model 转 viewModel
            for (AddressModel *model in olrm.data) {
                AdressViewModel *aViewModel = [[AdressViewModel alloc]init];
                aViewModel.adressModel = model;
                [_dataArr addObject:aViewModel];
            }
            [self onSuccessWithData:_dataArr];  // 数据请求成功之后 基类需要刷新UI
            [LYToast showBottomWithText:@"网络数据加载成功" duration:4.0];
        } failure:^(id error) {
            [LYHud hideAtView:self.navigationController.view];
            [self onFalid];
            NSLog(@"error = %@",error);
        }];
    }
}

- (void)navBarRightClick{
    VoiceController *vc = [[VoiceController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
