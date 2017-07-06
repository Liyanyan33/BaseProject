//
//  WBTextPartModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "WBTextPartModel.h"

@implementation WBTextPartModel
- (NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
