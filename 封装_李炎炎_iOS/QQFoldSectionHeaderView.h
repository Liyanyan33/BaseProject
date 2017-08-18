//
//  QQFoldSectionHeaderView.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/8/18.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlock)(void);

@interface QQFoldSectionHeaderView : UIView
@property(nonatomic,copy)tapBlock tapBlock;
- (void)configHeaderView:(id)model indexPath:(NSIndexPath*)indexPath;
@end
