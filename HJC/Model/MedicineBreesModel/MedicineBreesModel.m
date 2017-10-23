//
//  MedicineBreesModel.m
//  HJC
//
//  Created by zhifu360 on 2017/10/23.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineBreesModel.h"

@implementation MedicineBreesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


-(void)setDict:(NSDictionary *)dict{
    self.ID = dict[@"id"];
}

@end
