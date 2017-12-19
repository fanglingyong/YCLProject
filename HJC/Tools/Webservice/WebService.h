//
//  WebService.h
//  WitCarLoan
//
//  Created by zhifu360 on 2017/4/19.
//  Copyright © 2017年 zhifu360. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebServiceResponseBlock)(NSString *status, id data, NSString *message);
/**
 *  调用服务端接口类  
 */
@interface WebService : NSObject
/**
 *  get请求
 *
 *  @param urlString 请求的url地址
 *  @param success   获取的数据的block
 *  @param failure   错误的block
 *  @param noNetWork 没有网络的block
 */
+ (void)sendRequestWithUrlString :(NSString*) urlString
                         paramDic:(NSMutableDictionary *)paramDic
                          success:(void (^)(id responseDic)) success
                          failure:(void(^)(NSError *error)) failure
                        noNetWork:(void (^)())noNetWork;

/**
 POST请求

 @param urlString 请求地址
 @param paramDic 请求参数
 @param image 上传的图片
 @param uploadProgress 进度
 @param success 请求成功block
 @param failure 错误的block
 */
+ (void)sendRequestWithUrlString :(NSString*)urlString
                         paramDic:(NSMutableDictionary *)paramDic
                            image:(UIImage*)image
                         progress:(void (^)(NSProgress *))uploadProgress
                          success:(void (^)(id responseDic)) success
                          failure:(void(^)(NSError *error)) failure;
@end


