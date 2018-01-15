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
@property (nonatomic,strong) NSString *INTEGRAL;//积分
@property (nonatomic,strong) NSString *PROSTATUSNAME;//配送状态
@property (nonatomic,strong) NSMutableArray *GoodsList;//goodList 内含OrderGoodsListModel

@end

@interface OrderGoodsListModel :NSObject

@property (nonatomic,strong) NSString *ADDRESS;//地址
@property (nonatomic,strong) NSString *CALCUNIT;//计算单位
@property (nonatomic,strong) NSString *COMMITTIME;//提交时间
@property (nonatomic,strong) NSString *CREATETIME;//创建时间
@property (nonatomic,strong) NSString *GOODSID;//货品ID
@property (nonatomic,strong) NSString *GOODSNAME;//货品名称
@property (nonatomic,strong) NSString *NAME;//收货人姓名
@property (nonatomic,strong) NSString *ORDERAMOUNT;//订单数量
@property (nonatomic,strong) NSString *ORDERID;//订单号
@property (nonatomic,strong) NSString *ORDERSUMS;//订单总额
@property (nonatomic,strong) NSString *PRODUCER;//厂家
@property (nonatomic,strong) NSString *RETAILPRICE;//零售价
@property (nonatomic,strong) NSString *SELLPRICE;//实售价
@property (nonatomic,strong) NSString *SPEC;//规格

@end

