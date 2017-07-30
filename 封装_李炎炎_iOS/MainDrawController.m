//
//  MainDrawController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "MainDrawController.h"
#import "MainDrawAdapter.h"

@interface MainDrawController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *vcNameArr;
@end

@implementation MainDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘图的六种不同方式";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self initData];
}


- (id)createAdapter{
    MainDrawAdapter *oAdapter = [[MainDrawAdapter alloc]initWithCellIdentifiers:@"test_cell" withCellBlock:^(NSIndexPath *indexPath) {
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
    [_dataArr addObject:@"在UIView的子类方法drawRect：中绘制一个蓝色圆，使用UIKit在Cocoa为我们提供的当前上下文中完成绘图任务"];
    [_dataArr addObject:@"使用Core Graphics实现绘制蓝色圆"];
    [_dataArr addObject:@"我将在UIView子类的drawLayer:inContext：方法中实现绘图任务。drawLayer:inContext：方法是一个绘制图层内容的代理方法。为了能够调用drawLayer:inContext：方法，我们需要设定图层的代理对象。但要注意，不应该将UIView对象设置为显示层的委托对象，这是因为UIView对象已经是隐式层的代理对象，再将它设置为另一个层的委托对象就会出问题。轻量级的做法是：编写负责绘图形的代理类"];
    [self onSuccessWithData:_dataArr];
    
    _vcNameArr = [[NSMutableArray alloc]init];
    [_vcNameArr addObject:@"FirstDrawController"];
    [_vcNameArr addObject:@"SDrawController"];
    [_vcNameArr addObject:@"TDrawController"];
}



@end
