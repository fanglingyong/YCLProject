//
//  MerchandiseFooterButton.m
//  HJC
//
//  Created by zhifu360 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MerchandiseFooterButton.h"
@implementation MerchandiseFooterButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContantView];
    }
    return self;
}

- (void)loadContantView {
    
    self.oftenBuyListIMG = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(25), HeightXiShu(5), WidthXiShu(30), HeightXiShu(30))];
    self.oftenBuyListIMG.image = [GetImagePath getImagePath:@"tabbar_myCenter_gray"];
    [self addSubview:self.oftenBuyListIMG];

    self.oftenBuyListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.oftenBuyListBtn.frame = CGRectMake(0, 0, WidthXiShu(80), HeightXiShu(55));
    self.oftenBuyListBtn.backgroundColor = [UIColor clearColor];
    [self.oftenBuyListBtn addTarget:self action:@selector(oftenBuyListBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.oftenBuyListBtn];
    
    self.oftenBuyListLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), WidthXiShu(80), HeightXiShu(15))];
    self.oftenBuyListLB.text = @"加常购清单";
    self.oftenBuyListLB.textAlignment = NSTextAlignmentCenter;
    self.oftenBuyListLB.textColor = [UIColor blackColor];
    self.oftenBuyListLB.font = HEITI(HeightXiShu(12));
    [self addSubview: self.oftenBuyListLB];
    
    
    self.customerServiceIMG = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(5), WidthXiShu(30), HeightXiShu(30))];
    self.customerServiceIMG.image = [GetImagePath getImagePath:@"tabbar_myCenter_gray"];
    [self addSubview:self.customerServiceIMG];
    
    self.customerServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customerServiceBtn.frame = CGRectMake(WidthXiShu(80), 0, WidthXiShu(75), HeightXiShu(55));
    self.customerServiceBtn.backgroundColor = [UIColor clearColor];
    [self.customerServiceBtn addTarget:self action:@selector(customerServiceBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.customerServiceBtn];
    
    self.customerServiceLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(80), HeightXiShu(40), WidthXiShu(75), HeightXiShu(15))];
    self.customerServiceLB.text = @"联系客服";
    self.customerServiceLB.textAlignment = NSTextAlignmentCenter;
    self.customerServiceLB.textColor = [UIColor blackColor];
    self.customerServiceLB.font = HEITI(HeightXiShu(12));
    [self addSubview: self.customerServiceLB];
    
    self.shoppingCartIMG = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(175), HeightXiShu(5), WidthXiShu(30), HeightXiShu(30))];
    self.shoppingCartIMG.image = [GetImagePath getImagePath:@"tabbar_myCenter_gray"];
    [self addSubview:self.shoppingCartIMG];
    
    self.shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shoppingCartBtn.frame = CGRectMake(WidthXiShu(155), 0, WidthXiShu(80), HeightXiShu(55));
    self.shoppingCartBtn.backgroundColor = [UIColor clearColor];
    [self.shoppingCartBtn addTarget:self action:@selector(shoppingCartBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.shoppingCartBtn];
    
    self.shoppingCartLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(150), HeightXiShu(40), WidthXiShu(80), HeightXiShu(15))];
    self.shoppingCartLB.text = @"购物车";
    self.shoppingCartLB.textAlignment = NSTextAlignmentCenter;
    self.shoppingCartLB.textColor = [UIColor blackColor];
    self.shoppingCartLB.font = HEITI(HeightXiShu(12));
    [self addSubview: self.shoppingCartLB];
    
    self.shoppingCartCornerLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(205), 0, WidthXiShu(16), HeightXiShu(16))];
    self.shoppingCartCornerLB.text = @"4";
    self.shoppingCartCornerLB.layer.masksToBounds = YES;
    self.shoppingCartCornerLB.layer.cornerRadius = HeightXiShu(8);
    self.shoppingCartCornerLB.layer.borderWidth = HeightXiShu(1);
    self.shoppingCartCornerLB.layer.borderColor = AllRedColor.CGColor;
    self.shoppingCartCornerLB.textAlignment = NSTextAlignmentCenter;
    self.shoppingCartCornerLB.textColor = [UIColor blackColor];
    self.shoppingCartCornerLB.font = HEITI(HeightXiShu(9));
    [self addSubview: self.shoppingCartCornerLB];
    
    self.addShoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addShoppingCartBtn.frame = CGRectMake(WidthXiShu(235), 0, kScreenWidth - WidthXiShu(235), HeightXiShu(55));
    [self.addShoppingCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addShoppingCartBtn setTitleColor:[UIColor whiteColor] forState:(UIControlState)UIControlStateNormal];
    self.addShoppingCartBtn.backgroundColor = AllRedColor;
    [self.addShoppingCartBtn addTarget:self action:@selector(addShoppingCartBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.addShoppingCartBtn];
    
}

- (void)setOftenBuyListTitle:(NSString *)oftenBuyListTitle {
    _oftenBuyListTitle = oftenBuyListTitle;
    if (oftenBuyListTitle) {
        self.oftenBuyListLB.text = oftenBuyListTitle;
    }
}

- (void)setShoppingCartCornerTitle:(NSString *)shoppingCartCornerTitle {
    _shoppingCartCornerTitle = shoppingCartCornerTitle;
    if (shoppingCartCornerTitle) {
        self.shoppingCartCornerLB.text = shoppingCartCornerTitle;
    }
    
}

- (void)oftenBuyListBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didOftenBuyListButton:)]) {
        [self.delegate didOftenBuyListButton:sender];
    }
}

- (void)customerServiceBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCustomerServiceButton:)]) {
        [self.delegate didCustomerServiceButton:sender];
    }
}

- (void)shoppingCartBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShoppingCartButton:)]) {
        [self.delegate didShoppingCartButton:sender];
    }
}

- (void)addShoppingCartBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddShoppingCartButton:)]) {
        [self.delegate didAddShoppingCartButton:sender];
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
