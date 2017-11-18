//
//  HtmlController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "HtmlController.h"
#import "HtmlAdapter.h"
#import <XHToast.h>

@interface HtmlController ()
{
    // 页面网络请求次数
    int _HttpCount;
}
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HtmlController

- (void)viewDidLoad {
    [super viewDidLoad];
    _HttpCount = 2;
    self.title = @"UILabel显示富文本";
    _dataArr = [[NSMutableArray alloc]init];
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self showLoading];
    [self loadTextDetail];
//    [self loadTextDetail_test];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)navBarRightClick{
    [XHToast showBottomWithText:@"waiting minte ....." duration:3.0];
}

- (id)createAdapter{
    HtmlAdapter *a = [[HtmlAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"html_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return a;
}

- (void)loadTextDetail_test{
    NSMutableDictionary *keyAndValueDictionary = [[NSMutableDictionary alloc] init];
    [NetWorking POSTWithUrl:@"http://jdcl-app-test.ztehealth.com/health/BaseData/queryAssistiveDevicesIntroduce" paramas:keyAndValueDictionary resultClass:nil success:^(id json) {
        _HttpCount--;
        NNSLog(@"_HttpCount = %d -- loadTextDetail_test",_HttpCount);
        [self hide];
        [_dataArr addObject:json[@"data"][@"introduce"]];
        [_dataArr addObject:json[@"data"][@"target"]];
        [self onSuccessWithData:_dataArr];
    } failure:^(id error) {
        
    }];
}

- (void)loadTextDetail{
    NSMutableDictionary *keyAndValueDictionary = [[NSMutableDictionary alloc] init];
    [NetWorking POSTWithUrl:@"http://jdcl-app-test.ztehealth.com/health/BaseData/queryAssistiveDevicesIntroduce" paramas:keyAndValueDictionary resultClass:nil success:^(id json) {
//        _HttpCount--;
        [self hideLoading];
        [self showSuccess:self.view];
        NNSLog(@"_HttpCount = %d -- loadTextDetail",_HttpCount);
        [_dataArr addObject:json[@"data"][@"introduce"]];
        [_dataArr addObject:json[@"data"][@"target"]];
        [self onSuccessWithData:_dataArr];
    } failure:^(id error) {
        
    }];
}

- (void)hide{
//    if (_HttpCount == 0) {
        [self hideLoading];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
