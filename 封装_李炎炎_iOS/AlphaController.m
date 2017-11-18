//  AlphaController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/9/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AlphaController.h"
#import "iCarousel.h"

@interface AlphaController ()<UITableViewDataSource,UITableViewDelegate,iCarouselDataSource,iCarouselDelegate>
{
    UIView *topBarView;
    UIImageView *topAvatarView;    //顶部栏的头像
    UIImageView *avatarView;    //scrollview的头像
    
    UITableView *personalTableV;
    
     NSArray *photoList;     //照片数组
}
@end

@implementation AlphaController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (personalTableV) {
        personalTableV.delegate = self;
    }
    topBarView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    personalTableV.delegate = nil;
//    [self.navigationController.navigationBar lt_reset];
    topBarView.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnNavRight];
    [self initData];
    [self initUI];
}

- (void)initData{
    
    photoList = @[
                  @"bbc_tr_ht_b",
                  @"bbc_tr_jz_b",
                  @"bbc_tr_nsns_b",
                  @"bbc_tr_st_b",
                  @"bbc_tr_zt_b",
                  @"bbc_th_msry"
                  ];
}

- (void)addBtnNavRight{
    CGRect barRect = self.navigationController.navigationBar.bounds;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, barRect.size.height, barRect.size.height)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = barRect.size.height/2.0;
    [button setImage:[UIImage imageNamed:@"homepage_message_icon03"] forState:UIControlStateNormal];
    [button setBackgroundColor:RGBColor(101, 101, 101)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark private method
- (void)initUI{
    personalTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    personalTableV.delegate = self;
    personalTableV.dataSource = self;
    personalTableV.backgroundColor = [UIColor clearColor];
    personalTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:personalTableV];
    
    personalTableV.tableHeaderView = [self obtainHeaderView];
}

