//
//  NSTimer+Addition.h
//  zhifu360
//
//  Created by zhifu on 14-1-24.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * NSTimer扩展
 */
@interface NSTimer (Addition)
/**
 *  暂停计时器
 */
- (void)pauseTimer;
/**
 *  恢复计时器
 */
- (void)resumeTimer;
/**
 *  interval后恢复计时器
 *
 *  @param interval interval
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
