//
//  ProcurementCell.h
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcurementModel.h"

@protocol ProcurementCellDelegate <NSObject>
-(void)addShoppingCartClick:(NSInteger)index;

@end

@interface ProcurementCell : UITableViewCell
@property(nonatomic,strong)ProcurementModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<ProcurementCellDelegate>delegate;

@end

