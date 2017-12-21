//
//  ProcurementModel.h
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcurementModel : NSObject

/**
 "totalcount": "999",
 "sortid": "1", -- 序列号
 "provider": "4",
 "GoodsID": "3",
 "GoodsCode": "3",
 "asprice": "55.0000",
 "arprice": "55.0000",
 "CorpName": "华东医药股份有限公司",
 "goodsname": "注射用青霉素钠",
 "CommonName": "注射用青霉素钠",
 "Spec": "0.48g(80万单位)（50瓶/盒）",
 "Medicaltype": "0",
 "producer": "★华北制药股份有限公司",
 "useunit": "瓶",
 "ViewQty": "0",
 "PackNum": "0",
 "PICNAME": ""
 */

@property(nonatomic,copy)NSString * totalcount; //--
@property(nonatomic,copy)NSString * sortid;//-- 序列号
@property(nonatomic,copy)NSString * provider; //-- 供应商id
@property(nonatomic,copy)NSString * GoodsID; //-- 货品id
@property(nonatomic,copy)NSString * GoodsCode; //-- 货品编码
@property(nonatomic,copy)NSString * asprice; //-- 供应价格
@property(nonatomic,copy)NSString * arprice; //-- 零售价
@property(nonatomic,copy)NSString * CorpName; //-- 供应商名称
@property(nonatomic,copy)NSString * goodsname; //-- 商品名称
@property(nonatomic,copy)NSString * CommonName; //-- 通用名
@property(nonatomic,copy)NSString * Spec; //-- 规格
@property(nonatomic,copy)NSString * Medicaltype; //-- 剂型
@property(nonatomic,copy)NSString * producer; //-- 厂家
@property(nonatomic,copy)NSString * useunit; //-- 计量单位
@property(nonatomic,copy)NSString * ViewQty; //-- 库存
@property(nonatomic,copy)NSString * PackNum; //-- 包装数
@property(nonatomic,copy)NSString * PICNAME; //-- 商品图片名称

-(NSMutableDictionary *)returnToDictionaryWithModel;

@end
