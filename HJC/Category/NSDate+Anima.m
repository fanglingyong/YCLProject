//
//  NSDate+Anima.m
//  myKaxiu
//
//  Created by 方灵勇 on 16/6/29.
//  Copyright © 2016年 Shanghai mai yi sports co., LTD. All rights reserved.
//

#import "NSDate+Anima.h"

@implementation NSDate (Anima)

-(NSString*) toStringForDateFormatter:(NSString*) dateFormatter {
    NSString *dateString = nil;
    @try {
        if ([dateFormatter isEqualToString:@""] || dateFormatter == nil) {
            dateFormatter = @"yyyyMMddHHmmssSSS";
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:dateFormatter];
        NSString *str = [formatter stringFromDate:self];
        dateString = [[NSString alloc] initWithString:str];
    }
    @catch (NSException *exception) {
        dateString = nil;
        NSLog(@"'NSDate to NSString error~' exception:%@",exception);
    }
    return dateString;
}
+(NSString *)getCurrentDate {
    return [[NSDate date] toStringForDateFormatter:@"yyyyMMdd"];
}
+(NSString *)getCurrentDateTime {
    return [[NSDate date] toStringForDateFormatter:@"yyyyMMddHHmmssSSS"];
}
+(NSTimeInterval) currentTimeStamp {
    return [[NSDate date] timeStamp];
}
-(NSString*) timeStampString {
    NSTimeInterval timeStamp = [self timeStamp];
    return [NSString stringWithFormat:@"%0.0f",timeStamp];
}
+(NSString*) currentTimeStampString {
    NSTimeInterval currentTimeStamp = [self currentTimeStamp];
    return [NSString stringWithFormat:@"%0.0f",currentTimeStamp];
}
+(NSDate*) dateWithTimestamp:(NSTimeInterval) timeStamp {
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}
-(NSTimeInterval) timeStamp {
    return [self timeIntervalSince1970];
}
-(NSInteger) month {
    unsigned unitFlags = NSCalendarUnitMonth;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.month;
}
-(NSInteger) year {
    unsigned unitFlags = NSCalendarUnitYear;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    //    [gregorian setTimeZone:[NSTimeZone timez]];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.year;
}
-(NSInteger) day {
    unsigned unitFlags = NSCalendarUnitDay;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.day;
}
-(NSInteger) hour {
    unsigned unitFlags = NSCalendarUnitHour;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.hour;
}
-(NSInteger) minute {
    unsigned unitFlags = NSCalendarUnitMinute;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.minute;
}
-(NSInteger) second {
    unsigned unitFlags = NSCalendarUnitSecond;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps.second;
}
-(BOOL)isToday {
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    NSDateComponents *todayComps = [gregorian components:unitFlags fromDate:[NSDate date]];
    if (comps.year == todayComps.year && comps.month == todayComps.month && comps.day == todayComps.day) {
        return YES;
    }
    return NO;
}
-(NSString*) UTCString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *str = [formatter stringFromDate:self];
    return [[NSString alloc] initWithString:str];
}

+(NSString *)getThisTimerForDate:(NSTimeInterval)timer DateFmt:(NSString *)DateFmt{
    return [[NSDate dateWithTimeIntervalSince1970:timer] toStringForDateFormatter:DateFmt];
}

+(NSString *)getThisTimerForYMdHms:(NSTimeInterval)timer{
    return [[NSDate dateWithTimeIntervalSince1970:timer] toStringForDateFormatter:@"yyyy年MM月dd日HH:mm:ss"];
}

+ (NSDate*)dateWithDateString:(NSString*)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateNew = [formatter dateFromString:dateString];
    return dateNew;
}

+ (NSString*)getDateWithNow:(NSInteger)timer{
    NSInteger newTime = [NSDate currentTimeStamp];
    NSInteger poor = newTime-timer;
    NSString *temp = @"";
    if (poor<60) {
        temp = @"刚刚";
    }else if (poor<3600){
        temp = [NSString stringWithFormat:@"%ld分钟前",poor/60];
    }else if (poor<86400){
        temp = [NSString stringWithFormat:@"%ld小时前",poor/3600];
    }else if (poor<2592000){
        temp = [NSString stringWithFormat:@"%ld天前",poor/86400];
    }else{
        temp = [[NSDate dateWithTimeIntervalSince1970:timer] toStringForDateFormatter:@"yyyy年MM月dd日HH:mm"];
    }
    return temp;
}
+ (NSString*)getNewDateStringWithDateFmt:(NSString *)DateFmt{
    return [[NSDate date] toStringForDateFormatter:DateFmt];
}
@end
