//
//  ProcurementModel.m
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ProcurementModel.h"

@implementation ProcurementModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


-(void)setDict:(NSDictionary *)dict{
    self.ID = dict[@"id"];
}

@end
