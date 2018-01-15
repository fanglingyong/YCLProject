//
//  MedicineDetailViewController.h
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ProcurementModel.h"

@interface MedicineDetailViewController : BaseTableViewController

@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *goodsID;

@end
