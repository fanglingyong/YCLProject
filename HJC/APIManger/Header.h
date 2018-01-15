//
//  Header.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#ifndef Header_h
#define Header_h

//host path
#define HostPath @"http://120.26.97.79/WebApi/api"

//注册
#define RegisterURL @"/NewPerson"
//登陆
#define LoginURL @"/v6_Login"
//注册诊所
#define RegClinicURL @"/BTN_CORP_INFO_SAVE"
//绑定诊所
#define BindClinicURL @"/BTN_CORP_USE_SAVE"
//维护收货地址
#define UpdateCorpAddressURL @"/BTN_CORPADDRESS_INFO_SAVE"
//获取收货地址列表
#define GetCorpAddressURL @"/QN_CORPADDRESS_LIST"
//获取采购货品列表
#define GetGoodsListURL @"/QN_GOODS_LIST_FORORDER"
//加入购物车
#define JoinShopCarURL @"/BTN_VECHILE_ITEM_OPERATER"
//生成订单
#define ProOrderURL @"/BTN_ORDER_GEN_FROM_VEHICLE"
//获取购物车信息
#define GetShopCarInfo @"/QN_VEHICLE_LIST_STD"
//获取供应商信息
#define GetHostInfo @"/Producer"
//获取诊所列表
#define GetClinicList @"/Custom"
//上传文件
#define UploadClinicImages @"/File"
//加入收藏夹
#define JoinCollect @"/BTN_CORP_BUYGOODS_SAVE"
//获得收藏夹信息
#define GetCollect @"/QN_CUSTOMGOODS_FORORDER_STD"
//获取总单信息
#define GetOdersNo @"/QN_ORDER_LIST_DOC"
//获取细单信息
#define GetOrderDetail @"/QN_ORDER_LIST_DETAIL"
//首页活动专区 推荐品种
#define GetHomeList @"/QN_GOODS_LIST_INDEX_HEAD?UserID=0"

#endif /* Header_h */

