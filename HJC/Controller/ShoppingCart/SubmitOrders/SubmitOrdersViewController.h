//
//  SubmitOrdersViewController.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BaseViewController.h"

@interface SubmitOrdersViewController : BaseViewController

@property (nonatomic,copy) NSString *orderIDs;//细单id
@property (nonatomic,copy) NSString * orderNo;//订单编号
@property (nonatomic,copy) NSArray *modelArr;
@property (nonatomic,assign) double totalMoeny;

@end
