//
//  MedicineBreedCell.h
//  HJC
//
//  Created by zhifu360 on 2017/10/23.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineBreesModel.h"

@protocol MedicineBreedCellDelegate <NSObject>
-(void)addShoppingCartClick:(NSInteger)index;

@end

@interface MedicineBreedCell : UITableViewCell
@property(nonatomic,strong)MedicineBreesModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<MedicineBreedCellDelegate>delegate;

@end
