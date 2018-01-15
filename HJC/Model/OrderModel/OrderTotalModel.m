//
//  OrderTotalModel.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderTotalModel.h"

@implementation OrderTotalModel

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"goodsList"]) {
        self.GoodsList = [NSMutableArray array];
        for (NSDictionary*dic in value) {
            OrderGoodsListModel *modelgl = [[OrderGoodsListModel alloc] init];
            [modelgl setValuesForKeysWithDictionary:dic];
            [self.GoodsList addObject:modelgl];
        }
    }else{
       [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
}

@end

/**************************************
 
 */

@implementation OrderGoodsListModel


@end
