//
//  Utilities.m
//  zhifu360
//
//  Created by zhifu on 11/11/14. 
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import "Utilities.h"
#import <AdSupport/AdSupport.h>
@implementation Utilities


+(void)saveAFNetworkReachabilityStatus:status{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:status forKey:@"AFNetworkReachabilityStatus"];
    [defaults synchronize];
}

+(NSString*)getLocationCity{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey: @"locationCityName"];
}


+(void)saveLocationCity:city{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:city forKey:@"locationCityName"];
    [defaults synchronize];
}


+(NSString*)getCLLocationName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey: @"CLLocationName"];
}

+(void)saveCLLocationName:name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:name forKey:@"CLLocationName"];
    [defaults synchronize];
}

+ (NSNumber*) getAFNetworkReachabilityStatus{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey: @"AFNetworkReachabilityStatus"];
}

+ (NSMutableArray*)setDataToPlist:(NSString*)plistName{
    //获取documents 路径
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathsArray objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@.plist",documentsDirectory,plistName];
    NSMutableArray *plistArr = [NSMutableArray arrayWithContentsOfFile:path];
    // 判断是否为空，为空的话 要初始化否则，一直为空无法写入属性列表
    if (!plistArr) {
        plistArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return plistArr;
}

+ (void)writeToPlist:(NSString*)plistName withDataArray:(NSMutableArray*)dataArr{
    //获取documents 路径
    NSArray *pathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathsArray objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@.plist",documentsDirectory,plistName];
    NSLog(@"%@", path);
    [dataArr writeToFile:path atomically:YES];
}


+ (CGSize)getTextSize:(NSString *)aText withFont:(UIFont *)aFont andConstrainedToSize:(CGSize)aSize{
    //    return [aText sizeWithFont:aFont constrainedToSize:aSize lineBreakMode: NSLineBreakByWordWrapping];
    return [aText boundingRectWithSize:aSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: aFont} context:nil].size;
}

+(NSString *) getAppVersion {
    NSString *build_version_text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return build_version_text;
}


+ (NSString*)getDeviceSystem{
    return [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
}

+(NSString *) generateUUID{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, cfuuid);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(cfstring);
    CFRelease(cfuuid);
    
    return cfuuidString;
}


#pragma mark validation
+(BOOL)validateNumberAndString:(NSString*)textString{
    NSString *string = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",string];
    BOOL numStr = [pred evaluateWithObject:textString];
    return numStr;
}

+(BOOL)isValidCellPhone:(NSString*) phone{
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1[3|4|5|7|8][0-9]{9}$"];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:phone];
    return myStringMatchesRegEx;
}

+(BOOL)isValidLoginCellPhone:(NSString*) phone{
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1[3|4|5|7|8][0-9]{9}$"];
    NSPredicate *regExPredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^87000[0-9]{4}$"];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:phone]|[regExPredicate1 evaluateWithObject:phone];
    return myStringMatchesRegEx;
}

+(BOOL)isValidMailID:(NSString*) inEmailID{
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:inEmailID];
    return myStringMatchesRegEx;
}
+ (BOOL)isValidChinaID:(NSString*) chinaId{
    NSString *value = chinaId;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    year = [value substringWithRange:NSMakeRange(6,4)].intValue;
    if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
    }else {
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
    }
    numberofMatch = [regularExpression numberOfMatchesInString:value
                                                       options:NSMatchingReportProgress
                                                         range:NSMakeRange(0, value.length)];
    if(numberofMatch >0) {
        int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
        int Y = S %11;
        NSString *M =@"F";
        NSString *JYM =@"10X98765432";
        M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
        if ([M isEqualToString:[[value uppercaseString] substringWithRange:NSMakeRange(17,1)]]) {
            return YES;// 检测ID的校验位
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}


#pragma mark - data management


+(NSString *)getUUID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey: @"cfuuid"];
    if (!uuid) {
        uuid = [self generateUUID];
        [self setUUID:uuid];
    }
    
    return uuid;
}

+(void)setUUID:(NSString *)uuid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey: @"cfuuid"];
    
    if(uuid){
        [defaults setObject: uuid forKey: @"cfuuid"];
    }
    
    [defaults synchronize];
}


+(NSDate*)getServiceTime{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger delta = [defaults integerForKey: @"delta_second_with_service"];
    
    NSDate *serverTime = [NSDate dateWithTimeIntervalSinceNow:delta];
    
    return serverTime;
}

+(void)setDeltaSecondWithServiceTime:(NSInteger)timestamp{
    NSDate *serverTime = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitSecond;
    
    //当前时间和服务器时间的差值：
    //服务器时间 < 当前时间, delta为负数, 表示: 本地时间需要减去delta
    //服务器时间 > 当前时间, delta为负数, 表示: 本地时间需要加上delta
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:[NSDate date] toDate:serverTime options:0];
    
    NSInteger delta = [components second];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: delta forKey: @"delta_second_with_service"];
    [defaults synchronize];
}


+ (NSString *)formatCurrencyRMBByDecimal:(id)decimal{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    NSNumber *number;
    if ([decimal isKindOfClass:[NSString class]]) {
        number = [formatter numberFromString:decimal];
    }
    else{
        number = decimal;
    }
    
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    formatter.currencySymbol = @"";
    
    NSString *string = [formatter stringFromNumber:number];
    
    //    XLOG(@"Formatted number string:%@",string);
    return string;
}

+ (NSString*)formatYearMonthDay:(NSDate*)date{
    if (date == nil)
        return @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+ (BOOL)checkCarFrameNumber:(NSString*)string{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:string
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, string.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    
    BOOL check = false;
    
    

    if (tNumMatchCount + tLetterMatchCount == string.length) {
        //符合英文和符合数字条件的相加等于长度
        check = YES;
    }
    
    return check;
    
}

+ (BOOL)checkNumber:(NSString*)string{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:string
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, string.length)];
    BOOL check = false;
    
    if (tNumMatchCount == string.length) {
        //符合英文和符合数字条件的相加等于长度
        check = YES;
    }
    
    return check;
    
}



@end
