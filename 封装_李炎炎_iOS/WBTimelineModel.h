//
//  WBTimelineModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAdModel.h"
#import "WBAdvertityModel.h"
#import "WBStatuModel.h"

@interface WBTimelineModel : NSObject
/** 一次API请求的数据 */
@property (nonatomic, strong) NSArray<WBAdModel *> *ad;
@property (nonatomic, strong) NSArray<WBAdvertityModel*> *advertises;
@property (nonatomic, assign) int32_t has_unread;
@property(nonatomic,assign) int32_t hasvisible;
@property (nonatomic, assign) int32_t interval;
@property (nonatomic, strong) NSString *max_id;
@property (nonatomic, strong) NSString *next_cursor;
@property (nonatomic, strong) NSString *previous_cursor;
@property (nonatomic, strong) NSString *since_id;
@property (nonatomic, strong) NSArray<WBStatuModel*>  *statuses;
@property (nonatomic, assign) int32_t total_number;
@property (nonatomic, assign) int32_t uve_blank;
@end