- (UIView *)obtainHeaderView{
    UIView *headerView = [[UIView alloc] init];
    CGFloat screenW = kScreenWidth;
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [headerView addSubview:bgImgView];
    
    CGFloat avatarW = screenW*250.0/1080.0;
    UIImage *img = [UIImage imageNamed:@"bbc_tr_nsns_b"];
    avatarView = [[UIImageView alloc] initWithFrame:CGRectMake((screenW-avatarW)/2.0, screenW*40.0/1080.0-44.0, avatarW, avatarW)];
    avatarView.image = img;
    topAvatarView.image = img;
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    avatarView.layer.masksToBounds = YES;
    avatarView.layer.cornerRadius = avatarW/2.0;
    avatarView.layer.borderWidth = 2.0;
    avatarView.layer.borderColor = RGBColor(45, 41, 40).CGColor;
    [headerView addSubview:avatarView];
    
    
    CGRect nameLFrame;
    NSString *nameStr = @"Mini";
    CGFloat baseFontSize = screenW*55.0/1080.0/1.2;
    CGFloat nameLW = [self TextWidth:nameStr Font:[UIFont systemFontOfSize:baseFontSize] Height:baseFontSize*1.2];
    CGFloat nameLMaxW = screenW - 2*screenW*140.0/1080.0;
    if (nameLW > nameLMaxW) {
        nameLFrame = CGRectMake(screenW*140.0/1080.0, avatarView.frame.origin.y+ avatarView.frame.size.height + screenW*40.0/1080.0, nameLMaxW, baseFontSize*1.2);
    }else{
        nameLFrame = CGRectMake((screenW-nameLW)/2.0, avatarView.frame.origin.y+ avatarView.frame.size.height + screenW*40.0/1080.0, nameLW, baseFontSize*1.2);
    }
    UILabel *nameL = [[UILabel alloc] initWithFrame:nameLFrame];
    nameL.font = [UIFont systemFontOfSize:baseFontSize];
    nameL.text = nameStr;
    nameL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:nameL];
    
    CGFloat sexVW = screenW*55.0/1080.0;
    CGRect sexVFrame = CGRectMake(nameLFrame.origin.x+nameLFrame.size.width, nameLFrame.origin.y+(nameLFrame.size.height-sexVW)/2.0, sexVW, sexVW);
    NSString *sexStr = @"1";
    UIImageView *sexV = [[UIImageView alloc] initWithFrame:sexVFrame];
    if ([sexStr intValue] == 1) {
        //女
        sexV.image = [UIImage imageNamed:@"sex_woman01"];
    }else if ([sexStr intValue] == 0){
        sexV.image = [UIImage imageNamed:@"sex_man01"];
    }
    [headerView addSubview:sexV];
    
    CGFloat smallFontSize = baseFontSize*50.0/55.0;
    CGRect schoolLFrame = CGRectMake(0, nameLFrame.origin.y+nameLFrame.size.height + screenW*40.0/1080.0, screenW, smallFontSize*1.2);
    UILabel *schoolL = [[UILabel alloc] initWithFrame:schoolLFrame];
    schoolL.text = @"南方医科大学顺德校区[广州]";
    schoolL.font = [UIFont systemFontOfSize:smallFontSize];
    schoolL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:schoolL];
    
    CGRect collegeLFrame = CGRectMake(0, schoolLFrame.origin.y+schoolLFrame.size.height, screenW, smallFontSize*1.2);
    UILabel *collegeL = [[UILabel alloc] initWithFrame:collegeLFrame];
    collegeL.text = @"经济管理学院";
    collegeL.font = [UIFont systemFontOfSize:smallFontSize];
    collegeL.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:collegeL];
    
    CGFloat leftPadding = screenW*30.0/1080.0;
    CGFloat userInfoBtnW = screenW*250.0/1080.0;
    CGFloat userInfoBtnH = screenW*60.0/1080.0;
    UIButton *userInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftPadding, collegeLFrame.origin.y+collegeLFrame.size.height, userInfoBtnW, userInfoBtnH)];
    [userInfoBtn setBackgroundColor:[UIColor clearColor]];
    [userInfoBtn.titleLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
    [userInfoBtn setTitle:@"TA的资料" forState:UIControlStateNormal];
    [userInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    userInfoBtn.layer.masksToBounds = YES;
    userInfoBtn.layer.cornerRadius = 5.0;
    userInfoBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    userInfoBtn.layer.borderWidth = 1.0;
    [headerView addSubview:userInfoBtn];
    
    CGFloat numberLW = screenW*180.0/1080.0;
    CGFloat numberLH = screenW*60.0/1080.0;
    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(screenW-leftPadding-numberLW, userInfoBtn.frame.origin.y+(userInfoBtnH-numberLH)/2.0, numberLW, numberLH)];
    numberL.text = @"12/20";
    numberL.textColor = [UIColor whiteColor];
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.font = [UIFont systemFontOfSize:screenW*45.0/1080.0/1.2];
    numberL.backgroundColor = RGBColor(101, 101, 101);
    numberL.layer.masksToBounds = YES;
    numberL.layer.cornerRadius = 10.0;
    [headerView addSubview:numberL];
    
    CGRect bgImgViewFrame = CGRectMake(0, -64.0, screenW, userInfoBtn.frame.origin.y+userInfoBtn.frame.size.height+screenW*20.0/1080.0+64.0);
    bgImgView.frame = bgImgViewFrame;
    
    //异步模糊
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *fuzzyImg = [img blurring];
        dispatch_async(dispatch_get_main_queue(), ^{
            bgImgView.image = fuzzyImg;
        });
    });
    
    CGFloat photoSelectVH = screenW*280.0/1080.0;
    iCarousel *photoSelectV = [[iCarousel alloc] initWithFrame:CGRectMake(0, bgImgViewFrame.origin.y+bgImgViewFrame.size.height, screenW, photoSelectVH)];
    photoSelectV.backgroundColor = RGBColor(119, 115, 115);
    photoSelectV.delegate = self;
    photoSelectV.dataSource = self;
    photoSelectV.type = iCarouselTypeLinear;
    [photoSelectV reloadData];
    [headerView addSubview:photoSelectV];
    headerView.frame = CGRectMake(0, 0, screenW, photoSelectV.frame.origin.y+photoSelectV.frame.size.height);
    return headerView;
}

#pragma mark - 通用方法
- (CGFloat)TextWidth:(NSString *)str2 Font:(UIFont *)font Height:(CGFloat)height{
    NSString *str=[NSString stringWithFormat:@"%@",str2];
    CGSize constraint = CGSizeMake(MAXFLOAT, height);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    return size.width;
}

#pragma mark 监听事件回调

#pragma mark 代理回调
# pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

# pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    return cell;
}

#pragma mark - iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return photoList.count;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    CGFloat screenW = kScreenWidth;
    UIImageView *imgView = nil;
    if (view == nil){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW/4.0, screenW*280.0/1080.0)];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-screenW*260.0/1080.0)/2.0, screenW*10.0/1080.0, screenW*260.0/1080.0, screenW*260.0/1080.0)];
        imgView.tag = 2001;
        [view addSubview:imgView];
    }else{
        imgView = (UIImageView *)[view viewWithTag:2001];
    }
    imgView.image = [UIImage imageNamed:[photoList objectAtIndex:index]];
    return view;
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value;
        }
        case iCarouselOptionFadeMax:
        {
            return 0.0f;
        }
        case iCarouselOptionShowBackfaces:
        {
            return YES;
        }
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return 5;
        }
    }
    //return value;
}

#pragma mark setter getter

@end
