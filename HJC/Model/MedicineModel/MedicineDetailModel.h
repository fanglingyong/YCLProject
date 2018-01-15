//
//  MedicineDetailModel.h
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineDetailModel : NSObject

@property(nonatomic,copy)NSString * PRICE; //--折后价
@property(nonatomic,copy)NSString * CORPID; //-- 供应商id
@property(nonatomic,copy)NSString * GOODSID; //-- 货品id
@property(nonatomic,copy)NSString * RETAILPRICE; //-- 零售价
@property(nonatomic,copy)NSString * SELLPRICE; //-- 医保支付价
@property(nonatomic,copy)NSString * CORPNAME; //-- 供应商名称
@property(nonatomic,copy)NSString * GOODSNAME; //-- 商品名称
@property(nonatomic,copy)NSString * SPEC; //-- 规格
@property(nonatomic,copy)NSString * PRODUCER; //-- 厂家
@property(nonatomic,copy)NSString * CALCUNIT; //-- 计量单位
@property(nonatomic,copy)NSString * viewqty; //-- 库存
@property(nonatomic,copy)NSString * GOODSPIC; //-- 商品图片名称

@end
