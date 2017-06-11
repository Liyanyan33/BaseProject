//
//  NetWork.m
//  JiCheng
//
//  Created by lyy on 16/4/5.
//  Copyright © 2016年 ZXJK. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetworking.h"
#import "LYDefine.h"
#import "URLDefine.h"

@implementation NetWorking

+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    NSLog(@" url = %@",url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas resultClass:(Class)resultClass success:(void(^)(id json))success failure:(void(^)(id error))failure{
    NSLog(@" url = %@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager GET:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success([resultClass mj_objectWithKeyValues:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas resultClass:(Class)resultClass success:(void(^)(id json))success failure:(void(^)(id error))failure{
    NSLog(@" url = %@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager POST:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success([resultClass mj_objectWithKeyValues:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas resultClass:(Class)resultClass  resultViewModel:(Class)resultViewModel success:(void(^)(id json))success failure:(void(^)(id error))failure{
    NSLog(@" url = %@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager POST:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success([resultClass mj_objectWithKeyValues:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (failure) {
            failure(error);
        }
    }];
}




+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager  manager];
    [manager POST:url parameters:paramas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)GETWithUrl:(NSString*)url paramas:(NSDictionary*)paramas viewController:(UIViewController*)VC success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    UIView *overlay = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    overlay.backgroundColor = [UIColor blackColor];
    overlay.alpha = 0.7;
    [VC.view addSubview:overlay];
    
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [overlay removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithUrl:(NSString*)url paramas:(NSDictionary*)paramas viewController:(UIViewController*)VC success:(void(^)(id json))success failure:(void(^)(id error))failure{
    
    UIView *overlay = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    overlay.backgroundColor = [UIColor blackColor];
    overlay.alpha = 0.7;
    [VC.view addSubview:overlay];
    
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [overlay removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//+ (void)UploadFile:(NSString *)url parameters:(NSDictionary *)parameters uploadInfo:(UpLoadInfo *)upLoadInfo succeed:(void (^)(id responseObject))succeed upLoadProgerss:(void (^)(id uploadProgress))upLoadProgerss failure:(void (^)(NSError * error))failure{
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        /**
//         *  FileData:      要上传的文件的二进制数据
//         *  name:          上传参数名称
//         *  fileName：  上传到服务器的文件名称
//         *  mimeType：文件类型
//         */
//        [formData appendPartWithFileData:upLoadInfo.data name:upLoadInfo.name fileName:upLoadInfo.fileName mimeType:upLoadInfo.fileType];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"%@",uploadProgress);
//        // @property int64_t totalUnitCount;             文件的总大小
//        // @property int64_t completedUnitCount;   已经上传的大小
//        if (uploadProgress) {
//            upLoadProgerss(uploadProgress);
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (succeed) {
//            succeed(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

+ (NSURLSessionDownloadTask*)downLoadFile:(NSString *)url downLoadProgress:(void(^)(NSProgress* downLoadProgress))downLoadProgress destination:(NSURL*(^)(id targetPath,NSURLResponse* response))destination completionHandler:(void(^)(id response,id filePath,id error))completionHandler{

    NSURL *URL = [NSURL URLWithString:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downLoadProgress) {
            downLoadProgress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (destination) {
            return destination(targetPath,response);
        }
        return nil;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response,filePath,error);
        }
    }];
    return downLoadTask;
}

+ (void)GETWithPartUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void (^)(id json))success failure:(void (^)(id error))failure{
    
    NSString *wholeURL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
     NSLog(@"请求链接 = %@",wholeURL);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:wholeURL parameters:paramas progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithPartUrl:(NSString *)url paramas:(NSDictionary *)paramas success:(void (^)(id json))success failure:(void (^)(id error))failure{

    NSString *wholeURL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    NSLog(@"请求链接 = %@",wholeURL);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager  manager];
    [manager POST:wholeURL parameters:paramas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
