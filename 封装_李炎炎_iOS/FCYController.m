//
//  FCYController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FCYController.h"
#import "FCYAdapter.h"
#import "DataSupport.h"

@interface FCYController ()
@property(nonatomic,strong)DataSupport *dataSupport;
@end

@implementation FCYController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSupport];
}

#pragma mark 创建数据源  内部模拟了网络 异步请求
- (void)createDataSupport {
    self.dataSupport = [[DataSupport alloc] init];
    __weak typeof (self) weak_self = self;
    [self.dataSupport setUpdataDataSourceBlock:^(NSMutableArray *dataSource) {
        [weak_self onSuccessWithData:dataSource];
    }];
    [self addTestData];
}

- (void)addTestData {
    [self.dataSupport addTestData];
}

- (id)createAdapter{
    FCYAdapter *fcyAdapter = [[FCYAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"fcy_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return fcyAdapter;
}
@end
