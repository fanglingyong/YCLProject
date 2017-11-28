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

@interface OrderLogisticsInfoCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end


@interface OrderAddressCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end
