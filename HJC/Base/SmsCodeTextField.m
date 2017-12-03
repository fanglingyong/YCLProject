//
//  SmsCodeTextField.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "SmsCodeTextField.h"

@implementation SmsCodeTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(38, 0, frame.size.width-128, 30)];
        self.textField.font = [UIFont systemFontOfSize:15];
        [_textField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        
        self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        self.smsBtn = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-90, 0, 80, 30)];
        _smsBtn.text = @"获取验证码";
        _smsBtn.userInteractionEnabled = YES;
        _smsBtn.layer.borderWidth = 1;
        _smsBtn.layer.borderColor = [sysBlue CGColor];
        _smsBtn.clipsToBounds = YES;
        _smsBtn.layer.cornerRadius = 3.0f;
        _smsBtn.textAlignment = NSTextAlignmentCenter;
        _smsBtn.font = [UIFont systemFontOfSize:14];
        UITapGestureRecognizer *tap_gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getSmsCodeToServer)];
        [_smsBtn addGestureRecognizer:tap_gr];
        
        
        self.partingLine = [[UIView alloc] initWithFrame:CGRectMake(0, 34, frame.size.width, 1)];
        _partingLine.backgroundColor = [UIColor colorFromHexCode:@"#dfdfdd"];
        
        [self addSubview:_leftView];
        [self addSubview:_textField];
        [self addSubview:_smsBtn];
        [self addSubview:_partingLine];
    }
    return self;
}

-(void)getSmsCodeToServer{
    NSLog(@"获取验证码");
    _smsBtn.text = @"120秒";
    _smsBtn.userInteractionEnabled = NO;
}
@end
