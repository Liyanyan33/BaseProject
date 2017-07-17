//
//  ZTETextView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  带有占位文字的UITextView

#import "ZTETextView.h"

@implementation ZTETextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /** 监听系统所发出的通知(UITextViewTextDidChangeNotification)  当textView有输入文字时 隐藏占位文字 */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification*)notification{
    // 重新绘制 调用drawRect方法
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    // 这里的rect是指 整个控件的设置的frame
    if (self.hasText) { // 如果存在输入文字 就不用绘制占位文字 直接返回即可
        return;
    }
    // UITextView 默认是存在 内容内边距的
    UIEdgeInsets insets = self.textContainerInset;
    // 定义文字属性
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc]init];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHolderColor?self.placeHolderColor:[UIColor grayColor];
    CGFloat x = insets.left + 5.0;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = insets.top;
    CGFloat h = rect.size.height - 2 * y;
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeHolder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    /** 重新绘制 */
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    /** 重新绘制 */
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    /** 重新绘制 */
    [self setNeedsDisplay];
}

@end
