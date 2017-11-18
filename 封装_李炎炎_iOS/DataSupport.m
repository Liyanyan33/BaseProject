//
//  DataSupport.m
//  DisplayLayout
//
//  Created by Mr.LuDashi on 16/9/9.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "DataSupport.h"
#import "TestDataModel.h"
#import <UIKit/UIKit.h>

#define contentText @"成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，在草长莺飞的季节里喃喃低唱，到处人潮汹涌还会孤独怎么，在灯火阑珊处竟然会觉得荒芜，从前轻狂绕过时光，成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，谁在一边走一边唱一边回头张望，那些苦涩始终都要去尝，怎么，长大后不会大笑也不会再大哭了，从前轻狂绕过时光，让我们彼此分享互相陪伴吧，一起面对人生这一刻的孤独吧，行歌，在草长莺飞的季节里喃喃低唱，从前轻狂绕过时光.成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，在草长莺飞的季节里喃喃低唱，到处人潮汹涌还会孤独怎么，在灯火阑珊处竟然会觉得荒芜，从前轻狂绕过时光，成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，谁在一边走一边唱一边回头张望，那些苦涩始终都要去尝，怎么，长大后不会大笑也不会再大哭了，从前轻狂绕过时光，让我们彼此分享互相陪伴吧，一起面对人生这一刻的孤独吧，行歌，在草长莺飞的季节里喃喃低唱，从前轻狂绕过时光"

@interface DataSupport()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UpdateDataSourceBlock updateDataBlock;
@end

@implementation DataSupport

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = [[NSMutableArray alloc] initWithCapacity:50];
        [self addTestData];
    }
    return self;
}

- (void)setUpdataDataSourceBlock:(UpdateDataSourceBlock) updateDataBlock {
    self.updateDataBlock = updateDataBlock;
}

#pragma mark - Prevate Method
/**
 模拟网络请求来生成数据，然后对数据进行处理生成Model。当然这个生成测试数据的过程没有用到主线程，为了不阻塞Main线程，我们需要将数据生成的部分在子线程中异步的执行。当然此处主要涉及多线程的东西。下方代码段就是数据提供者DataSupport的核心代码。
 
 下方代码段主要用到了并行队列的异步执行，任务组的使用，已经任务锁的添加。下方首先创建了一个并行队列concurrentQueue和队列的任务组group，并且为了数据同步，我们使用信号量创建了一个任务锁lock。在for循环中我们异步的执行并行队列来创建我们需要的数据模型Model。每循环一次创建一个Model，为了Model数据的独立性，在创建Model时，我们要为其添加信号量同步锁。
 
 当50条数据异步创建完毕后，我们需要将其提供给数据提供者的使用放，也就是在任务组中的任务都执行完毕后，会执行下方的notify方法。
 */
- (void)addTestData {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("zeluli.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    
    for (int i = 0; i < 200; i ++) {
        dispatch_group_async(group, concurrentQueue, ^{
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            [self createTestModel];
            dispatch_semaphore_signal(lock);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self updateDataSource];
    });
}

- (void)createTestModel {
    TestDataModel * model = [[TestDataModel alloc] init];
    model.title = @"行歌";
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    model.time = [dataFormatter stringFromDate:[NSDate date]];
    
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg", arc4random() % 6];
    model.imageName =imageName;
    
    NSInteger endIndex = arc4random() % contentText.length;
    model.content = [contentText substringToIndex:endIndex];
    
    model.textHeight = [self countTextHeight:model.content];
    
    model.cellHeight = model.textHeight + 80;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:model.content];
    text.font = [UIFont systemFontOfSize:14];
    text.lineSpacing = 3;
    model.attributeContent = text;
    
    model.attributeTitle = [[NSAttributedString alloc] initWithString:model.title];
    model.attributeTime = [[NSAttributedString alloc] initWithString:model.time];
    
    [self.dataSource addObject:model];
}

-(CGFloat)countTextHeight:(NSString *) text {
    CGSize contentSize = [text sizeWithFont:[UIFont systemFontOfSize:17] withWidth:kScreenWidth - 20];
    return contentSize.height;
}

- (void)updateDataSource {
    if (self.updateDataBlock != nil) {
        self.updateDataBlock(self.dataSource);
    }
}

@end
