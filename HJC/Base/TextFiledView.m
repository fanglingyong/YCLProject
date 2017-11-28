//
//  TextFiledView.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/27.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "TextFiledView.h"

@interface TextFiledView ()


@end

@implementation TextFiledView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(38, 0, frame.size.width-38, 30)];
        self.textField.font = [UIFont systemFontOfSize:15];
        [_textField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

        self.leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.partingLine = [[UIView alloc] initWithFrame:CGRectMake(0, 34, frame.size.width, 1)];
        _partingLine.backgroundColor = [UIColor colorFromHexCode:@"#dfdfdd"];
        
        [self addSubview:_leftView];
        [self addSubview:_textField];
        [self addSubview:_partingLine];
    }
    return self;
}

@end
