//
//  LYActionSheet.h
//  自定义Sheet
//
//  Created by lyy on 17/3/2.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cellClickBlock)(NSString *txt,NSInteger row);
typedef void(^disAppeared)(void);
typedef void(^appeared)(void);

@interface ZTEActionSheet : UIView
@property(nonatomic,copy)cellClickBlock cellClickBlock;
@property(nonatomic,copy)disAppeared disAppearBlock;
@property(nonatomic,copy)appeared appearBlock;

- (ZTEActionSheet*)initWithButtonsArray:(NSArray*)btnArray;
- (instancetype)initWithFrame:(CGRect)frame withButtonsArr:(NSArray*)btnArr;
- (instancetype)initWithButtonsArr:(NSArray*)btnArr;

- (void)show;  // 显示
- (void)dismiss; // 去除
@end
