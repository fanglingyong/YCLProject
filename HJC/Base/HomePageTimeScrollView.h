//
//  HomePageTimeScrollView.h
//  JieBa
//
//  Created by zhifu360 on 17/3/6.
//  Copyright © 2017年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePageTimeScrollViewDelegate <NSObject>

- (void)didhomePageTimeScrollView:(NSInteger)index;

@end

@interface HomePageTimeScrollView : UIView

@property(nonatomic,copy)NSMutableArray *awardTitleArr;
@property (nonatomic, assign)id <HomePageTimeScrollViewDelegate>delegate;
@end
