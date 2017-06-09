//
//  OnLineAdapter.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableAdapter.h"

typedef void (^ConfigCellBlock)(id cell, id model);
typedef void(^OnLineAdapterBtnBlock)(int index);

@interface OnLineAdapter : BaseTableAdapter

@property(nonatomic,copy)OnLineAdapterBtnBlock adapterBtnBlock;

@end
