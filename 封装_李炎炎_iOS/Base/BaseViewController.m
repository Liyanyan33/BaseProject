//
//  BaseViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/26.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "MBHUD.h"

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
    /** 设置控制器View 的背景颜色 */
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNetWorkingView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatuChanged:) name:NetWorkingNotifyName object:nil];
}

#pragma mark 请求网络数据
- (void)requestData{

}

#pragma mark 搭建控制器View内部的子控件
- (void)createUI{
    
}

#pragma mark 监听网络变化的 回调
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

#pragma mark 无网络 情形的 横幅提示
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

#pragma mark 网络变化的 动画提示 (与上面的 横幅提示类似)
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

#pragma mark 监听导航栏 右侧按钮 点击的回调
- (void)navBarRightClick{

}

#pragma mark 监听导航栏 左侧按钮 点击的回调
- (void)navBarLeftClick{

}

#pragma mark 点击View的任意一点 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)showLoading{
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"loading";
}


- (void)hideLoading{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)showSuccess:(UIView*)view{
    if (view == nil){
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.label.text = @"成功";
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

- (void)showToast{
    [MBHUD showToast:self.view];
}
@end
