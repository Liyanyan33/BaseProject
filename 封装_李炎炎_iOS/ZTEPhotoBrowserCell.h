//
//  ZTEPhotoBrowserCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 用户手指单击 */
typedef void(^cellSingleTapBlock)(void);
/** 用户手指双击 */
typedef void(^cellDoubleTapBlock)(void);

@interface ZTEPhotoBrowserCell : UIView
/** 可重用标识 */
@property(nonatomic,copy)NSString *reuseIdentifier;
/**  构造方法*/
- (instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier;
/** 数据配置 */
- (void)configCellWithDataModel:(id)dataModel;

@property(nonatomic,copy)cellSingleTapBlock cellSingleTapBlock;
@property(nonatomic,copy)cellDoubleTapBlock cellDoubleTapBlock;

@end
