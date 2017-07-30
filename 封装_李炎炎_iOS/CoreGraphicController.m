//
//  CoreGraphicController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "CoreGraphicController.h"
#import "CoreGraphicAdapter.h"

@interface CoreGraphicController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *vcNameArr;
@end

@implementation CoreGraphicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"coreGraphic框架学习";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self initData];
}

- (id)createAdapter{
    CoreGraphicAdapter *oAdapter = [[CoreGraphicAdapter alloc]initWithCellIdentifiers:@"test_cell" withCellBlock:^(NSIndexPath *indexPath) {
        NSString *className = _vcNameArr[indexPath.row];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *ctrl = [class new];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }];
    return oAdapter;
}

#pragma mark private methods
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    [_dataArr addObject:@"两大绘图框架（UIKit与CoreGraphic）以及三种获得图形上下文的方法,组合成6种不同的绘图方式"];
    [self onSuccessWithData:_dataArr];
    
    _vcNameArr = [[NSMutableArray alloc]init];
    [_vcNameArr addObject:@"CoreGraphicIntroduceController"];
}

@end
