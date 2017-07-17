//
//  ZTEEmojiPageView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/7/5.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  ZTEEmojiModuleView 模块view中滚动视图的 pageView (分页 滚动显示)

#import <UIKit/UIKit.h>
#import "ZTEEmojiButton.h"

/** 表情按钮点击 回调 */
typedef void(^emojiBtnClick)(ZTEEmotionModel *emojiModel);
/** 删除按钮点击 回调 */
typedef void(^deleteBtnClick)(void);

// 一页中最多3行
#define ZTEEmotionMaxRows 3
// 一行中最多7列
#define ZTEEmotionMaxCols 7
// 每一页的表情个数
#define ZTEEmotionPageSize ((ZTEEmotionMaxRows * ZTEEmotionMaxCols) - 1)

@interface ZTEEmojiPageView : UIView

@property(nonatomic,strong)NSArray *emojiArr;
@property(nonatomic,copy)emojiBtnClick emojiBtnClick;
@property(nonatomic,copy)deleteBtnClick deleteBtnClick;
@end
