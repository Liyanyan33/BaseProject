//
//  TestController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/23.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "TestController.h"
#import "TestAdapter.h"
#import "AuthController.h"
#import "FriendController.h"
#import "NewFeatureController.h"
#import "AccountDB.h"

@interface TestController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *vcNameArr;
@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页--功能列表";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self initData];
    
    CGFloat fontSizeScale_var = 0;
    if (IS_IPHONE5) {
        fontSizeScale_var = 0.9;
    }else if (IS_IPHONE6){
        fontSizeScale_var = 1;
    }else if (IS_IPHONE6_PLUS){
        fontSizeScale_var = 1.5;
    }else if (IS_PAD){
        fontSizeScale_var = 2;
    }
    
    
    NSLog(@"%f--%f",kScreenWidth,kScreenHeight);
    NSLog(@"fontSizeScale_var = %f",fontSizeScale_var);
}

- (UITableViewStyle)getTableViewStytle{
    return UITableViewStyleGrouped;
}

- (id)createAdapter{
    TestAdapter *oAdapter = [[TestAdapter alloc]initWithCellBlock:^(NSIndexPath *indexPath) {
        if (indexPath.row == 2) {
            [self switchVC];
        }else{
            NSString *className = _vcNameArr[indexPath.row];
            Class class = NSClassFromString(className);
            if (class) {
                UIViewController *ctrl = [class new];
                [self.navigationController pushViewController:ctrl animated:YES];
            }
        }
    }];
    oAdapter.cellBtnClickBlock = ^(int index,int tag){
        NSLog(@"点击了第%d行cell中的按钮,第%d个按钮",index,tag - 100);
    };
    return oAdapter;
}

#pragma mark private methods
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    [_dataArr addObject:@"拆分controller中的代码 --\n1> 继承思想 cell - Controller - model 分别建立基类; \n2> 抽离tableView的协议方法 高仿Android适配器思想(Adapter) 为tableView创建一个适配器(其实现协议代理方法);\n3> model -- viewModel 进一步拆分 model内部的功能 将model的frame计算拆分出来 MVVM思想的使用"];
    [_dataArr addObject:@"iOS开发之多种Cell高度自适应实现方案的UI流畅度分析  >>"];
    [_dataArr addObject:@"高仿新浪微博app朋友圈--不同UI实现方式的性能分析"];
    [_dataArr addObject:@"测试富文本显示"];
    [_dataArr addObject:@"html——cell 显示"];
    [_dataArr addObject:@"用于测试的控制器"];
    [_dataArr addObject:@"测试控制器_02"];
    [_dataArr addObject:@"coreGraphics框架学习"];
    [_dataArr addObject:@"高仿QQ好友列表--可折叠列表实现"];
    [_dataArr addObject:@"高仿今日头条--频道的选择与删除(可拖拽)"];
    [_dataArr addObject:@"渐进式导航栏"];
    [self onSuccessWithData:_dataArr];
    
    _vcNameArr = [[NSMutableArray alloc]init];
    [_vcNameArr addObject:@"OnLineController"];
    [_vcNameArr addObject:@"CellHeightMainController"];
    [_vcNameArr addObject:@"kkk"];
    [_vcNameArr addObject:@"MyViewController"];
    [_vcNameArr addObject:@"HtmlController"];
    [_vcNameArr addObject:@"TestViewController"];
    [_vcNameArr addObject:@"Test_TwoController"];
    [_vcNameArr addObject:@"CoreGraphicController"];
    [_vcNameArr addObject:@"QQFoldController"];
    [_vcNameArr addObject:@"TodayHeadLineController"];
    [_vcNameArr addObject:@"AlphaController"];
}

- (void)switchVC{
    if ([AccountDB accountIsExpires]) { // 未曾登录
        AuthController *ac = [[AuthController alloc]init];
        [self.navigationController pushViewController:ac animated:YES];
    }else{ // 曾经登录过
        NSString *key = @"CFBundleVersion";
        // 上一次的使用版本（存储在沙盒中的版本号）
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        // 当前软件的版本号（从Info.plist中获得）
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        
        if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
            FriendController *fc = [[FriendController alloc]init];
            [self.navigationController pushViewController:fc animated:YES];
        } else { // 这次打开的版本和上一次不一样，显示新特性
            NewFeatureController *nfc = [[NewFeatureController alloc]init];
            [self.navigationController pushViewController:nfc animated:YES];
            // 将当前的版本号存进沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
@end
