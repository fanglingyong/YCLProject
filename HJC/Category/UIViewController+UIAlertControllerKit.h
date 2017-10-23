//
//  UIViewController+UIAlertControllerKit.h
//  JieBa
//
//  Created by zhifu360 on 16/10/15.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UIAlertControllerKit)
-(void)addAlertView:(NSString *)message block:(void (^)(void))block;
@end
