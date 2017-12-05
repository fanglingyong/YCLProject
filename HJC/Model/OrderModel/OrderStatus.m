//
//  OrderStatus.m
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderStatus.h"

@implementation OrderStatus
- (id) init{
    if(self = [super init]){
        _orderStatus = 0;
    }
    
    return self;
}
/**
 *  initWithCoder
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.orderStatus = [aDecoder decodeIntegerForKey:@"orderStatus"];
    }
    
    return self;
}

- (NSString *)orderStatusTitle{
    if (self.orderStatus == 0) {
        return @"订单状态";
    }
    return [self.orderStatusArray objectAtIndex: self.orderStatus];
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.orderStatus forKey:@"orderStatus"];
}

- (void)setupBasicArray:(NSArray *) conditions{
    for (int i = 0; i < conditions.count; i++) {
        if (i == 0) {
            self.orderStatusArray = conditions[i];
        }
    }
}
@end




