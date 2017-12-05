//
//  EncrtDecrt.h
//  zhifu360
//
//  Created by zhifu on 13-11-3.
//  Copyright (c) 2013年 LS.Shanghai.MacPro.20120709. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  加密解密类
 */
@interface EncrtDecrt : NSObject

/**
 *  MD5 加密算法
 */
+(NSString *)md5:(NSString*)str;
@end
