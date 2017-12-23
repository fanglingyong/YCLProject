//
//  ShoppingCartModel.h
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject

/*
 {
 CorpName = "\U534e\U4e1c\U533b\U836f\U80a1\U4efd\U6709\U9650\U516c\U53f8";
 Summoney = 7095;
 amount = 20;
 goodsid = 38;
 goodsname = "\U6ce8\U5c04\U7528\U5934\U5b62\U5511\U6797\U94a0";
 medicaltype = 225;
 orderid = 3;
 ordermemo = "";
 orderno = 1;
 ordersums = "1100.0000";
 prodarea = "\U77f3\U836f\U96c6\U56e2\U4e2d\U8bfa\U836f\U4e1a\Uff08\U77f3\U5bb6\U5e84\Uff09\U6709\U9650\U516c\U53f8";
 producer = "\U77f3\U836f\U96c6\U56e2\U4e2d\U8bfa\U836f\U4e1a\Uff08\U77f3\U5bb6\U5e84\Uff09\U6709\U9650\U516c\U53f8";
 protocoltype = 1;
 provider = 4;
 rationer = 4;
 retailprice = "55.0000";
 sellprice = "55.0000";
 sortid = 1;
 spec = "0.5g\U00d71";
 totalcount = 4;
 useunit = "\U74f6";
 }

 */
@property (nonatomic,strong) NSString* CorpName;//-- 供应商名称
@property (nonatomic,strong) NSString* Summoney;//-- 总金额
@property (nonatomic,strong) NSString* amount;//-- 数量
@property (nonatomic,strong) NSString* goodsid;//-- 货品id
@property (nonatomic,strong) NSString* goodsname;//-- 货品名称
@property (nonatomic,strong) NSString* medicaltype;//-- 剂型
@property (nonatomic,strong) NSString* orderid;//-- 订单明细id
@property (nonatomic,strong) NSString* ordermemo;//-- 订单备注
@property (nonatomic,strong) NSString* orderno;//-- 订单总单编号
@property (nonatomic,strong) NSString* ordersums;//-- 单个品种订单总金额
@property (nonatomic,strong) NSString* prodarea;//-- 厂地
@property (nonatomic,strong) NSString* producer;//-- 生产厂家
@property (nonatomic,strong) NSString* protocoltype;//-- 订单类型 4促销
@property (nonatomic,strong) NSString* provider;//-- 供应商id
@property (nonatomic,strong) NSString* rationer;//-- 配送商id
@property (nonatomic,strong) NSString* retailprice;//-- 零售价格
@property (nonatomic,strong) NSString* sellprice; //-- 销售价格
@property (nonatomic,strong) NSString* sortid; //-- 序列号
@property (nonatomic,strong) NSString* spec; //-- 规格
@property (nonatomic,strong) NSString* totalcount; //--
@property (nonatomic,strong) NSString* useunit; //-- 单位

@property (nonatomic,assign) BOOL isSelect;//购物车中是否被选择

@end
