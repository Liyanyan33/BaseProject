//
//  WBUserModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBInsecurityModel.h"

/** 认证方式 枚举 */
typedef NS_ENUM(NSUInteger,WBUserVerifyType){
    WBUserVerifyTypeNone,     //没有认证
    WBUserVerifyTypeStandard,  // 个人认证  黄V
    WBUserVerifyTypeOrganization, // 官方认证  蓝V
    WBUserVerifyTypeClub,   //达人认证   红星
};




@interface WBUserModel : NSObject
@property(nonatomic,copy)NSString *allow_all_act_msg;
@property(nonatomic,copy)NSString *allow_all_comment;
@property(nonatomic,copy)NSString *avatar_hd;
@property(nonatomic,copy)NSString *avatar_large;   // 用户头像
@property(nonatomic,copy)NSString *bi_followers_count;
@property(nonatomic,copy)NSString *block_app;
@property(nonatomic,copy)NSString *block_word;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *user_class;
@property(nonatomic,copy)NSString *cover_image;
@property(nonatomic,copy)NSString *cover_image_phone;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *credit_score;
@property(nonatomic,copy)NSString *user_description;
@property(nonatomic,copy)NSString *domain;
@property(nonatomic,assign)int32_t favourites_count;
@property(nonatomic,copy)NSString *follow_me;
@property(nonatomic,assign)int32_t followers_count;
@property(nonatomic,copy)NSString *following;
@property(nonatomic,assign)int32_t friends_count;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *geo_enabled;
@property(nonatomic,copy)NSString *has_service_tel;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,strong)WBInsecurityModel *insecurity;
@property(nonatomic,copy)NSString *lang;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *mbrank;  //微博的VIP等级
@property(nonatomic,copy)NSString *mbtype;
@property(nonatomic,copy)NSString *name;     //用户姓名
@property(nonatomic,copy)NSString *online_status;
@property(nonatomic,assign)int32_t pagefriends_count;
@property(nonatomic,copy)NSString *profile_image_url;
@property(nonatomic,copy)NSString *profile_url;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *ptype;
@property(nonatomic,copy)NSString *remark;       // 用户姓名
@property(nonatomic,copy)NSString *screen_name;  //用户姓名
@property(nonatomic,copy)NSString *star;
@property(nonatomic,assign)int32_t statuses_count;
@property(nonatomic,copy)NSString *story_read_state;
@property(nonatomic,copy)NSString *urank;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *user_ability;
@property(nonatomic,copy)NSString *verified;
@property(nonatomic,copy)NSString *verified_contact_email;
@property(nonatomic,copy)NSString *verified_contact_mobile;
@property(nonatomic,copy)NSString *verified_contact_name;
@property(nonatomic,copy)NSString *verified_level;
@property(nonatomic,copy)NSString *verified_reason;
@property(nonatomic,copy)NSString *verified_reason_modified;
@property(nonatomic,copy)NSString *verified_reason_url;
@property(nonatomic,copy)NSString *verified_source;
@property(nonatomic,copy)NSString *verified_source_url;
@property(nonatomic,copy)NSString *verified_state;
@property(nonatomic,copy)NSString *verified_trade;
@property(nonatomic,copy)NSString *verified_type;  // 微博认证 
@property(nonatomic,copy)NSString *verified_type_ext;
@property(nonatomic,copy)NSString *weihao;

#pragma mark 自定义属性（通过自定义属性 对服务端返回的数据进行加工处理）
@property(nonatomic,copy)NSString *name_end;  //处理之后的用户姓名
@property (nonatomic, assign) WBUserVerifyType userVerifyType;

@end
