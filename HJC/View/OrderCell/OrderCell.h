//
//  OrderCell.h
//  HJC
//
//  Created by zhifu360 on 2017/11/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderListCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end


@interface OrderDetailCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end

@interface OrderAddressCell : UITableViewCell

@property(nonatomic,strong)UILabel *addressTitleLb;  //收货地址
@property(nonatomic,strong)UILabel *nameLb;  //姓名
@property(nonatomic,strong)UILabel *phoneLb;  //电话
@property(nonatomic,strong)UILabel *addressLb;  //地址

@property(nonatomic,strong)UILabel *remarkTitleLb;  //备注
@property(nonatomic,strong)UILabel *remarkLb; // 备注详情

@property(nonatomic,strong)OrderModel *model;

@end

@interface OrderPriceInfoCell : UITableViewCell

@property(nonatomic,strong)UILabel *saleLb;  //优惠促销
@property(nonatomic,strong)UILabel *actualLb; // 实付款
@property(nonatomic,strong)UILabel *salePriceLb;  //优惠促销
@property(nonatomic,strong)UILabel *actualPriceLb; // 实付款

@property(nonatomic,strong)OrderModel *model;

@end

@interface OrderTimeCell : UITableViewCell

@property(nonatomic,strong)UILabel *orderTimeLb;  //优惠促销
@property(nonatomic,strong)UILabel *deliveryTimeLb; // 实付款
@property(nonatomic,strong)UILabel *receiveTimeLb;  //优惠促销

@property(nonatomic,strong)OrderModel *model;

@end

