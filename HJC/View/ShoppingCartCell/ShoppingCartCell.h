//
//  ShoppingCartCell.h
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, retain)UIView *footerView;
@property(nonatomic,strong)ShoppingCartModel *model;

@end
