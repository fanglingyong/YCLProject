//
//  NSDate+Anima.h
//  myKaxiu
//
//  Created by 方灵勇 on 16/6/29.
//  Copyright © 2016年 Shanghai mai yi sports co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Anima)
/**
 *  获得当前日期 yyyymmdd
 *
 *  @return 字符串
 */
+(NSString *)getCurrentDate;
/**
 *  获得当前日期 yyyyMMddHHmmss
 *
 *  @return 字符串
 */
+(NSString *)getCurrentDateTime;
/**
 *  获得当前时间戳 默认lunix 10位
 *
 *  @return NSTimeInterval
 */
+(NSTimeInterval) currentTimeStamp;
/**
 *  该调用时间对象的时间戳 默认lunix 10位
 *
 *  @return NSTimeInterval
 */
-(NSTimeInterval) timeStamp;
/**
 *  该调用时间对象的时间戳字符串形式 默认lunix 10位
 *
 *  @return 字符串
 */
-(NSString*) timeStampString;
/**
 *  当前时间戳字符串形式 默认lunix 10位
 *
 *  @return nsstring
 */
+(NSString*) currentTimeStampString;
/**
 *  时间戳转化时间nsdate格式
 *
 *  @param timeStamp 可以为负数 负数表示1970年之前
 *
 *  @return nsdate
 */
+(NSDate*) dateWithTimestamp:(NSTimeInterval) timeStamp;

-(NSInteger) month;
-(NSInteger) year;
-(NSInteger) day;
-(NSInteger) hour;
-(NSInteger) minute;
-(NSInteger) second;
/**
 *  判断是否是今天
 *
 *  @return BOOL Y/N
 */
-(BOOL)isToday;
/**
 *  返回UTC时间 字符串形式
 *
 *  @return 字符串
 */
-(NSString*) UTCString;
/**
 *  时间戳+时间格式 ---> @“2016年06月29日13:59:39”类似形式
 *
 *  @param timer   时间戳
 *  @param DateFmt 类型
 *
 *  @return 字符串
 */
+(NSString *)getThisTimerForDate:(NSTimeInterval)timer DateFmt:(NSString *)DateFmt;
/**
 *  2016年06月29日14:01:04 类型字符串
 *
 *  @param timer 时间戳
 *
 *  @return 字符串
 */
+(NSString *)getThisTimerForYMdHms:(NSTimeInterval)timer;

/**
 fanglingyong 2017年04月14日20:05:25 时间转化

 @param dateString xxxx-xx-xx
 @return 时间戳
 */
+ (NSDate*)dateWithDateString:(NSString*)dateString;

/**
 根据时间戳返回距离今天多久前

 @param timer 时间戳
 @return 字符串
 */
+ (NSString*)getDateWithNow:(NSInteger)timer;

/**
 获得当前时间字符串

 @param DateFmt 类型
 @return 返回一个DateFmt类型的字符串时间
 */
+ (NSString*)getNewDateStringWithDateFmt:(NSString *)DateFmt;
@end
