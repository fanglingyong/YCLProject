//
//  DatePickeView.m
//  SmartCar
//
//  Created by 智富360 on 16/5/24.
//  Copyright © 2016年 ZhiQiao. All rights reserved.
//

#import "DatePickeView.h"

@implementation DatePickeView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.cancleButton];
        [self addSubview:self.sureButton];
        [self addSubview:self.datePicker];
        self.formatter = [[NSDateFormatter alloc]init];
        [self.formatter setDateFormat:@"yyyy-MM-dd"];
        _time = [self.formatter stringFromDate:self.datePicker.date];
        NSLog(@"%@",_time);
    }
    return self;
}

-(UIButton*)cancleButton{
    if (!_datePicker){
        _cancleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(WidthXiShu(8), HeightXiShu(5), WidthXiShu(50), HeightXiShu(30));
        [_cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _cancleButton.backgroundColor = [UIColor clearColor];
        _cancleButton.titleLabel.font = HEITI(HeightXiShu(14));
    }
    return _cancleButton;
}

-(UIButton*)sureButton{
    if (!_datePicker){
        _sureButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(kScreenWidth - WidthXiShu(8) - WidthXiShu(50), HeightXiShu(5), WidthXiShu(50), HeightXiShu(30));
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = HEITI(HeightXiShu(14));
        _sureButton.backgroundColor = [UIColor clearColor];
    }
    return _sureButton;
}

-(UIDatePicker*)datePicker{
    if (!_datePicker){
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.frame.size.height - HeightXiShu(140), kScreenWidth, HeightXiShu(150))];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = local;
        [_datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
        
    }
     return _datePicker;
}

-(UILabel*)titleLabel{
    if (!_datePicker){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth  / 2 - WidthXiShu(100), HeightXiShu(5), WidthXiShu(200), HeightXiShu(25))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}


#pragma mark--左边按钮点击事件
-(void)cancleButtonClick:(UIButton*)but{
    if ([self.delegate respondsToSelector:@selector(cancleButtonClickDelegate)]) {
        [self.delegate cancleButtonClickDelegate];
    }
}

#pragma mark--右边按钮点击事件
-(void)sureButtonClick:(UIButton*)but{
    if ([self.delegate respondsToSelector:@selector(sureButtonClickDelegate)]) {
        _time = [self.formatter stringFromDate:self.datePicker.date];
        [self.delegate sureButtonClickDelegate];
    }
}

-(void)dateChange:(UIDatePicker*)date{
  _time = [self.formatter stringFromDate:date.date];
    NSLog(@"——————————————%@",_time);
}

@end
