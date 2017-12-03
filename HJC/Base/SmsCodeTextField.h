//
//  SmsCodeTextField.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmsCodeTextField : UIView

@property (nonatomic,strong) UIImageView *leftView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *smsBtn;
@property (nonatomic,strong) UIView *partingLine;// parting line

/**
 init
 
 @param frame height default is 35 .
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame;

@end
