//
//  CollectModel.h
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject

@property (nonatomic,strong) NSString*sortid;//            --序列号
@property (nonatomic,strong) NSString*provider;//            --供应商ID
@property (nonatomic,strong) NSString*GoodsID;//            --货品ID
@property (nonatomic,strong) NSString*GoodsCode;//            --货品编码
@property (nonatomic,strong) NSString*asprice;//            --供应价格
@property (nonatomic,strong) NSString*arprice;//            --零售价
@property (nonatomic,strong) NSString*CorpName;//        --供应商
@property (nonatomic,strong) NSString*goodsname;//        --商品名称
@property (nonatomic,strong) NSString*CommonName;//        --通用名
@property (nonatomic,strong) NSString*Spec;//            --规格
@property (nonatomic,strong) NSString*Medicaltype;//    --剂型
@property (nonatomic,strong) NSString*producer;//        --生产厂家
@property (nonatomic,strong) NSString*useunit;//        --计量单位
@property (nonatomic,strong) NSString*ViewQty;//        --库存
@property (nonatomic,strong) NSString*PackNum;//        --包装数
@property (nonatomic,strong) NSString*goodspic;// --
@property (nonatomic,strong) NSString*totalcount;// --

@end
