//
//  OnLineResponModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/10/20.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseResponseModel.h"

@interface OnLineResponModel : BaseResponseModel

@end

@interface OnLineModel : NSObject
@property(nonatomic,copy)NSString *imgURL;
@property(nonatomic,copy)NSString *mgsDesc;
@property(nonatomic,assign)int imgOrder;
@end

@interface AddressModel : NSObject
@property(nonatomic,copy)NSString *customerId;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,copy)NSString *detailAddress;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *lng;
@property(nonatomic,copy)NSString *lat;

/** 自定义属性 */
@property(nonatomic,assign)CGFloat normal_height;
@property(nonatomic,assign)CGFloat expand_height;
@property(nonatomic,assign)BOOL isExpand;

@end



