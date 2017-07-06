//
//  WBStatuViewModel.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  微博模型的 viewModel

#import "WBStatuViewModel.h"
#import "ZTEJGGView.h"

#define personInfoViewH 60
#define avatarIconW 40
#define avatarIconMarginLeft 10
#define avatarIconMarginTop 10

#define nameLabelMarginLeft 7
#define nameLabelH 20

#define badgeIconW 14
#define badgeIconMarginLeft 2

#define sourceLabelMarginTop 4

@interface WBStatuModel ()

@end

@implementation WBStatuViewModel

- (instancetype)initWithStatuModel:(WBStatuModel *)statuModel{
    _statuModel = statuModel;
    self = [super init];
    if (self) {
        [self calFrame];
    }
    return self;
}

// 计算 各种不同控件的布局
- (void)calFrame{
    // 个人信息view 模块
    _personInfoViewFrame = CGRectMake(0, 0, kScreenWidth, personInfoViewH);
    // 用户头像
    _avatarIconFrame = CGRectMake(avatarIconMarginLeft, avatarIconMarginTop, avatarIconW, avatarIconW);
    // 用户姓名
    WBUserModel *user = _statuModel.user;
    CGSize nameSize = [NSString getBoundSizeWithText:user.name_end font:[UIFont systemFontOfSize:16]];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_avatarIconFrame)+nameLabelMarginLeft, _avatarIconFrame.origin.y, nameSize.width, nameSize.height);
    // 徽章
    _badgeIconFrame = CGRectMake(CGRectGetMaxX(_nameLabelFrame)+badgeIconMarginLeft, CGRectGetMaxY(_nameLabelFrame)-nameSize.height/2-badgeIconW/2, badgeIconW, badgeIconW);
    // 来源
    NSString *completeSource = [NSString stringWithFormat:@"%@%@",_statuModel.created_at,_statuModel.source];
    CGSize sourceSize = [NSString getBoundSizeWithText:completeSource font:[UIFont systemFontOfSize:12]];
    _sourceLabelFrame = CGRectMake(_nameLabelFrame.origin.x, CGRectGetMaxY(_nameLabelFrame)+sourceLabelMarginTop, sourceSize.width, sourceSize.height);
    _personInfoViewHeight = personInfoViewH;
    
    // 原创微博模块
    // 文本内容
    NSAttributedString *orginalAtts = _statuModel.orginalAttrStr;
    CGSize attStrSize = [orginalAtts boundingRectWithSize:CGSizeMake(kScreenWidth - 10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    _orginalTxtFrame = CGRectMake(10, 2, kScreenWidth - 20, attStrSize.height);
    
    // 九宫格图片
    NSArray *pic_urls = _statuModel.pic_urls;
    CGSize jggSize = [ZTEJGGView sizeWithCount:pic_urls.count];
    _orginalJGGFrame = CGRectMake(0, CGRectGetMaxY(_orginalTxtFrame), kScreenWidth, jggSize.height);
    
    _orginalViewHeight = attStrSize.height + 2*2 + jggSize.height;
    _orginalViewFrame = CGRectMake(0, personInfoViewH, kScreenWidth-10*2, _orginalViewHeight);
    
    // 整个cell的高度
    _cellHeight = _personInfoViewHeight + _orginalViewHeight;
}
@end
