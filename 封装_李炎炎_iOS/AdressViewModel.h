//
//  AdressViewModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/11.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnLineResponModel.h"

@interface AdressViewModel : NSObject

@property(nonatomic,strong)AddressModel *adressModel;
@property(nonatomic,assign)CGRect name_frame;
@property(nonatomic,assign)CGRect number_frame;
@property(nonatomic,assign)CGRect content_frame;
@property(nonatomic,assign)CGRect chakan_frame;
@property(nonatomic,assign)CGRect dele_frame;

/** 自定义属性 */
@property(nonatomic,assign)BOOL isExpand;

/** cell的高度 */
@property(nonatomic,assign)float cellHeight;
@end
