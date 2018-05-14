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

@interface NewAddressViewController : BaseViewController

@property (nonatomic,copy) refreshUIBlock block;
@property (nonatomic,copy) ReceiveAddressModel *model;
@property (nonatomic,strong) NSString *addressID;

@end
