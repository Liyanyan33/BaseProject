//
//  VoiceController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/3.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "VoiceController.h"
#import "VoiceAdapter.h"

#import "RecordPlayManager.h"
#import "SoundModel.h"

#import "LCAudioManager.h"

@interface VoiceController ()
@property(nonatomic,strong)NSMutableArray *playingArray;

@end

@implementation VoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playingArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"声音播放";
    [self setHeaderRefresh:NO footerRefresh:NO];
    [self requestData];
}

- (void)navBarLeftClick{

    NSLog(@"%s",__func__);
    [[LCAudioManager manager] stopPlaying];
}

- (id)createAdapter{

    VoiceAdapter *adapter = [[VoiceAdapter alloc]initWithServerData:[self getData] andCellIdentifiers:@"voiceCell" withCellBlock:^(id obj) {
        NSLog(@"%@",obj);
    }];
    return adapter;
}

- (void)requestData{

    //循环添加
    NSArray * urlStringArr = @[@"http://mp3.haoduoge.com/s/2016-07-15/1468555360.mp3",@"http://up.haoduoge.com:82/mp3/2016-10-17/1476682900.mp3",
                               @"http://mp3.haoduoge.com/s/2016-10-18/1476767283.mp3",@"http://mp3.haoduoge.com/s/2016-10-18/1476722077.mp3",
                               @"http://mp3.haoduoge.com/s/2016-10-18/1476793199.mp3",@"http://mp3.haoduoge.com/s/2016-10-17/1476708933.mp3",
                               @"http://mp3.haoduoge.com/s/2016-09-24/1474701070.mp3",@"http://mp3.haoduoge.com/s/2016-09-09/1473388972.mp3"];
    
    for (NSInteger i = 0; i< 8 ; i++) {
        
        RecordPlayManager * m = [[RecordPlayManager alloc] init];
        m.urlString = urlStringArr[i];
        m.playstate = Stop;
        
        SoundModel * sdmodel = [[SoundModel alloc] init];
        sdmodel.urlString = m.urlString;
        sdmodel.isReset = NO;
        sdmodel.currentState = Stop;
        m.sdModel = sdmodel;
        [self.playingArray addObject:m];
    }
    [self onSuccessWithData:self.playingArray];
}

@end
