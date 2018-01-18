//
//  MyCenterButton.m
//  HJC
//
//  Created by zhifu360 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyCenterButton.h"

@implementation MyCenterButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContantView];
    }
    return self;
}


- (void)loadContantView {
    
    self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bgButton.backgroundColor = [UIColor clearColor];
    [self.bgButton addTarget:self action:@selector(bgBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.bgButton];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(20), HeightXiShu(10), self.frame.size.width - WidthXiShu(40), HeightXiShu(30))];
    self.imageView.image = [GetImagePath getImagePath:@"tabbar_myCenter_gray"];
    [self addSubview:self.imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(0), HeightXiShu(40), self.frame.size.width, HeightXiShu(30))];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor blackColor];
    self.label.font = HEITI(HeightXiShu(14));
    [self addSubview: self.label];
    
    
    
    
}
- (void)setLabelTitle:(NSString *)labelTitle {
    _labelTitle = labelTitle;
    if (labelTitle) {
        self.label.text = labelTitle;
    }
}

- (void)bgBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didMyCenterButton:)]) {
        [self.delegate didMyCenterButton:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
