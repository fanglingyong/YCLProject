//
//  OrderModel.h
//  HJC
//
//  Created by zhifu360 on 2017/11/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic,strong) NSString *ORDERID;    //订单细单ID
@property (nonatomic,strong) NSString *GOODSID;    //货品ID
@property (nonatomic,strong) NSString *GOODSNAME;  //货品名称
@property (nonatomic,strong) NSString *SPEC;       //规格
@property (nonatomic,strong) NSString *PRODUCER;   //厂家
@property (nonatomic,strong) NSString *CALCUNIT;   //单位
@property (nonatomic,strong) NSString *ORDERAMOUNT;//数量
@property (nonatomic,strong) NSString *SELLPRICE;  //会员价
@property (nonatomic,strong) NSString *RETAILPRICE;//零售价
@property (nonatomic,strong) NSString *ORDERSUMS;  //订单细单金额
@property (nonatomic,strong) NSString *NAME;       //状态
@property (nonatomic,strong) NSString *CREATETIME; //创建时间
@property (nonatomic,strong) NSString *COMMITTIME; //完成时间
@property (nonatomic,strong) NSString *ADDRESS;    //送货地址（可不显示）
@end
