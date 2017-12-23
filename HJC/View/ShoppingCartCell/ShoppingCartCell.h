//
//  ShoppingCartCell.h
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@protocol ShopCartCellDelegate <NSObject>

-(void)updateCellForData:(NSInteger)row;
-(void)deleteThisCell:(NSInteger)row;
-(void)changeOrderDetail:(NSInteger)row oldCount:(NSString*)oldCount;
@end

@interface ShoppingCartCell : UITableViewCell

@property(nonatomic,strong)ShoppingCartModel *model;
@property (nonatomic,weak) id<ShopCartCellDelegate> delegate;
@property (nonatomic,assign) NSInteger row;

@end
