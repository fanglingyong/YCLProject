//
//  EncrtDecrt.m
//  zhifu360
//
//  Created by zhifu on 13-11-3.
//  Copyright (c) 2013年 LS.Shanghai.MacPro.20120709. All rights reserved.
//

#import "EncrtDecrt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "Utilities.h"

@implementation EncrtDecrt


+(NSString *) md5:(NSString*)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    NSString* data=[NSString
                    stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    result[0], result[1], result[2], result[3],result[4], result[5],
                    result[6], result[7],result[8], result[9],result[10], result[11],
                    result[12], result[13],result[14], result[15] ];
    
    return data;
}
@end
