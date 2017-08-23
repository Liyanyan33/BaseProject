//
//  QQFoldController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.

#import "QQFoldController.h"
#import "QQGroupModel.h"
#import "QQFoldAdapter.h"

@interface QQFoldController ()
/** 分组模型数组 */
@property(nonatomic,strong)NSMutableArray *groupModelArr;

@end

@implementation QQFoldController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QQ好友列表";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self loadData];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
- (id)createAdapter{
    QQFoldAdapter *adpter = [[QQFoldAdapter alloc]initWithCellBlock:^(NSIndexPath *indexPath) {
        NSLog(@"%ld--%ld",indexPath.section,indexPath.row);
    }];
    return adpter;
}

- (void)loadData {
    self.groupModelArr = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 加载本地数据（实际开发中这里写网络请求，从服务端请求数据...）
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"contacts" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *retCode = jsonObj[@"ret_code"];
        if ([retCode isEqualToString:@"0"]) {
            // 解析返回的结果：JSON转数据模型
            NSMutableArray *groupModelArr = [QQGroupModel mj_objectArrayWithKeyValuesArray:jsonObj[@"groups"]];
            self.groupModelArr = groupModelArr;
            int index = 0;
            for (QQGroupModel *groupModel in self.groupModelArr) {
                if (index == 0) {
                    groupModel.isFold = NO;
                }else{
                    // 初始化 默认为折叠状态
                    groupModel.isFold = YES;
                }
                index++;
            }
            // 回到主线程刷新表格
            dispatch_async(dispatch_get_main_queue(), ^{
                [self onSuccessWithData:self.groupModelArr];
            });
        }
    });
}

#pragma mak 懒加载
- (NSMutableArray*)groupModelArr{
    if (!_groupModelArr) {
        _groupModelArr = [[NSMutableArray alloc]init];
    }
    return _groupModelArr;
}
@end
