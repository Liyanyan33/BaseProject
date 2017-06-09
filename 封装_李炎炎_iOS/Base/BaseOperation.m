//
//  BaseOperation.m
//  封装_李炎炎_iOS
//
//  Created by lyy on 16/9/9.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "BaseOperation.h"
#include "NetWorking.h"

typedef void(^successBlock)(id successResponse);
typedef void(^failureBlock)(id failureResponse);

@interface BaseOperation ()
{

    Class _resultClass;
    
}
@property(nonatomic,strong)NSMutableDictionary *params;
@property(nonatomic,copy)NSString *urlStr;
@property(nonatomic,copy)successBlock successBlock;
@property(nonatomic,copy)failureBlock failureBlock;

#pragma mark 属性配置 [hud; cache; dictionary]

@end

@implementation BaseOperation

- (instancetype)initRequestOperationWithUrl:(NSString *)urlStr paramas:(NSMutableDictionary *)paramas success:(void (^)(id))success failure:(void (^)(id))failure{

    self = [super init];
    if (self) {
         [self dataLocalWith:self.requestUrl paramas:paramas  resultClass:nil success:success failure:failure];
    }
    return self;
}

- (instancetype)initRequestOperationWithParamas:(NSMutableDictionary *)paramas success:(void (^)(id))success failure:(void (^)(id))failure{

    self = [super init];
    if (self) {
        [self dataLocalWith:self.requestUrl paramas:paramas  resultClass:nil success:success failure:failure];
        
    }
    return self;
}

- (instancetype)initRequestOperationWithParamas:(NSMutableDictionary *)paramas  resultClass:(Class)resultClass success:(void (^)(id json))success failure:(void (^)(id error))failure{
    
    self = [super init];
    if (self) {
        [self dataLocalWith:self.requestUrl paramas:paramas  resultClass:resultClass success:success failure:failure];
    }
    return self;
}

- (void)sendGetRequestAtVC:(UIViewController*)Vc{
    
#pragma mark 默认添加HUD缓冲控件
    [LYHud showActivityIndicatorAtView:Vc.view title:loadTitle dimBackground:YES];
    
    [NetWorking GETWithPartUrl:_urlStr paramas:_params success:^(id json) {
        [LYHud hideAtView:Vc.view];
        // 数据解析
        _tempDataArray = [self pasterWithData:json];
        
        if (_successBlock) {
            _successBlock(_tempDataArray);
        }
        
    } failure:^(id error) {
        [LYHud hideAtView:Vc.view];
        [LYHud showToastAtView:Vc.view title:busyTitle delay:5.0];
        if (_failureBlock) {
            _failureBlock(error);
        }
    }];
}

- (void)sendPostRequest{

    
}

- (void)sendGetRequestWithHud:(BOOL)hud isCache:(BOOL)cache isDic:(NSDictionary *)dic{

    if (!hud) {
        [NetWorking GETWithPartUrl:_urlStr paramas:_params success:^(id json) {
            if (dic) {
                _tempDic = [self pasterWithData:json isDic:YES];
                if (_successBlock) {
                    _successBlock(_tempDic);
                }
            }else{
                _tempDataArray = [self pasterWithData:json];
                if (_successBlock) {
                    _successBlock(_tempDataArray);
                }
            }
        } failure:^(id error) {
            if (_failureBlock) {
                _failureBlock(error);
            }
        }];
    }
}

#pragma mark private method  参数数据本地化
- (void)dataLocalWith:(NSString*)url paramas:(NSMutableDictionary*)paramas resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(id))failure{
    _urlStr = url;
    _params = paramas;
    _resultClass = resultClass;
    _successBlock = success;
    _failureBlock = failure;
}



#pragma mark 懒加载
- (NSString*)requestUrl{

    return @"";
}

@end
