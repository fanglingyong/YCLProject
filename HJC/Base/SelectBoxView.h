//
//  SelectBoxView.h
//  HJC
//
//  Created by 方灵勇 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBoxView : UIView

@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,strong) UIColor *placeholderColor;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIColor *textColor;


- (instancetype)initWithFrame:(CGRect)frame;

@end
