//
//  SoundModel.h
//  CustomProgress
//
//  Created by Admin on 2016/10/15.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordPlayManager.h"

typedef enum{
    NETWORK = 0,   //网络
    LOCAL = 1           //本地
}SoundState;

typedef enum{
    Ready = 0,
    NeedDown = 1,
    Downloading = 2
}FileState;

@interface SoundModel : NSObject

/** 声音文件的存储状态 */
@property (nonatomic,assign) SoundState type;

/** 声音文件的播放状态 */
@property (nonatomic,assign) PlayState currentState;

/** 声音文件的下载状态 */
@property (nonatomic,assign) FileState fileState;

/** 声音文件的本地存储路径 */
@property (nonatomic,copy) NSString * recordPath;

/** 声音文件的请求路径 */
@property (nonatomic,copy) NSString * urlString;

/** 声音文件的当前播放时间 */
@property (nonatomic,assign) NSInteger currentPalyTime;

/** 声音文件是否重置 */
@property (nonatomic,assign) BOOL isReset;

@end
