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
@end


