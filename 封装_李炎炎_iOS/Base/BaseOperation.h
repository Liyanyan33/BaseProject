//
//  BaseOperation.h
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//  网络请求基类  提供基本的网络请求

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseOperation : NSObject

- (instancetype)initRequestOperationWithUrl:(NSString*)urlStr paramas:(NSMutableDictionary*)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure;
- (instancetype)initRequestOperationWithParamas:(NSMutableDictionary *)paramas success:(void (^)(id json))success failure:(void (^)(id error))failure;
- (instancetype)initRequestOperationWithParamas:(NSMutableDictionary *)paramas  resultClass:(Class)resultClass success:(void (^)(id json))success failure:(void (^)(id error))failure;

/** 发送网络请求 */
- (void)sendGetRequestAtVC:(UIViewController*)Vc;
- (void)sendPostRequest;

- (void)sendGetRequestWithHud:(BOOL)hud isCache:(BOOL)cache isDic:(NSDictionary*)dic;

/** 解析数据 */
- (NSMutableArray*)pasterWithData:(id)json;
- (NSMutableDictionary*)pasterWithData:(id)json isDic:(BOOL)dic;

/** 临时数组存储 */
@property(nonatomic,strong)NSMutableArray *tempDataArray;
@property(nonatomic,strong)NSMutableDictionary *tempDic;

@property(nonatomic,copy)NSString *requestUrl;

@end
