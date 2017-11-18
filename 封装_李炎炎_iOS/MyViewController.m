
//
//  MyViewController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "MyViewController.h"
#import "WBTextPartModel.h"
#import "WBStatuHelper.h"

@interface MyViewController ()<UIWebViewDelegate>
@property(nonatomic,copy)NSString *htmlStr;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIWebView *webView_one;
@property(nonatomic,strong)UILabel *txtLabel;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView富文本显示";
    [self loadTextDetail];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.webView_one];
    [self.view addSubview:self.txtLabel];
    
    NSString *txt_one = @"#18\u6761\u7ecf\u5178\u5fc3\u7406\u5b66\u5b9a\u5f8b##\u597d\u542c\u7684\u6b4c\u66f2\u63a8\u8350# @\u7535\u5546\u5927\u65b0\u95fb @\u521b\u6295\u667a\u5e93 [\u563b\u563b]\u5357\u4eac\u96e8\u82b1\u7ecf\u6d4e\u7684[\u60b2\u4f24] \u200b";
    NSAttributedString *atts = [WBStatuHelper createAttrbutesStringIWithText:txt_one];
    self.txtLabel.attributedText = atts;
}

- (void)navBarRightClick{
    [self showToast];
}

- (void)loadTextDetail{
    NSMutableDictionary *keyAndValueDictionary = [[NSMutableDictionary alloc] init];
    [NetWorking POSTWithUrl:@"http://jdcl-app-test.ztehealth.com/health/BaseData/queryAssistiveDevicesIntroduce" paramas:keyAndValueDictionary resultClass:nil success:^(id json) {
        self.htmlStr = json[@"data"][@"target"];
        [self.webView loadHTMLString:self.htmlStr baseURL:nil];
        [self.webView_one loadHTMLString:json[@"data"][@"introduce"] baseURL:nil];
    } failure:^(id error) {
        
    }];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    //方法一： 当webView加载完毕之后 再调用JS代码 计算webView的高度
    CGFloat documentHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    webView.height = documentHeight;
}

#pragma mark 懒加载
- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 0)];
        _webView.backgroundColor = [UIColor greenColor];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIWebView*)webView_one{
    if (!_webView_one) {
        _webView_one = [[UIWebView alloc]initWithFrame:CGRectMake(0, 320, kScreenWidth, 0)];
        _webView_one.delegate = self;
    }
    return _webView_one;
}

- (UILabel*)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight - 20 - 50, kScreenWidth - 20, 50)];
        _txtLabel.numberOfLines = 0;
    }
    return _txtLabel;
}

@end
