//
//  SCWebViewController.h
//  ad
//
//  Created by 致富360 on 16/1/19.
//  Copyright © 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SCWebViewController : UIViewController

@property(nonatomic,strong)NSString * urlString;
@property(nonatomic,assign)BOOL IsNav;              //前面一个界面有没有navigation 有为yes，没有不用设置
@property(nonatomic,strong)NSString *titleString;
@property (nonatomic, assign)BOOL IsAnimation;
@property (nonatomic,strong)NSString *HTMLString;

@end
