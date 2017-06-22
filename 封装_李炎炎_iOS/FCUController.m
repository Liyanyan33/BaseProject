//
//  FCUController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FCUController.h"
#import "DataSupport.h"
#import "FCUAdapter.h"

@interface FCUController ()
@property(nonatomic,strong)DataSupport *dataSupport;
@end

@implementation FCUController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FCU方案";
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
    FCUAdapter *fcuAdapter = [[FCUAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"fcu_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return fcuAdapter;
}
@end
