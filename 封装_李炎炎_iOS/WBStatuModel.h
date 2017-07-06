//
//  WBStatuModel.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 17/6/22.
//  Copyright © 2017年 ZXJK. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "WBUserModel.h"
#import "WBVisibleModel.h"
#import "ZTEPhotoModel.h"

@interface WBStatuModel : NSObject
@property(nonatomic,strong)NSArray *annotations;
@property(nonatomic,assign)int32_t attitudes_count;
@property(nonatomic,copy)NSString *biz_feature;
@property(nonatomic,copy)NSString *bmiddle_pic;
@property(nonatomic,assign)int32_t comments_count;
@property(nonatomic,copy)NSString *created_at;  // 微博的发布创建时间
@property(nonatomic,strong)NSArray *darwin_tags;
@property(nonatomic,assign)BOOL favorited;
@property(nonatomic,copy)NSString *geo;
@property(nonatomic,copy)NSString *gif_ids;
@property(nonatomic,assign)int32_t hasActionTypeCard;
@property(nonatomic,strong)NSArray *hot_weibo_tags;
@property(nonatomic,copy)NSString *statuID;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *in_reply_to_screen_name;
@property(nonatomic,copy)NSString *in_reply_to_status_id;
@property(nonatomic,copy)NSString *in_reply_to_user_id;
@property(nonatomic,copy)NSString *isLongText;
@property(nonatomic,copy)NSString *is_show_bulletin;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,assign)int32_t mlevel;
@property(nonatomic,copy)NSString *original_pic;
@property(nonatomic,strong)NSArray<ZTEPhotoModel*> *pic_urls;   // 微博的配图(多张图片)
@property(nonatomic,copy)NSString *positive_recom_flag;
@property(nonatomic,assign)int32_t reposts_count;
@property(nonatomic,copy)NSString *rid;
@property(nonatomic,strong)WBStatuModel *retweeted_status; //被转发的微博
@property(nonatomic,copy)NSString *source;  // 微博的来源
@property(nonatomic,copy)NSString *source_allowclick;
@property(nonatomic,copy)NSString *source_type;
@property(nonatomic,copy)NSString *text;  // 微博的文字内容
@property(nonatomic,assign)int32_t textLength;
@property(nonatomic,strong)NSArray *text_tag_tips;
@property(nonatomic,copy)NSString *thumbnail_pic;
@property(nonatomic,copy)NSString *truncated;
@property(nonatomic,strong)WBUserModel *user;
@property(nonatomic,copy)NSString *userType;
@property(nonatomic,strong)WBVisibleModel *visible;

#pragma mark 自定义属性
@property(nonatomic,copy)NSAttributedString *orginalAttrStr;   //原创微博富文本属性文字
@property(nonatomic,copy)NSAttributedString *retweetAttrStr;  // 转发微博富文本属性文字
@end
