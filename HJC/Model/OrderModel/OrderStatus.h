//
//  OrderStatus.h
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStatus : NSObject<NSCoding>

/**
 *  订单状态
 */
@property (nonatomic, assign) NSUInteger orderStatus; //

/**
 *  订单状态 显示字符串
 */
@property (nonatomic, weak, readonly) NSString *orderStatusTitle;

/**
 *  订单状态 数组
 */
@property (nonatomic, strong) NSArray *orderStatusArray;

/**
 *  根据conditions数组，生成订单状态  数组
 *
 *  @param conditions array
 */
-(void)setupBasicArray:(NSArray *) conditions;
@end



