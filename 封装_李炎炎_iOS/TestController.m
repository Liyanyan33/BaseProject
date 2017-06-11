//
//  TestController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/23.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "TestController.h"
#import "TestAdapter.h"
#import "OnLineController.h"


@interface TestController ()
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页--功能列表";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self initData];
}

- (id)createAdapter{
    TestAdapter *oAdapter = [[TestAdapter alloc]initWithSourceData:_dataArr andCellIdentifiers:@"OnLineCell" withCellBlock:^(NSIndexPath *indexPath) {
        if (indexPath.row == 0) {
            OnLineController *ovc = [[OnLineController alloc]init];
            [self.navigationController pushViewController:ovc animated:YES];
        }
    }];
    oAdapter.cellBtnClickBlock = ^(int index,int tag){
        NSLog(@"点击了第%d行cell中的按钮,第%d个按钮",index,tag - 100);
    };
    return oAdapter;
}

- (void)initData{
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    [dataArr addObject:@"地址列表 -- "];
    [dataArr addObject:@"其他功能 -- "];
    _dataArr = dataArr;
    [self onSuccessWithData:dataArr];
}
@end
