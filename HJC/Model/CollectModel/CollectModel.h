//
//  CollectModel.h
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject
/*
 CommonName = "\U6ce8\U5c04\U7528\U6c28\U82c4\U897f\U6797\U94a0";
 CorpName = "\U534e\U4e1c\U533b\U836f\U80a1\U4efd\U6709\U9650\U516c\U53f8";
 GoodsCode = 17;
 GoodsID = 17;
 Medicaltype = 225;
 PICNAME = "";
 -PackNum = 0;
 -Spec = "1.0g\U00d71";
 -ViewQty = 0;
 -arprice = "55.0000";
 -asprice = "55.0000";
 -goodsname = "\U6ce8\U5c04\U7528\U6c28\U82c4\U897f\U6797\U94a0";
 -producer = "\U77f3\U836f\U96c6\U56e2\U4e2d\U8bfa\U836f\U4e1a\Uff08\U77f3\U5bb6\U5e84\Uff09\U6709\U9650\U516c\U53f8";
 -provider = 4;
 -sortid = 1;
 -totalcount = 2;
 -useunit = "\U74f6";
*/
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
@property (nonatomic,strong) NSString*PICNAME;// --
@property (nonatomic,strong) NSString*totalcount;// --

@end
