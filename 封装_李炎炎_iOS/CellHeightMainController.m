//
//  CellHeightMainController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/16.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "CellHeightMainController.h"
#import "CellHeightMainAdapter.h"

#import "AAUController.h"
#import "ACUController.h"
#import "FCUController.h"
#import "FCYController.h"

@interface CellHeightMainController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation CellHeightMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cell高度自适应方案";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self initData];
}

- (id)createAdapter{
    CellHeightMainAdapter *adapter = [[CellHeightMainAdapter alloc]initWithSourceData:_dataArr andCellIdentifiers:@"cellHeightMain" withCellBlock:^(NSIndexPath *indexPath) {
        switch (indexPath.row) {
            case 0:
            {
                AAUController *aauc = [[AAUController alloc]init];
                [self.navigationController pushViewController:aauc animated:YES];
            }
                break;
            case 1:
            {
                ACUController *acuc = [[ACUController alloc]init];
                [self.navigationController pushViewController:acuc animated:YES];
            }
                break;
            case 2:
            {
                FCUController *fcuc = [[FCUController alloc]init];
                [self.navigationController pushViewController:fcuc animated:YES];
            }
                break;
            case 3:
            {
                FCYController *fcyc = [[FCYController alloc]init];
                [self.navigationController pushViewController:fcyc animated:YES];
            }
                break;
            default:
                break;
        }
    }];
    return adapter;
}

- (void)initData{
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    [dataArr addObject:@"AutoLayout + AutomaticDimension + UIKit"];
    [dataArr addObject:@"AutoLayout + CellHeight + UIKit"];
    [dataArr addObject:@"FrameLayout + CellHeight + UIKit (目前最常用的一种方案 -- 还可以进一步进行性能上的优化)"];
    [dataArr addObject:@"FrameLayout + CellHeight + YYKit"];
    [dataArr addObject:@"FrameLayout + CellHeight + AsyncDisPlayKit"];
    _dataArr = dataArr;
    [self onSuccessWithData:dataArr];
}
@end
