//
//  ZTEPhotoBrowserCell.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/31.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTEPhotoBrowserCell : UIView

/** 可重用标识 */
@property(nonatomic,copy)NSString *reuseIdentifier;
/**  构造方法*/
- (instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier;
/** 数据配置 */
- (void)configCellWithDataModel:(id)dataModel;

@end
