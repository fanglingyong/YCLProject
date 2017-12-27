//
//  DatePickeView.h
//  SmartCar
//
//  Created by 智富360 on 16/5/24.
//  Copyright © 2016年 ZhiQiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickeViewDelegate <NSObject>

-(void)cancleButtonClickDelegate;
-(void)sureButtonClickDelegate;

@end

@interface DatePickeView : UIView
@property (nonatomic,weak)id<DatePickeViewDelegate>delegate;
@property(nonatomic,strong)UIButton *cancleButton;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSDateFormatter *formatter;
@end
