//
//  FriendCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.

#import "FriendCell.h"
#import "WBStatuViewModel.h"
#import "PersonInfoView.h"
#import "OrginalStatuView.h"
#import "RetweetStatuView.h"

@interface FriendCell ()<WBBottomToolBarDataSource>
@property(nonatomic,strong)WBStatuViewModel *sViewModel;
@property(nonatomic,strong)PersonInfoView *personInfoView;  // 个人信息view（顶部）
@property(nonatomic,strong)OrginalStatuView *orginalStatuView;  //原创微博View
@property(nonatomic,strong)RetweetStatuView *retweetStatuView; //转发微博View
@property(nonatomic,strong)WBBottomToolBar *bottomToolBar; // 底部工具栏
@end

@implementation FriendCell

- (void)createUI{
    [self addSubview:self.personInfoView];
    [self addSubview:self.orginalStatuView];
    [self addSubview:self.bottomToolBar];
}

- (void)configCellWithViewModel:(id)viewModel indexPath:(NSIndexPath *)indexPath{
    _sViewModel = (WBStatuViewModel*)viewModel;
    
    _personInfoView.frame = _sViewModel.personInfoViewFrame;
    [_personInfoView configWithViewModel:_sViewModel];
    
    _orginalStatuView.frame = _sViewModel.orginalViewFrame;
    [_orginalStatuView configWithViewModel:_sViewModel];
    
    _bottomToolBar.frame = _sViewModel.bottomToolBarFrame;
}

#pragma mark  WBBottomToolBarDataSource
- (NSArray*)bottomToolBarForTextArr:(WBBottomToolBar *)bottomToolBar{
    return @[@"转发",@"分享",@"点赞"];
}

- (NSArray*)bottomToolBarForImageArr:(WBBottomToolBar *)bottomToolBar{
    return @[@"timeline_icon_comment",@"timeline_icon_retweet",@"timeline_icon_unlike"];
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

- (WBBottomToolBar*)bottomToolBar{
    __weak typeof (self) weakSelf = self;
    if (!_bottomToolBar) {
        _bottomToolBar = [[WBBottomToolBar alloc]init];
        _bottomToolBar.dataSource = self;
        _bottomToolBar.bottomToolBarClickBlock = ^(NSInteger tag){
            if (weakSelf.friendCellInBottomToolBarClick) {
                weakSelf.friendCellInBottomToolBarClick(tag);
            }
        };
        [_bottomToolBar reloadData];
    }
    return _bottomToolBar;
}
@end
