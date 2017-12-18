//
//  HUDUtil.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "HUDUtil.h"

@implementation HUDUtil

+(void)Hud_message:(NSString *)txt view:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = txt;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:3.f];
}

@end
