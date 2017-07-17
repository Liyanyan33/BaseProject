//
//  HtmlController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "HtmlController.h"
#import "HtmlAdapter.h"

@interface HtmlController ()
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HtmlController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UILabel显示富文本";
    _dataArr = [[NSMutableArray alloc]init];
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self loadTextDetail];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (id)createAdapter{
    HtmlAdapter *a = [[HtmlAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"html_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return a;
}

- (void)loadTextDetail{
    NSMutableDictionary *keyAndValueDictionary = [[NSMutableDictionary alloc] init];
    [NetWorking POSTWithUrl:@"http://jdcl-app-test.ztehealth.com/health/BaseData/queryAssistiveDevicesIntroduce" paramas:keyAndValueDictionary resultClass:nil success:^(id json) {
        [_dataArr addObject:json[@"data"][@"introduce"]];
        [_dataArr addObject:json[@"data"][@"target"]];
        [self onSuccessWithData:_dataArr];
    } failure:^(id error) {
        
    }];
}

@end
