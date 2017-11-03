//
//  NSData+Anima.h
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Anima)

/**
 *  对象转化成流形式
 *
 *  @param object 对象
 *
 *  @return 返回流
 */
+(NSData*) archivedDataWithRootObject:(id) object;
/**
 *  流数据转化成对象
 *
 *  @param data 数据流
 *
 *  @return 对象
 */
+(id) unarchiveObjectWithData:(NSData*) data;

@end
