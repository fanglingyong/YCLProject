//
//  NewAddressViewController.h
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ReceiveAddressModel.h"

typedef void(^refreshUIBlock)(void);

@interface NewAddressViewController : BaseTableViewController

@property (nonatomic,copy) refreshUIBlock block;

@end
