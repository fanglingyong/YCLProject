//
//  BaseApi.h
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseApi : NSObject

// 注册
+ (void)getRegisterURLWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

// 登录
+ (void)getLoginURLWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

// 产品
+ (void)getProducerWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;


@end
