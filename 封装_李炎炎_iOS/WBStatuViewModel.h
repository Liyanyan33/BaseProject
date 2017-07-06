//
//  WBStatuViewModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/3.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBStatuModel.h"

@interface WBStatuViewModel : NSObject

- (instancetype)initWithStatuModel:(WBStatuModel*)statuModel;

@property (nonatomic, strong) WBStatuModel *statuModel;

#pragma mark 用户信息相关
@property(nonatomic,assign)CGRect personInfoViewFrame;
@property(nonatomic,assign)CGRect avatarIconFrame;
@property(nonatomic,assign)CGRect nameLabelFrame;
@property(nonatomic,assign)CGRect badgeIconFrame;
@property(nonatomic,assign)CGRect sourceLabelFrame;
@property(nonatomic,assign)CGFloat personInfoViewHeight;

#pragma mark 原创微博View
@property(nonatomic,assign)CGRect orginalViewFrame;
@property(nonatomic,assign)CGRect orginalTxtFrame;
@property(nonatomic,assign)CGRect orginalJGGFrame;
@property(nonatomic,assign)CGFloat orginalViewHeight;

#pragma mark cell高度
@property(nonatomic,assign)CGFloat cellHeight;

@end
