//
//  OnLineResponModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "OnLineResponModel.h"

@implementation OnLineResponModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : @"AddressModel"};
}

@end

@implementation AddressModel

/** 计算正常状态的高度 默认显示三行*/
- (CGFloat)normal_height{
    CGSize name_size = [NSString getBoundSizeWithText:self.customerName font:[UIFont systemFontOfSize:17]];
    /** 计算一行文本的高度 */
    CGFloat one_row_height = [@"one" sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - 12*2].height;
    /** 计算整体文本的高度 */
    CGFloat text_height = [self.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - 12*2].height;
    /** 整个文本的高度大于三行 三行显示 否则 有多高显示多高 */
    text_height = text_height >= one_row_height*3 ? one_row_height*3:text_height;
    text_height = text_height + name_size.height + 15 + 15 + 15 + 25 + 15;
    return text_height;
}

/** 计算展开状态的高度 */
- (CGFloat)expand_height{
    CGSize name_size = [NSString getBoundSizeWithText:self.customerName font:[UIFont systemFontOfSize:17]];
    /** 计算整体文本的高度 */
    CGFloat text_height = [self.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - 12*2].height;
    text_height = text_height + name_size.height + 15 + 15 + 15 + 25 + 15;
    return text_height;
}


@end
