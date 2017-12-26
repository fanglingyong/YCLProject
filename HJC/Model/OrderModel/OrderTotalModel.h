//
//  OrderTotalModel.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTotalModel : NSObject

@property (nonatomic,strong) NSString *ORDERNO;//-订单总单号
@property (nonatomic,strong) NSString *CREATETIME;//-创建时间
@property (nonatomic,strong) NSString *ORDERSUMS;//-订单总金额
@property (nonatomic,strong) NSString *ADDRESS;//-送货地址
@property (nonatomic,strong) NSString *sortid;//-id
@property (nonatomic,strong) NSString *totalcount;//-总数量

@end
