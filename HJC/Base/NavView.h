//
//  NavView.h
//  JieBa
//
//  Created by zhifu360 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavView : UIView
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
+(NavView *)initNavView;
@end
