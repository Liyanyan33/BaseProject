//
//  ZTEAttachmentModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/17.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEAttachmentModel.h"

@implementation ZTEAttachmentModel
- (void)setEmotionModel:(ZTEEmotionModel *)emotionModel{
    _emotionModel = emotionModel;
    self.image = [UIImage imageNamed:emotionModel.png];
}
@end
