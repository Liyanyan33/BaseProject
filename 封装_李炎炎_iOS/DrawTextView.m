//
//  DrawTextView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/31.
//  Copyright © 2017年 ZXJK. All rights reserved.

#import "DrawTextView.h"

@implementation DrawTextView

- (void)drawRect:(CGRect)rect{
    // 控件的宽度与高度
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    // 定义初始化要绘制的文字与图片
    NSString *txt = @"谁能书阁下,白首太玄经,千秋二壮士,恒赫大梁城,人生自古谁无死,留取丹青照汗青";
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    
    // 获取当前的图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
#pragma mark  CoreText坐标系是以左下角为坐标原点，而我们常使用的UIKit是以左上角为坐标原点，因此在CoreText中的布局完成后需要对其坐标系进行转换，否则直接绘制出现位置反转的镜像情况。在通常情况下我们一般做法是直接获取当前上下文。并将当前上下文的坐标系转换为CoreText坐标系，再将布局好的CoreText绘制到当前上下文中即可
    // 设置当前文本矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // 文本沿着Y轴移动
    CGContextTranslateCTM(context, 0, height);
    
    // 将文本翻转成为CoreText坐标系
    CGContextScaleCTM(context, 1, -1);
    
    // 创建绘制的区域大小
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(10, 15, width - 10*2, height - 15*2));
    
    // 根据普通文字 生成属性字符串
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:txt];
    
#pragma mark 设置文本的属性
    // 设置部分文字的颜色
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 10)];
    
    // 设置部分文字的字体
    CGFloat fontSize = 20;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, 10)];
    
    // 设置斜体
    CTFontRef italicFontRef = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 16, NULL);
    [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)italicFontRef range:NSMakeRange(0, 15)];
    
    // 设置下划线
    [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInteger:kCTUnderlineStyleDouble] range:NSMakeRange(5, 6)];
    
    // 设置下划线颜色
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5, 5)];
    
    // 设置空心字
    long number_one = 2;
    CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number_one);
    [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)numRef range:NSMakeRange(3, 7)];
    
    //设置字体间距
    long number_two = 10;
    CFNumberRef numRef_two = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number_two);
    [attString addAttribute:(id)kCTKernAttributeName value:(__bridge id)numRef_two range:NSMakeRange(3, 8)];
    
    // 设置行间距
    CGFloat lineSpacing = 10;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting  psSetting[kNumberOfSettings] = {{kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &lineSpacing}};
    CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(psSetting, kNumberOfSettings);
    [attString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)paragraphStyleRef range:NSMakeRange(0, attString.length)];
    
    // 设置回调结构体
    CTRunDelegateCallbacks callBacks;
    // 开辟内存空间
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    // 设置回调版本
    callBacks.version = kCTRunDelegateVersion1;
    // 设置图片顶部 距离 基线的距离
    callBacks.getAscent = ascentCallBacks;
    // 设置图片的底部 距离 基线的距离
    callBacks.getDescent = descentCallBacks;
    // 设置图片的宽度
    callBacks.getWidth = widthCallBacks;
    // 创建一个图片尺寸的字典
    NSDictionary *imageDic = @{@"height":@"20",@"width":@"50"};
    // 创建一个 CTRunDelegate对象
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callBacks, (__bridge void*)imageDic);
    // 创建一个空白占位符 这个占位符就是coreText绘制图片而 创建的
    unichar placeHolderChar = 0xFFFC;
    // 根据空白占位符生成字符串
    NSString *placeHolderStr = [NSString stringWithCharacters:&placeHolderChar length:1];
    // 将生成的字符串 转换成属性字符串
    NSMutableAttributedString *placeHolderAttStr = [[NSMutableAttributedString alloc]initWithString:placeHolderStr];
    // 将生成的占位属性字符串 绑定代理对象
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, runDelegate);
    // 释放内存
    CFRelease(runDelegate);
    // 将生成的占位符属性字符串 插入到 富文本中
    [attString appendAttributedString:placeHolderAttStr];

#pragma mark 以上是生成 富文本(包括文字和图片) 紧接着我们要进行绘制的工作
    // 绘制文本文字
    // 根据富文本创建CTFrameSetter
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    // 创建frame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, NULL);
    // 根据frame绘制文字
    CTFrameDraw(frame, context);
    
    // 绘制图片
#pragma mark 在CoreText中所有的布局都是基于行(CTLineRef)来进行的，每行都是一个CTLineRef对象，在每行当中又包含多个属性(CTRunRef)每行的属性可设置代理
    // 获取CTLine数组
    NSArray *lines = (NSArray*)CTFrameGetLines(frame);
    NSInteger lineCount = lines.count;
    // 创建每一行的 起点数组
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    // 遍历每一个CTLine
    for (NSInteger i = 0; i < lineCount; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        // 获取一个CTLine中所包含的CTRunRef
        NSArray *runObjArr = (NSArray*)CTLineGetGlyphRuns(line);
        // 遍历CTLine中的每一个CTRun片段
        for (id runObj in runObjArr) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttr = (NSDictionary*)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttr valueForKey:(id)kCTRunDelegateAttributeName];
            if (!delegate) { // 过滤作用 只有那些 图片占位符才绑定了 CTRunDelegate (在这里区分文本与图片)
                continue;
            }
            NSDictionary *metaDic = CTRunDelegateGetRefCon(delegate);
            if (!metaDic) {
                continue;
            }
            // 找到代理之后开始计算空白字符的位置
            CGRect runBounds; //CTRun片段的边框尺寸
#pragma mark 上行高度(Ascent)和下行高度(Decent)：一个字形最高点和最低点到基线的距离，前者为正数，而后者为负数
            CGFloat ascent;
            CGFloat descent;
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            // 计算在行当中的x的偏移量
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y - descent;
            // 获取CTFrame的绘制区域
            CGPathRef pathRef = CTFrameGetPath(frame);
            // 计算此绘制区域的范围
            CGRect rect = CGPathGetBoundingBox(pathRef);
            // 计算在此区域中空白字符的位置
            CGRect imageBounds = CGRectOffset(runBounds, rect.origin.x, rect.origin.y);
            // 绘制图片
            CGContextDrawImage(context, imageBounds, image.CGImage);
        }
    }
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

static CGFloat ascentCallBacks(void *ref){
    return [[(__bridge NSDictionary*) ref valueForKey:@"height"] floatValue];
}

static CGFloat descentCallBacks(void *ref){
    return 0;
}

static CGFloat widthCallBacks(void *ref){
    return [[(__bridge NSDictionary*) ref valueForKey:@"width"] floatValue];
}
@end
