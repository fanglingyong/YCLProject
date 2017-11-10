//
//  CycleScrollView.h
//  zhifu360
//
//  Created by zhifu on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 滚动Banner控件
 */
@interface CycleScrollView : UIView
@property (nonatomic , strong) UIScrollView *scrollView;
@property(nonatomic,assign)BOOL ISSINGLE;

/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration andIsSingle:(BOOL)ISSINGLE;
/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@property (nonatomic , copy) void (^CurrentPageBlock)(NSInteger pageIndex);

@end