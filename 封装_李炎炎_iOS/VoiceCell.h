//
//  VoiceCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/3.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseCell.h"
#import "CustomProgress.h"
#import "SoundModel.h"
#import "RecordPlayManager.h"

@interface VoiceCell : BaseCell
@property (nonatomic,strong) RecordPlayManager * rdmanager;
@property (nonatomic,strong) SoundModel * sdModel;

@property (nonatomic,weak) id<CustomProgressDelegate> delegate;

@end
