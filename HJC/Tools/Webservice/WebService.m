//
//  WebService.m
//  WitCarLoan
//
//  Created by zhifu360 on 2017/4/19.
//  Copyright © 2017年 zhifu360. All rights reserved.
//

#import "WebService.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "Utilities.h"

@implementation WebService

+ (void)sendRequestWithUrlString :(NSString*)urlString
                         paramDic:(NSMutableDictionary *)paramDic
                           success:(void (^)(id responseDic)) success
                           failure:(void(^)(NSError *error)) failure
                         noNetWork:(void (^)())noNetWork{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1){
            NSLog(@"未知网络");
        }else if(status == 0){
            NSLog(@"没有网络(断网)");
        }else if(status == 1){
//            NSLog(@"手机自带网络");
        }else if(status == 2){
//            NSLog(@"WIFI");
        }
        
    }];
    [mgr startMonitoring];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript", @"text/html"]];
    
    //将字典改为json再发送
    [manager GET:urlString parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [WebService dealSuccessWithreRponseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error ===> %@",error);
        [WebService HudFailWithNetWorkErr:error failure:failure];
    }];

    
}


+ (void)sendRequestWithUrlString :(NSString*)urlString
                         paramDic:(NSMutableDictionary *)paramDic
                            image:(UIImage*)image
                         progress:(void (^)(NSProgress * ))uploadProgress
                          success:(void (^)(id responseDic)) success
                          failure:(void(^)(NSError *error)) failure{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1){
            NSLog(@"未知网络");
        }else if(status == 0){
            NSLog(@"没有网络(断网)");
        }else if(status == 1){
            NSLog(@"手机自带网络");
        }else if(status == 2){
            NSLog(@"WIFI");
        }
        
    }];
    [mgr startMonitoring];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript", @"text/html"]];
    
    //将字典改为json再发送
    [manager POST:urlString parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.7);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [WebService dealSuccessWithreRponseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WebService HudFailWithNetWorkErr:error failure:failure];
    }];
}
/**
 *  处理获取服务器返回成功的数据
 *
 *  @param responseObject json数据
 */
+ (void)dealSuccessWithreRponseObject:(id)responseObject
                              success:(void (^)(id responseDic)) success
                              failure:(void(^)(NSError *error)) failure{
//    NSLog(@"responseObject=========%@",[responseObject[@"status"] class]);
//    NSLog(@"responseObject=========%@",responseObject);
    if ([responseObject[@"status"] integerValue] == 1) {
        if(success){
            success(responseObject);
        }
    }else{
        NSString *err=[NSString stringWithFormat:@"%@",responseObject[@"message"]];
        NSString *errCode=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
        NSError *error=[NSError errorWithDomain:err code:[errCode integerValue] userInfo:@{@"status":errCode}];
        [WebService HudFailWithErrMessage:error failure:failure];
        if(failure){
            failure(error);
        }
    }
}

/**
 *  处理进入异常错误
 *
 *  @param error 自定义的NSError
 */
+(void)HudFailWithNetWorkErr:(NSError *)error failure:(void(^)(NSError *error)) failure{
//    NSLog(@"userInfo-------%@",error.userInfo);
//    NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
//    NSLog(@"%ld",(long)error.code);
    if(failure){
        failure(error);
    }
}
/**
 *  处理服务器返回的错误
 *
 *  @param error 服务器返回的NSError
 */
+(void)HudFailWithErrMessage:(NSError *)error failure:(void(^)(NSError *error)) failure{
//    NSLog(@"===>%@",error.domain);
//    NSLog(@"%ld",(long)error.code);
//    NSLog(@"===>%@",error.userInfo);
//    [WebService AddAlertView:error.domain];
    
    if(failure){
        failure(error);
    }
}

+(void)AddAlertView:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

// 字典转json
- (NSString *)dictToJsonString:(NSDictionary *)oriDictionary {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:oriDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = @"";
    if (jsonData != nil) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//json转字典
- (NSDictionary *)JsonStringToDict:(NSString *)jsonString {
    
    
    if (jsonString.length > 0) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        return dic;
    } else {
        return nil;
    }
    
}

@end

