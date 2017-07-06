//
//  AuthController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "AuthController.h"
#import "AccoutModel.h"
#import "AccountDB.h"

#import "NewFeatureController.h"
#import "FriendController.h"

@interface AuthController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation AuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新浪微博的授权登陆页面";
    [self createUI];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)createUI{
    [self.view addSubview:self.webView];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [LYHud showAtView:self.view title:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [LYHud hideAtView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [LYHud hideAtView:self.view];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code{
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = XLAppKey;
    params[@"client_secret"] = XLAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = XLRedirectUR;
    params[@"code"] = code;
    
    // 2.发送请求
    [NetWorking POSTWithUrl:@"https://api.weibo.com/oauth2/access_token" paramas:params resultClass:[AccoutModel class] success:^(id json) {
        AccoutModel *aModel = json;
        NSLog(@"access_token = %@",aModel.access_token);
        // 账号数据缓存
        [AccountDB saveAccountModel:aModel];
        // 页面跳转
        [self switchRootViewController];
    } failure:^(id error) {
        
    }];
}

#pragma mark private methods
- (void)switchRootViewController{
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        FriendController *fc = [[FriendController alloc]init];
        [self.navigationController pushViewController:fc animated:YES];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        NewFeatureController *nfc = [[NewFeatureController alloc]init];
        [self.navigationController pushViewController:nfc animated:YES];
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark 懒加载
- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _webView.delegate = self;
        NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", XLAppKey, XLRedirectUR];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        
    }
    return _webView;
}
@end
