//
//  VoiceCell.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/11/3.
//  Copyright © 2016年 ZXJK. All rights reserved.

#import "VoiceCell.h"
#import "CustomProgress.h"

@interface VoiceCell ()<CustomProgressDelegate>
@property(nonatomic,strong)CustomProgress *cProgress;
@end

@implementation VoiceCell

- (void)createUI{

    [self addSubview:self.cProgress];
}

#pragma mark 懒加载
- (CustomProgress*)cProgress{
    
    if (!_cProgress) {
        _cProgress = [[CustomProgress alloc]initWithFrame:CGRectMake(10, 10, 183, 50)];
        
        _cProgress.maxValue = 60;
        //设置背景色
        _cProgress.bgimg.backgroundColor =[UIColor colorWithRed:252/255.0 green:120/255.0 blue:121/255.0 alpha:1];
        _cProgress.leftimg.backgroundColor =[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:0.35];
        _cProgress.presentlab.textColor = [UIColor whiteColor];
        _cProgress.delegate = self;
    }
    return _cProgress;
}

-(void)setSdModel:(SoundModel *)sdModel{
    
    _sdModel = sdModel;
    _cProgress.sdmodel = sdModel;
}

#pragma mark -- 实现代理方法..
-(void)customProgressDidTapWithPlayState:(PlayState)state andWithUrl:(NSString *)urlString
{
    if ([self.delegate respondsToSelector:@selector(customProgressDidTapWithPlayState:andWithUrl:)]) {
        [self.delegate customProgressDidTapWithPlayState:state andWithUrl:urlString];
    }
}

@end
