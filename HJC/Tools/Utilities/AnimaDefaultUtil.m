//
//  AnimaDefaultUtil.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AnimaDefaultUtil.h"

@implementation AnimaDefaultUtil

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
+(void)alertUtil:(UIViewController*)vc message:(NSString*)msg{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *default_ac = [UIAlertAction actionWithTitle:@"好哒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:default_ac];
    [vc presentViewController:ac animated:YES completion:^{
        //完成咯
    }];
}
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/**
 *  目前处理过的类 NSNull、NSString、NSArray、NSDictionary、NSMutableArray、NSMutableDictionary、NSNumber
 *
 *  @param object 判断的对象
 *
 *  @return 返回判断的结果 YES不为空 NO为空
 */
+ (BOOL) isNotNull:(id)object{
    if ([object isKindOfClass:[NSNull class]]) {
        if ([object isEqual:[NSNull null]]) {
            return NO;
        }else{
            return YES;
        }
    }else if ([object isKindOfClass:[NSString class]]){
        if ([object isEqualToString:@"(null)"] || [object isEqualToString:@"null"] || [object isEqualToString:@"NULL"] || [object isEqualToString:@"<null>"] || [[object stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
            return NO;
        } else {
            return YES;
        }
    }else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSMutableArray class]]){
        if (object == nil || [object isKindOfClass:[NSNull class]] ||  [object count] == 0){
            return NO;
        }
        return YES;
    }else if ([object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSMutableDictionary class]]){
        if (object == nil || [object isKindOfClass:[NSNull class]] ||  [[object allKeys] count] == 0){
            return NO;
        }
        return YES;
    }else if ([object isKindOfClass:[NSNumber class]]){
        return YES;
    }
    return NO;
}

+ (NSString*)stringJson:(id)resont{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resont options:0 error:nil];
    NSString *string = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}

+ (id)jsonString:(NSString *)stringJson{
    if ([AnimaDefaultUtil isNotNull:stringJson]) {
        NSData *jsonData = [stringJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                  options:NSJSONReadingMutableContainers
                                                    error:&err];
        if (!err)
            return json;
    }
    return nil;
}



+ (NSString*)stringWithZYF:(NSString*)string{
    NSString *character;
    NSMutableString *resportString = [[NSMutableString alloc]initWithString:string];
    for (NSInteger i = string.length-1; i >0; i --) {
        character = [string substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [resportString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    return resportString;
}

//Unicode转化为汉字

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 =[tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr =[NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
+(NSString *)getTextFromHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

#pragma 正则匹配11位手机号码
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
+ (BOOL)checkTelNumber_simple:(NSString *) telNumber
{
    //    NSString *pattern = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[6780]|18[0-9]|14[57])[0-9]{8}$";
    NSString *pattern = @"^1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}
#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    //    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkWritePassword:(NSString *)passwordOne
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"] invertedSet];
    NSString *filtered =[[passwordOne componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [passwordOne isEqualToString:filtered];
    return basic;
}
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[0-9a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

+ (CGSize)getAutoLayoutHeight:(NSString*)sting Lsize:(CGSize)size font:(UIFont*)font{
    if ([AnimaDefaultUtil isNotNull:sting]) {
        CGRect labelSize = [sting boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil];
        return labelSize.size;
    }
    return CGSizeMake(0, 0);
}

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */


@end
