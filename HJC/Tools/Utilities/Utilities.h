//
//  Utilities.h
//  zhifu360
//
//  Created by zhifu on 11/11/14.
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)



/**
 *  公用的类
 */
@interface Utilities : NSObject


+(void)saveAFNetworkReachabilityStatus:(NSNumber*)status; // -1 不知状态 1 无网络 2 手机流量 3 wifi



+(NSNumber*)getAFNetworkReachabilityStatus;

// 获取当前定位城市
+(NSString*)getLocationCity;

// 保存定位城市
+(void)saveLocationCity:(NSString*)city;

// 经纬度
//+(NSString*)getCLLocationLatitude;
//+(void)saveCLLocationLatitude:latitude;
//+(NSString*)getCLLocationLongitude;
//+(void)saveCLLocationLongitude:longitude;
+(NSString*)getCLLocationName;
+(void)saveCLLocationName:name;

/*
 获取plist内容
 */
+ (NSMutableArray*)setDataToPlist:(NSString*)plistName;

/*
 增删改查后写入plist
 */
+ (void)writeToPlist:(NSString*)plistName withDataArray:(NSMutableArray*)dataArr;

+ (CGSize)getTextSize:(NSString *)aText withFont:(UIFont *)aFont andConstrainedToSize:(CGSize)aSize;
/**
 *  获得APP版本
 */
+ (NSString *) getAppVersion;
/**
 *  获得设备系统
 *
 */
+ (NSString*) getDeviceSystem;



// ************** valication
/**
 *  验证手机号是否合法
 *
 *  @param phone a
 *
 *  @return 合法返回yes
 */
+ (BOOL)isValidCellPhone:(NSString*) phone;
/**
 *  验证输入是否是英文和数字
 *
 *  @return 合法返回yes
 */
+(BOOL)validateNumberAndString:(NSString*)textString;
/**
 *  验证邮箱地址是否合法
 *
 *  @param inEmailID a
 *
 *  @return 合法返回yes
 */
+ (BOOL)isValidMailID:(NSString*) inEmailID;
/**
 *  验证身份证号是否合法
 *
 *  @param chinaId a
 *
 *  @return 合法返回yes
 */
+ (BOOL)isValidChinaID:(NSString*) chinaId;

// ************** data management

/**
 *  获得UUID
 *
 *  @return <#return value description#>
 */
+(NSString *)getUUID;
/**
 *  保存UUID
 *
 *  @param uuid <#uuid description#>
 */
+(void)setUUID:(NSString *)uuid;

/**
 *  获得服务器时间
 *
 *  @return <#return value description#>
 */
+(NSDate*)getServiceTime;
/**
 *  保存和服务器时间的差别
 *
 *  @param timestamp <#timestamp description#>
 */
+(void)setDeltaSecondWithServiceTime:(NSInteger)timestamp;



+(BOOL)isValidLoginCellPhone:(NSString*) phone;

/**
 *  格式化decimal为RMB格式

 */
+ (NSString *)formatCurrencyRMBByDecimal:(id)decimal;

/**
 *  保存AdvertImageUrl4S
 */


+ (BOOL)checkCarFrameNumber:(NSString*)string;

+ (BOOL)checkNumber:(NSString*)string;

@end
