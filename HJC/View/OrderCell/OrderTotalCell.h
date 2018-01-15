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

@property (nonatomic,strong) OrderTotalModel *model;


@end
@interface OrderTotalGoodListCell : UITableViewCell

@property (nonatomic,strong) OrderGoodsListModel *model;
@property (nonatomic,strong) UIView *cellView;
@property (nonatomic,strong) UILabel *idd;
@property (nonatomic,strong) UILabel *goodName;
@property (nonatomic,strong) UILabel *countNum;
@property (nonatomic,strong) UILabel *momeyNum;
@property (nonatomic,assign) NSInteger iddNum;
@end


#pragma mark - 细单

#import "OrderModel.h"

@interface OrderDetailInfoCell : UITableViewCell

@property(nonatomic,strong)OrderModel *model;

@end

@interface OrderDetailOrderNumCell : UITableViewCell

@property (nonatomic,strong) UILabel *orderNum;
@property (nonatomic,strong) UILabel *status;

@end

@interface OrderDetailPublicCell : UITableViewCell

@property (nonatomic,strong) UILabel *titlelb;
@property (nonatomic,strong) UILabel *contentlb;

@end

