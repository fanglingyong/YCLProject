//
//  Procurement.h
//  HJC
//
//  Created by 陈晨 on 2017/12/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Procurement : NSObject<NSCoding>

/**
 *  全部分类
 */
@property (nonatomic, assign) NSUInteger allClass; //
/**
 *  供应商
 */
@property (nonatomic, assign) NSUInteger suppliers;  //
/**
 *  促销
 */
@property (nonatomic, assign) NSUInteger promotions;  //
/**
 *  全部分类 显示字符串
 */
@property (nonatomic, weak, readonly) NSString *allClassTitle;
/**
 *  供应商 显示字符串
 */
@property (nonatomic, weak, readonly) NSString *suppliersTitle;
/**
 *  促销 显示字符串
 */
@property (nonatomic, weak, readonly) NSString *promotionsTitle;
/**
 *  全部分类 数组
 */
@property (nonatomic, strong) NSArray *allClassArray;
/**
 *  供应商 数组
 */
@property (nonatomic, strong) NSArray *suppliersArray;
/**
 *  促销 数组
 */
@property (nonatomic, strong) NSArray *promotionsArray;

/**
 *  根据conditions数组，生成全部分类, 供应商, 促销 3个数组
 *
 *  @param conditions array
 */
-(void) setupBasicArray:(NSArray *) conditions;
@end


