//
//  BaseNavController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/19.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseNavController.h"
#import "BaseViewController.h"

@interface BaseNavController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavController

+(void)initialize{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 普通状态
    NSMutableDictionary *textAttrsNormal = [NSMutableDictionary dictionary];
    textAttrsNormal[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrsNormal[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrsNormal forState:UIControlStateNormal];
    // 不可用状态
    NSMutableDictionary *textAttrsDisabled = [NSMutableDictionary dictionary];
    textAttrsDisabled[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrsDisabled[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    [item setTitleTextAttributes:textAttrsDisabled forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark 添加滑动手势 返回上一级控制器功能 实现全屏侧滑
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
    // 设置代理
//    self.interactivePopGestureRecognizer.delegate = self;

}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
    if (self.viewControllers.count > 0) {
//         设置左边的箭头按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back:) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];

        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more:) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//     注意：只有非根控制器才有滑动返回功能，根控制器没有。
//     判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

/** 返回上一级视图控制器 */
- (void)back:(UIButton*)sender{
    BaseViewController *bvc = (BaseViewController*)[self.viewControllers lastObject];
    for (UIViewController *vc in self.viewControllers) {
        NSLog(@"vc = %@",vc);
    }
    [bvc navBarLeftClick];
    [self popViewControllerAnimated:YES];
}

- (void)more:(UIButton*)sender{
    // 获取导航控制器的栈顶控制器
    BaseViewController *bvc = (BaseViewController*)[self.viewControllers lastObject];
    [bvc navBarRightClick];
}
@end
