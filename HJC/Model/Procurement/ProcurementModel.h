//
//  ProcurementModel.h
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcurementModel : NSObject

@property(nonatomic,copy)NSString * CommonName; //-- 通用名
@property(nonatomic,copy)NSString * CorpName; //-- 供应商名称
@property(nonatomic,copy)NSString * GoodsCode; //-- 货品编码
@property(nonatomic,copy)NSString * GoodsID; //-- 货品id
@property(nonatomic,copy)NSString * Medicaltype; //-- 剂型
@property(nonatomic,copy)NSString * PICNAME; //-- 商品图片名称
@property(nonatomic,copy)NSString * PackNum; //-- 包装数
@property(nonatomic,copy)NSString * Spec; //-- 规格
@property(nonatomic,copy)NSString * ViewQty; //-- 库存
@property(nonatomic,copy)NSString * arprice; //-- 零售价
@property(nonatomic,copy)NSString * asprice; //-- 供应价格
@property(nonatomic,copy)NSString * goodsname; //-- 商品名称
@property(nonatomic,copy)NSString * goodspic;//货品图片
@property(nonatomic,copy)NSString * producer; //-- 厂家
@property(nonatomic,copy)NSString * provider; //-- 供应商id
@property(nonatomic,copy)NSString * sortid;//-- 序列号
@property(nonatomic,copy)NSString * totalcount; //--
@property(nonatomic,copy)NSString * useunit; //-- 计量单位

-(NSMutableDictionary *)returnToDictionaryWithModel;

@end
