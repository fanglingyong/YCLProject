//
//  AnimaDefaultUtil.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimaDefaultUtil : NSObject

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
+(void)alertUtil:(UIViewController*)vc message:(NSString*)msg;
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
+ (BOOL) isNotNull:(id)object;
/**
 *  json对象转化成json字符串
 *
 *  @param resont 字典、数组等对象
 *
 *  @return 返回json格式的字符串
 */
+ (NSString*)stringJson:(id)resont;
/**
 *  json字符串转化成json对象
 *
 *  @param stringJson json字符串
 *
 *  @return json对象
 */
+ (id)jsonString:(NSString *)stringJson;
/**
 *  unicode转化中文
 *
 *  @param unicodeStr unicode类型的字符串
 *
 *  @return 返回中文字符串
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
/**
 *  干掉转义符  去你妈的 \
 *
 *  @param string 需要处理的字符串
 *
 *  @return 返回处理完的字符串
 */
+ (NSString*)stringWithZYF:(NSString*)string;
/**
 html标签的字符串 去除标签
 
 @param html 含有html标签的字符串
 @return 去除标签
 */
+ (NSString *)getTextFromHTML:(NSString *)html;
/**
 *  正则匹配手机号 2015-11-12 19:04:09
 *
 *  @param telNumber 手机号码
 *
 *  @return 正则匹配手机号
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;
/**
 *  正则匹配简单的11位手机号码    1【0~9】……9 (局限中国)
 *
 *  @param telNumber telephoneNumber
 *
 *  @return 2016年06月15日20:37:58
 */
+ (BOOL)checkTelNumber_simple:(NSString *) telNumber;
/**
 *  正则匹配用户密码6-18位数字和字母组合
 *
 *  @param password 密码
 *
 *  @return 2016年06月15日20:37:46
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 *  匹配是否可以输入 2015-11-12 19:15:54 fanglingyong
 *
 *  @param passwordOne 密码，用于(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 *
 *  @return 匹配是否可以输入
 */
+ (BOOL)checkWritePassword:(NSString *)passwordOne;
/**
 *  正则匹配用户姓名,20位的中文或英文
 *
 *  @param userName 字符串昵称。
 *
 *  @return 2015年11月12日18:41:57
 */
+ (BOOL)checkUserName : (NSString *) userName;
/**
 *  正则匹配用户身份证号
 *
 *  @param idCard 身份证号码
 *
 *  @return 2015年11月12日18:41:57
 */
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/**
 *  正则匹配员工号，学生证号等12位数字
 *
 *  @param number 证件号
 *
 *  @return 2015年11月12日18:41:57
 */
+ (BOOL)checkEmployeeNumber : (NSString *) number;
/**
 *  正则匹配URL 2015年11月12日18:41:57
 *
 *  @param url URL
 *
 *  @return 正则匹配URL
 */
+ (BOOL)checkURL : (NSString *) url;

/**
 获取自适应宽高
 
 @param sting 字符串内容
 @param size 约束大小
 @param font 字体大小
 @return 返回宽高
 */
+ (CGSize)getAutoLayoutHeight:(NSString*)sting Lsize:(CGSize)size font:(UIFont*)font;


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

@end
