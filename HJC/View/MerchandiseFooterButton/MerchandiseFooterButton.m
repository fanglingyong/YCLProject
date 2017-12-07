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
    
    self.lineHView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - WidthXiShu(160), .5)];
    self.lineHView.backgroundColor = AllLightGrayColor;
    [self addSubview:self.lineHView];
    
    self.totalLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5), 0, WidthXiShu(150), HeightXiShu(50))];
    self.totalLB.text = @"总计:$39.00";
    self.totalLB.textColor = BlackColor;
    self.totalLB.font = HEITI(HeightXiShu(15));
    [self addSubview: self.totalLB];
    
    self.lineZView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(156), 0, 1, HeightXiShu(50))];
    self.lineZView.backgroundColor = AllLightGrayColor;
    [self addSubview:self.lineZView];
    
    self.collectImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(183) - WidthXiShu(10), HeightXiShu(15), WidthXiShu(20), HeightXiShu(20))];
    self.collectImg.image = [GetImagePath getImagePath:@"detail_collect"];
    [self addSubview:self.collectImg];

    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(160) - WidthXiShu(50), 0, WidthXiShu(50), HeightXiShu(50));
    self.collectBtn.backgroundColor = [UIColor clearColor];
    [self.collectBtn addTarget:self action:@selector(collectBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.collectBtn];
    
    self.addShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addShopCartBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(160), 0, WidthXiShu(80), HeightXiShu(50));
    self.addShopCartBtn.backgroundColor = [UIColor colorFromHexCode:@"#98999a"];
    [self.addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addShopCartBtn.titleLabel.font = HEITI(HeightXiShu(14));
    [self.addShopCartBtn addTarget:self action:@selector(addShopCartBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.addShopCartBtn];
    
    self.procurementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.procurementBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(80), 0, WidthXiShu(80), HeightXiShu(50));
    self.procurementBtn.backgroundColor = [UIColor colorFromHexCode:@"#4172e4"];
    [self.procurementBtn setTitle:@"立即采购" forState:UIControlStateNormal];
    [self.procurementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.procurementBtn.titleLabel.font = HEITI(HeightXiShu(14));
    [self.procurementBtn addTarget:self action:@selector(procurementBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.procurementBtn];
    

    
}

- (void)collectBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCollectBtn:)]) {
        [self.delegate didCollectBtn:sender];
    }
}

- (void)addShopCartBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddShopCartBtn:)]) {
        [self.delegate didAddShopCartBtn:sender];
    }
}

- (void)procurementBtnPressed:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didProcurementBtn:)]) {
        [self.delegate didProcurementBtn:sender];
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
