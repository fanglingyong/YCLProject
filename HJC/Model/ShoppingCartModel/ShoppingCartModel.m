//
//  ShoppingCartModel.m
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isSelect = NO;
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
