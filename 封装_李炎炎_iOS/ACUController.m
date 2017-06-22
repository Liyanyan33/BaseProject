//
//  ACUController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ACUController.h"
#import "DataSupport.h"
#import "ACUAdapter.h"

@interface ACUController ()
@property(nonatomic,strong)DataSupport *dataSupport;
@end

@implementation ACUController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ACU方案";
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
    ACUAdapter *acuAdapter = [[ACUAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"acu_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return acuAdapter;
}

@end
