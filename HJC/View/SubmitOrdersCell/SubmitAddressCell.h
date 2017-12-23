//
//  SubmitAddressCell.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitAddressModel.h"

@interface SubmitAddressCell : UITableViewCell

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *phone;

@property (nonatomic,strong) SubmitAddressModel *model;

@end
