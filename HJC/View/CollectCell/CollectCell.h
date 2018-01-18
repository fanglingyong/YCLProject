//
//  CollectCell.h
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"

@protocol CollectCancelDelegate <NSObject>

@optional
-(void)deleteCollectAction:(NSInteger)row;

@end

@interface CollectCell : UITableViewCell

@property(nonatomic,strong)CollectModel *model;
@property (nonatomic,weak) id<CollectCancelDelegate> delegate;
@property (nonatomic,assign) NSInteger thisRow;

@end
