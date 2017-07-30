//
//  AAUController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AAUController.h"
#import "AAUAdapter.h"
#import "DataSupport.h"

@interface AAUController ()
@property (nonatomic, strong) DataSupport *dataSupport;
@end

@implementation AAUController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderRefresh:NO footerRefresh:NO];
    self.title = @"AAU方案";
    [self createDataSupport];
    self.tableView.estimatedRowHeight = 200;
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
    AAUAdapter *aauAdapter = [[AAUAdapter alloc]initWithSourceData:[self getData] andCellIdentifiers:@"aau_cell" withCellBlock:^(NSIndexPath *indexPath) {
        
    }];
    return aauAdapter;
}
@end
