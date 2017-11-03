//
//  NSData+Anima.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "NSData+Anima.h"

@implementation NSData (Anima)

+(NSData*) archivedDataWithRootObject:(id) object {
    NSData *data = nil;
    if (object) {
        @try {
            if ([[object class] conformsToProtocol:@protocol(NSCoding)]) {
                data = [NSKeyedArchiver archivedDataWithRootObject:object];
            } else {
                NSLog(@"%@:archivedDataWithRootObject:没有实现NSCoding协议",NSStringFromClass(self));
            }
        }
        @catch (NSException *exception) {
            data = nil;
        }
    }
    return data;
}
+(id) unarchiveObjectWithData:(NSData*) data {
    id result = nil;
    if (data && [data length] > 0) {
        @try {
            result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        @catch (NSException *exception) {
            result = nil;
        }
    } else {
        NSLog(@"%@:unarchiveObjectWithData:参数data为空",NSStringFromClass(self));
    }
    return result;
}


@end
