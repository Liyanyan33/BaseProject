//
//  ZTEAttachmentModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  附件 (创建富文本)

#import <UIKit/UIKit.h>
#import "ZTEEmotionModel.h"

@interface ZTEAttachmentModel : NSTextAttachment
@property(nonatomic,strong)ZTEEmotionModel *emotionModel;
@end
