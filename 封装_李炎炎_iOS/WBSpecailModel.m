//
//  WBSpecailModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/4.
//  Copyright © 2017年 ZXJK. All rights reserved.
//   微博内容被正则表达式切割之后 的特殊字符片段(四种中去掉表情数据的其他三种)

#import "WBSpecailModel.h"

@implementation WBSpecailModel
- (NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
