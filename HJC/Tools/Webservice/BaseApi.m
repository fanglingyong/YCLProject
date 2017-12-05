//
//  BaseApi.m
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BaseApi.h"
#import "WebService.h"

@implementation BaseApi

+ (void)getRegisterURLWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostPath, RegisterURL];
    
    [WebService sendRequestWithUrlString:urlStr paramDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"data"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } noNetWork:nil];
    
}


+ (void)getLoginURLWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostPath, LoginURL];
    [WebService sendRequestWithUrlString:urlStr paramDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"data"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } noNetWork:nil];
    
}

+ (void)getProducerWithBlock:(void (^)(NSDictionary *dict, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HostPath, GetHostInfo];
    [WebService sendRequestWithUrlString:urlStr paramDic:dic success:^(id responseDic) {
        if(block){
            block(responseDic[@"data"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"error===>%@",error);
        if (block) {
            block(nil, error);
        }
    } noNetWork:nil];
    
}


@end
