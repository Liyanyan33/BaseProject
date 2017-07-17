//
//  ZTEEmojiTextView.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/7.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "ZTEEmojiTextView.h"
#import "ZTEAttachmentModel.h"

@implementation ZTEEmojiTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)insertEmotionModel:(ZTEEmotionModel *)emotionModel{
    if (emotionModel.code) { // 是emoji表情 (就是纯文字)
        [self insertText:emotionModel.code.emoji];
    }else if(emotionModel.png){ //图片表情  需要将图片转换成 NSTextAttachment对象 然后在 textView上显示出来
        // 根据图片名称 生成属性字符串
        NSAttributedString *attStr = [self createAttrStr:emotionModel];
        NSMutableAttributedString *textAttStr = [[NSMutableAttributedString alloc]init];
        // 拼接之前的 输入字符
        [textAttStr appendAttributedString:self.attributedText];
        // 获取当前的 光标位置
        NSUInteger currentLoc = self.selectedRange.location;
        // 在光标 位置 插入 用户刚刚输入的内容
        [textAttStr replaceCharactersInRange:self.selectedRange withAttributedString:attStr];
        // 设置字体
        [textAttStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttStr.length)];
        // 设置控件的文本
        self.attributedText = textAttStr;
        //  移动光标位置 至最末尾
        self.selectedRange = NSMakeRange(currentLoc+1, 0);
        [self insertText:@""];
    }
}

#pragma mark 根据图片名称 创建换一个 属性字符串
- (NSAttributedString*)createAttrStr:(ZTEEmotionModel*)emotionModel{
    // 创建一个附件对象
    ZTEAttachmentModel *textAttach = [[ZTEAttachmentModel alloc]init];
     // 附件中传入图片
    textAttach.emotionModel = emotionModel;
    // 设置附件的 尺寸
    CGFloat attachWH = self.font.lineHeight;
    textAttach.bounds = CGRectMake(0, -4, attachWH, attachWH);
    // 根据附件对象 创建一个 属性字符串
    NSAttributedString *attStr = [NSAttributedString attributedStringWithAttachment:textAttach];
    return attStr;
}

- (NSString *)fullText{
    NSMutableString *fullText = [NSMutableString string];
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        ZTEAttachmentModel *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片附件 >> 文本
            [fullText appendString:attch.emotionModel.chs];
        } else { // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}
@end
