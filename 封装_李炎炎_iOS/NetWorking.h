//
//  NetWork.h
//  JiCheng
//
//  Created by lyy on 16/4/5.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "UpLoadInfo.h"

@interface NetWorking : NSObject

/** 请求数据 */
+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure;

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure;

+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas viewController:(UIViewController*)VC success:(void(^)(id json))success failure:(void(^)(id error))failure;

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas viewController:(UIViewController*)VC success:(void(^)(id json))success failure:(void(^)(id error))failure;

+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas resultClass:(Class)resultClass success:(void(^)(id json))success failure:(void(^)(id error))failure;

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas resultClass:(Class)resultClass success:(void(^)(id json))success failure:(void(^)(id error))failure;

/** 文件上传  有进度 */
//+ (void)UploadFile:(NSString *)url parameters:(NSDictionary *)parameters uploadInfo:(UpLoadInfo *)upLoadInfo succeed:(void (^)(id responseObject))succeed upLoadProgerss:(void (^)(id uploadProgress))upLoadProgerss failure:(void (^)(NSError * error))failure;

/** 文件下载 有进度*/
+ (NSURLSessionDownloadTask*)downLoadFile:(NSString *)url downLoadProgress:(void(^)(NSProgress* downLoadProgress))downLoadProgress destination:(NSURL*(^)(id targetPath,NSURLResponse* response))destination completionHandler:(void(^)(id response,id filePath,id error))completionHandler;

/** 部分URL内部需要进行拼接 */
+ (void)GETWithPartUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void (^)(id json))success failure:(void (^)(id error))failure;

+ (void)POSTWithPartUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void (^)(id json))success failure:(void (^)(id error))failure;


@end
