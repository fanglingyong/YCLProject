//
//  MainTableViewCell.h
//  HJC
//
//  Created by zhifu360 on 2018/1/11.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityZoneCellDelegate <NSObject>
-(void)activityButtonClick:(NSInteger)index;
@end

@interface ActivityZoneCell : UITableViewCell
@property (nonatomic, retain)NSMutableArray *array;
@property(nonatomic,weak)id<ActivityZoneCellDelegate>delegate;
- (void)setDate:(NSMutableArray *)array;
@end


@protocol RecommendVarietiesCellDelegate <NSObject>
-(void)recommendButtonClick:(NSInteger)index;
@end

@interface RecommendVarietiesCell : UITableViewCell
@property (nonatomic, retain)NSMutableArray *array;
@property(nonatomic,weak)id<RecommendVarietiesCellDelegate>delegate;
- (void)setDate:(NSMutableArray *)array;
@end
