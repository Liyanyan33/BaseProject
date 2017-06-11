//
//  AdressViewModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/11.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AdressViewModel.h"

static CGFloat marginTop = 15;
static CGFloat marginLeft = 12;
static CGFloat marginRight = 12;
static CGFloat marginBottom = 15;
static CGFloat btnWidth = 60;
static CGFloat btnHeight = 25;

@implementation AdressViewModel

- (void)setAdressModel:(AddressModel *)adressModel{
    _adressModel = adressModel;
    // 姓名
    CGSize name_size = [NSString getBoundSizeWithText:adressModel.customerName font:[UIFont systemFontOfSize:17]];
    _name_frame = CGRectMake(marginTop, marginLeft, name_size.width, name_size.height);
    
    //电话号码
    CGSize phone_size = [NSString getBoundSizeWithText:adressModel.phoneNumber font:[UIFont systemFontOfSize:15]];
    _number_frame = CGRectMake(kScreenWidth - marginRight - phone_size.width, marginTop, phone_size.width, phone_size.height);
    
    //地址内容
    if (self.isExpand) { // 展开
        CGSize content_size = [adressModel.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft - marginRight];
        _content_frame = CGRectMake(marginLeft, CGRectGetMaxY(_name_frame) + marginTop, content_size.width, content_size.height);
    }else{ // 不展开
        /** 计算一行文本的高度 */
        CGSize one_row_size = [@"one" sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft*2];
        /** 计算整体文本的高度 */
        CGSize text_size = [adressModel.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft*2];
        /** 整个文本的高度大于三行 三行显示 否则 有多高显示多高 */
        CGFloat  text_height = text_size.height >= one_row_size.height*3 ? one_row_size.height*3:text_size.height;
        CGFloat text_width =  text_size.height >= one_row_size.height*3 ? kScreenWidth - marginLeft*2:text_size.width;
        _content_frame = CGRectMake(marginLeft, CGRectGetMaxY(_name_frame) + marginTop, text_width, text_height);
    }
    _chakan_frame = CGRectMake(kScreenWidth - marginRight - btnWidth - btnWidth - marginLeft, CGRectGetMaxY(_content_frame)+marginTop, btnWidth, btnHeight);
    _dele_frame = CGRectMake(CGRectGetMaxX(_chakan_frame)+marginLeft, _chakan_frame.origin.y, btnWidth, btnHeight);
    
    self.cellHeight = CGRectGetMaxY(_chakan_frame) + marginBottom;
}

/** 设置是否展开 */
- (void)setIsExpand:(BOOL)isExpand{
    _isExpand = isExpand;
    if (_isExpand) { // 展开
        CGSize content_size = [_adressModel.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft - marginRight];
        _content_frame = CGRectMake(marginLeft, CGRectGetMaxY(_name_frame) + marginTop, content_size.width, content_size.height);
    }else{ // 不展开
        /** 计算一行文本的高度 */
        CGSize one_row_size = [@"one" sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft*2];
        /** 计算整体文本的高度 */
        CGSize text_size = [_adressModel.detailAddress sizeWithFont:[UIFont systemFontOfSize:18] withWidth:kScreenWidth - marginLeft*2];
        /** 整个文本的高度大于三行 三行显示 否则 有多高显示多高 */
        CGFloat  text_height = text_size.height >= one_row_size.height*3 ? one_row_size.height*3:text_size.height;
        CGFloat text_width =  text_size.height >= one_row_size.height*3 ? kScreenWidth - marginLeft*2:text_size.width;
        _content_frame = CGRectMake(marginLeft, CGRectGetMaxY(_name_frame) + marginTop, text_width, text_height);
    }
    _chakan_frame = CGRectMake(kScreenWidth - marginRight - btnWidth - btnWidth - marginLeft, CGRectGetMaxY(_content_frame)+marginTop, btnWidth, btnHeight);
    _dele_frame = CGRectMake(CGRectGetMaxX(_chakan_frame)+marginLeft, _chakan_frame.origin.y, btnWidth, btnHeight);
    
    self.cellHeight = CGRectGetMaxY(_chakan_frame) + marginBottom;
}
@end
