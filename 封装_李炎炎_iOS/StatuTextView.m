//
//  StatuTextView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  用来显示微博内容控件 由于需要加入文本的高亮显示与点击事件 我们需要知道 点击触摸文本的位置location
//  用UILabel控件不能 获取文本触摸的位置 只能使用UITextView控件来实现 

#import "StatuTextView.h"

#define HWStatusTextViewCoverTag 999

@implementation StatuTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;  // 禁止编辑
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动, 让文字完全显示出来
        self.scrollEnabled = NO; // 禁止滚动
    }
    return self;
}

// 开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 获取触摸对象
    UITouch *touch = [touches anyObject];
    // 获取触摸点位置坐标
    CGPoint location = [touch locationInView:self];
    // 初始化矩形框
    [self setupSpecialRects];
    // 根据触摸点 获取被触摸的 特殊字符串
    WBSpecailModel *specailModel = [self touchingSpecialWithPoint:location];
    
    // 在被触摸的特殊字符串后面显示一段高亮的背景
    for (NSValue *rectValue in specailModel.rects) {
        // 在被触摸的特殊字符串后面显示一段高亮的背景
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor greenColor];
        cover.frame = rectValue.CGRectValue;
        cover.tag = HWStatusTextViewCoverTag;
        cover.layer.cornerRadius = 5;
        [self insertSubview:cover atIndex:0];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews) {
        if (child.tag == HWStatusTextViewCoverTag) [child removeFromSuperview];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)setupSpecialRects{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (WBSpecailModel *special in specials) {
        self.selectedRange = special.range;
        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            // 添加rect
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }
}

/**
 找出被触摸的特殊字符串
 */
- (WBSpecailModel *)touchingSpecialWithPoint:(CGPoint)point{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (WBSpecailModel *special in specials) {
        for (NSValue *rectValue in special.rects) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) { // 点中了某个特殊字符串
                return special;
            }
        }
    }
    return nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    // 初始化矩形框
    [self setupSpecialRects];
    // 根据触摸点获得被触摸的特殊字符串
    WBSpecailModel *special = [self touchingSpecialWithPoint:point];
    if (special) {
        return YES;
    } else {
        return NO;
    }
}
@end
