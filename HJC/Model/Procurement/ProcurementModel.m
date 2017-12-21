//
//  ProcurementModel.m
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ProcurementModel.h"
#import <objc/runtime.h>

@implementation ProcurementModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(NSMutableDictionary *)returnToDictionaryWithModel{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([ProcurementModel class], &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [userDic setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return userDic;
}


@end
