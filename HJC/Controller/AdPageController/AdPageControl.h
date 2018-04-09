//
//  AdPageControl.h
//  HJC
//
//  Created by 方灵勇 on 2018/4/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdPageControl : UIView

@property (nonatomic,strong) UIImageView *adPage;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIImageView *logo;
@property (nonatomic, assign) BOOL isValid;

@end
