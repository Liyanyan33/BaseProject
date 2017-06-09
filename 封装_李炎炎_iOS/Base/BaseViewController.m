//
//  BaseViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/26.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#define KCOLOR_PINK [UIColor colorWithRed:171.0/250 green:9.0/250  blue:85.0/250  alpha:1]
@interface BaseViewController ()
{
    UIView *_viewAl;
    UILabel *_labelTi;
}

@property(nonatomic,strong)UIView *netView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNetWorkingView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatuChanged:) name:NetWorkingNotifyName object:nil];
}

- (void)networkStatuChanged:(NSNotification*)notification{
    
    NSString *string = notification.userInfo[NetWorkingStatu];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if ([string isEqualToString:@"AFNetworkReachabilityStatusNotReachable"]) {
        LYLog(@"没有网络");
        /** 弹出横幅 向用户传达 当前网络不可用 */
//        [self showAlert:@"当前没有网络，请检查网络配置"];
        params[NetWorkingStatu] = @"noNet";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkingStatu" object:nil userInfo:params];
        
    }else if ([string isEqualToString:@"AFNetworkReachabilityStatusReachableViaWiFi"]||[string isEqualToString:@"AFNetworkReachabilityStatusReachableViaWWAN"]){
        
        LYLog(@"存在网络");
        /** 判断当前横幅是否存在 是 ->直接移除  否-> return  */
//        [self showAlert:@"wifi网络下"];
         params[NetWorkingStatu] = @"yesNet";
         [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkingStatu" object:nil userInfo:params];
    }else {
        LYLog(@"未知网络");
    }
}


- (void)createNetWorkingView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 50)];
    view.backgroundColor = RGBColor(224, 196, 77);
    _netView = view;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"messageSendFailed@2x.png"]];
    imageView.x = 50;
    imageView.y = 10;
    [view addSubview:imageView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 5, 240, 35)];
    title.text = @"当前没有网络，请检查网络配置";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor blackColor];
    [view addSubview:title];
    [self.view addSubview:view];
    _netView.hidden = YES;
}

- (UIView*)getNetView{
    return _netView;
}

-(void)showAlert:(NSString *)str{
    
    _viewAl =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    _viewAl.alpha=0.8;
    _viewAl.backgroundColor =KCOLOR_PINK;
    _labelTi =[[UILabel alloc]initWithFrame:_viewAl.bounds];
    _labelTi.text=str;
    _labelTi.font=[UIFont systemFontOfSize:14];
    _labelTi.textColor=[UIColor whiteColor];
    _labelTi.textAlignment=NSTextAlignmentCenter;
    [_viewAl addSubview:_labelTi];
    
    [UIView animateWithDuration:2.0 animations:^{
        _viewAl.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        _labelTi.frame=_viewAl.bounds;
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.0 animations:^{
            [NSThread sleepForTimeInterval:2];
            _viewAl.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
            _labelTi.frame=_viewAl.bounds;
        } completion:^(BOOL finished) {
            [_viewAl removeFromSuperview];
        }];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_viewAl];
}

- (void)navBarRightClick{

    
}

- (void)navBarLeftClick{

}

#pragma mark 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
