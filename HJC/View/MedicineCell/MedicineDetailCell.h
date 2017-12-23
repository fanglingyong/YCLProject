//
//  MedicineDetailCell.h
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineDetailModel.h"
@interface MedicineDetailCell : UITableViewCell

@property(nonatomic,strong)MedicineDetailModel *model;
@property (nonatomic,assign) NSInteger num;

@end
