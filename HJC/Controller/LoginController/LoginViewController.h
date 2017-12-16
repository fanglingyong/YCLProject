//
//  LoginViewController.h
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^refreshDataBlock)();

@interface LoginViewController : BaseViewController

@property (nonatomic,copy) refreshDataBlock refeshBlock;

@end
