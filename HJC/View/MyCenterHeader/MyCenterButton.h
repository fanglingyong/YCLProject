//
//  MyCenterButton.h
//  HJC
//
//  Created by zhifu360 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCenterButton;

@protocol MyCenterButtonDelegate <NSObject>
- (void)didMyCenterButton:(MyCenterButton *)myCenterButton;
@end

@interface MyCenterButton : UIView

@property (nonatomic, retain)UIImageView *imageView;
@property (nonatomic, retain)UIImageView *cornerImageView;
@property (nonatomic, retain)UILabel *label;
@property (nonatomic, retain)UIButton *bgButton;
@property (nonatomic, retain)NSString *labelTitle;

@property (nonatomic, assign) id <MyCenterButtonDelegate>delegate;

@end
