//
//  OrderTotalCell.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTotalModel.h"

@interface OrderTotalCell : UITableViewCell

@property (nonatomic,strong) UILabel *orderID;
@property (nonatomic,strong) UILabel *createTime;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *ordersum;
@property (nonatomic,strong) OrderTotalModel *model;
@property (nonatomic,strong) UIView *cellView;


@end

#import "OrderModel.h"

@interface OrderDetailInfoCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end
