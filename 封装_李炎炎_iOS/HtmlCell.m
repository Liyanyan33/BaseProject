//
//  HtmlCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/25.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import "HtmlCell.h"

#define labelMarginLeft 10
#define labelMarginTop 10
#define labelMarginBottom 10


@interface HtmlCell ()<UIWebViewDelegate>
@property(nonatomic,strong)UILabel *htmlLabel;
@end

@implementation HtmlCell

- (void)createUI{
    [self addSubview:self.htmlLabel];
}

- (void)configCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath{
    // 将html字符串 转换成 富文本
    NSMutableAttributedString *attStr=  [[NSMutableAttributedString alloc] initWithData:[model dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:NSMakeRange(0, attStr.length)];
    self.htmlLabel.attributedText = attStr;
    
    CGSize attStrSize = [attStr boundingRectWithSize:CGSizeMake(kScreenWidth - labelMarginLeft*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    self.htmlLabel.frame = CGRectMake(labelMarginLeft, labelMarginTop, kScreenWidth - labelMarginLeft*2,attStrSize.height);
}

+ (CGFloat)calCellHeightWithModel:(id)modelData{
    CGFloat cellHeight = 0;
    cellHeight+=labelMarginTop;
    NSMutableAttributedString *attStr=  [[NSMutableAttributedString alloc] initWithData:[modelData dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:NSMakeRange(0, attStr.length)];
    
    CGSize attStrSize = [attStr boundingRectWithSize:CGSizeMake(kScreenWidth - labelMarginLeft*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    cellHeight+=attStrSize.height;
    cellHeight+=labelMarginBottom;
    return cellHeight;
}

#pragma mark 懒加载
- (UILabel*)htmlLabel{
    if (!_htmlLabel) {
        _htmlLabel = [[UILabel alloc]init];
        _htmlLabel.numberOfLines = 0;
        _htmlLabel.font = [UIFont boldSystemFontOfSize:16];
        _htmlLabel.backgroundColor = [UIColor redColor];
    }
    return _htmlLabel;
}
@end
