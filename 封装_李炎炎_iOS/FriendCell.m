//
//  FriendCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "FriendCell.h"
#import "WBStatuViewModel.h"
#import "PersonInfoView.h"
#import "OrginalStatuView.h"
#import "RetweetStatuView.h"

@interface FriendCell ()
@property(nonatomic,strong)WBStatuViewModel *sViewModel;
@property(nonatomic,strong)PersonInfoView *personInfoView;  // 个人信息view（顶部）
@property(nonatomic,strong)OrginalStatuView *orginalStatuView;  //原创微博View
@property(nonatomic,strong)RetweetStatuView *retweetStatuView; //转发微博View
@end

@implementation FriendCell

- (void)createUI{
    [self addSubview:self.personInfoView];
    [self addSubview:self.orginalStatuView];
//    [self addSubview:self.retweetStatuView];
}

- (void)configCellWithViewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath{
    _sViewModel = (WBStatuViewModel*)viewModel;
    
    _personInfoView.frame = _sViewModel.personInfoViewFrame;
    [_personInfoView configWithViewModel:_sViewModel];
    
    _orginalStatuView.frame = _sViewModel.orginalViewFrame;
    [_orginalStatuView configWithViewModel:_sViewModel];
}

#pragma mark 懒加载
- (PersonInfoView*)personInfoView{
    if (!_personInfoView) {
        _personInfoView = [[PersonInfoView alloc]init];
    }
    return _personInfoView;
}

- (OrginalStatuView*)orginalStatuView{
    if (!_orginalStatuView) {
        _orginalStatuView = [[OrginalStatuView alloc]init];
    }
    return _orginalStatuView;
}
@end
