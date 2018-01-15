//
//  MainTableViewCell.h
//  HJC
//
//  Created by zhifu360 on 2018/1/11.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActivityZoneCell : UITableViewCell
@property (nonatomic, retain)NSMutableArray *array;
- (void)setDate:(NSMutableArray *)array;
@end

@interface RecommendVarietiesCell : UITableViewCell
@property (nonatomic, retain)NSMutableArray *array;
- (void)setDate:(NSMutableArray *)array;
@end
