//
//  ShoppingCartFooterView.m
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartFooterView.h"

@interface ShoppingCartFooterView()

@property (nonatomic, retain)UIImageView *selectImageView;
@property (nonatomic, retain)UILabel *allSelectLabel;

@property (nonatomic, retain)UILabel *allMeterLabel;
@property (nonatomic, retain)UILabel *canUseLabel;

@property (nonatomic, retain)UIButton *payButton;

@end

@implementation ShoppingCartFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContantView];
    }
    return self;
}


- (void)loadContantView {
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(7), HeightXiShu(7), WidthXiShu(18), HeightXiShu(18))];
    self.selectImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
    self.selectImageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.selectImageView];


    
    self.allSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5), HeightXiShu(25), WidthXiShu(30), HeightXiShu(12))];
    self.allSelectLabel.text = @"全选";
    self.allSelectLabel.textColor = TitleColor;
    self.allSelectLabel.font = HEITI(HeightXiShu(9));
    [self addSubview: self.allSelectLabel];
    
    self.allMeterLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(45), 0, WidthXiShu(150), HeightXiShu(22))];
    self.allMeterLabel.text = @"合计：￥322.03";
    self.allMeterLabel.textColor = TitleColor;
    self.allMeterLabel.font = HEITI(HeightXiShu(13));
    [self addSubview: self.allMeterLabel];
    
    self.canUseLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(45), HeightXiShu(22), WidthXiShu(150), HeightXiShu(22))];
    self.canUseLabel.text = @"可用积分：￥199.86";
    self.canUseLabel.textColor = TitleColor;
    self.canUseLabel.font = HEITI(HeightXiShu(13));
    [self addSubview: self.canUseLabel];
    
  
    
    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payButton.frame = CGRectMake(kScreenWidth - WidthXiShu(100), 0, WidthXiShu(100), HeightXiShu(45));
    [self.payButton setTitle:@"去结算 >>" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:(UIControlState)UIControlStateNormal];
    self.payButton.backgroundColor = NavColor;
    [self.payButton addTarget:self action:@selector(addShoppingCartBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.payButton];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
