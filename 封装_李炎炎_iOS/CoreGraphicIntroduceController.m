//
//  CoreGraphicIntroduceController.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/29.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "CoreGraphicIntroduceController.h"
#import "MainDrawController.h"

@interface CoreGraphicIntroduceController ()
@property(nonatomic,strong)UIButton *bottomBtn;
@end

@implementation CoreGraphicIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"两大绘图框架介绍";
    self.textView.height -= 40;
    self.text = @"UIKit像UIImage、NSString（绘制文本）、UIBezierPath（绘制形状）、UIColor都知道如何绘制自己。这些类提供了功能有限但使用方便的方法来让我们完成绘图任务。一般情况下，UIKit就是我们所需要的。使用UiKit，你只能在当前上下文中绘图，所以如果你当前处于UIGraphicsBeginImageContextWithOptions函数或drawRect：方法中，你就可以直接使用UIKit提供的方法进行绘图。如果你持有一个context：参数，那么使用UIKit提供的方法之前，必须将该上下文参数转化为当前上下文。幸运的是，调用UIGraphicsPushContext 函数可以方便的将context：参数转化为当前上下文，记住最后别忘了调用UIGraphicsPopContext函数恢复上下文环境。\n\nCore Graphics 这是一个绘图专用的API族，它经常被称为QuartZ或QuartZ 2D。Core Graphics是iOS上所有绘图功能的基石，包括UIKit。使用Core Graphics之前需要指定一个用于绘图的图形上下文（CGContextRef），这个图形上下文会在每个绘图函数中都会被用到。如果你持有一个图形上下文context：参数，那么你等同于有了一个图形上下文，这个上下文也许就是你需要用来绘图的那个。如果你当前处于UIGraphicsBeginImageContextWithOptions函数或drawRect：方法中，并没有引用一个上下文。为了使用Core Graphics，你可以调用UIGraphicsGetCurrentContext函数获得当前的图形上下文。\n\n获取图形上下文的方法：\n 1>第一种方法就是创建一个图片类型的上下文。调用UIGraphicsBeginImageContextWithOptions函数就可获得用来处理图片的图形上下文。利用该上下文，你就可以在其上进行绘图，并生成图片。调用UIGraphicsGetImageFromCurrentImageContext函数可从当前上下文中获取一个UIImage对象。记住在你所有的绘图操作后别忘了调用UIGraphicsEndImageContext函数关闭图形上下文。\n第二种方法是利用cocoa为你生成的图形上下文。当你子类化了一个UIView并实现了自己的drawRect：方法后，一旦drawRect：方法被调用，Cocoa就会为你创建一个图形上下文，此时你对图形上下文的所有绘图操作都会显示在UIView上。\n\n至此，我们有了两大绘图框架的支持以及三种获得图形上下文的方法（drawRect:、drawRect: inContext:、UIGraphicsBeginImageContextWithOptions）。那么我们就有6种绘图的形式。如果你有些困惑了，不用怕，我接下来将说明这6种情况。无需担心还没有具体的绘图命令，你只需关注上下文如何被创建以及我们是在使用UIKit还是Core Graphics.\n\n 重要的函数解析\n 1> CGContextSaveGState \n当你在图形上下文中绘图时，当前图形上下文的相关属性设置将决定绘图的行为与外观。因此，绘图的一般过程是先设定好图形上下文参数，然后绘图。比方说，要画一根红线，接着画一根蓝线。那么首先需要将上下文的线条颜色属性设定为为红色，然后画红线；接着设置上下文的线条颜色属性为蓝色，再画出蓝线。表面上看,红线和蓝线是分开的，但事实上，在你画每一条线时，线条颜色却是整个上下文的属性。无论你用的是UIKit方法还是Core Graphics函数。 因为图形上下文在每一时刻都有一个确定的状态，该状态概括了图形上下文所有属性的设置。为了便于操作这些状态，图形上下文提供了一个用来持有状态的栈。调用CGContextSaveGState函数，上下文会将完整的当前状态压入栈顶；调用CGContextRestoreGState函数，上下文查找处在栈顶的状态，并设置当前上下文状态为栈顶状态。 因此一般绘图模式是：在绘图之前调用CGContextSaveGState函数保存当前状态，接着根据需要设置某些上下文状态，然后绘图，最后调用CGContextRestoreGState函数将当前状态恢复到绘图之前的状态。要注意的是，CGContextSaveGState函数和CGContextRestoreGState函数必须成对出现，否则绘图很可能出现意想不到的错误，这里有一个简单的做法避免这种情况";
}

- (void)createUI{
    [self.view addSubview:self.bottomBtn];
}

- (void)click:(UIButton*)sender{
    [self.navigationController pushViewController:[[MainDrawController alloc]init] animated:YES];
}

#pragma mak 懒加载
- (UIButton*)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenHeight - 35, kScreenWidth - 40, 30)];
        [_bottomBtn setTitle:@"展示6种不同的绘图形式" forState:(UIControlStateNormal)];
        [_bottomBtn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
        [_bottomBtn setCornerRadius:5.0 borderW:1.0 borderCorlor:[UIColor redColor]];
        [_bottomBtn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bottomBtn setBackgroundImage:[UIImage imageWithCustomerColor:[UIColor blackColor]] forState:(UIControlStateNormal)];
    }
    return _bottomBtn;
}

@end
