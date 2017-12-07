//
//  MerchandiseFooterButton.h
//  HJC
//
//  Created by zhifu360 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MerchandiseFooterButton;

@protocol MerchandiseFooterButtonDelegate <NSObject>
- (void)didCollectBtn:(UIButton *)button;
- (void)didAddShopCartBtn:(UIButton *)button;
- (void)didProcurementBtn:(UIButton *)button;
@end

@interface MerchandiseFooterButton : UIView

@property (nonatomic, retain)UILabel *totalLB;

@property (nonatomic, retain)UIImageView *lineHView;
@property (nonatomic, retain)UIImageView *lineZView;

@property (nonatomic, retain)UIImageView *collectImg;

@property (nonatomic, retain)UIButton *collectBtn;
@property (nonatomic, retain)UIButton *addShopCartBtn;
@property (nonatomic, retain)UIButton *procurementBtn;


@property (nonatomic, assign) id <MerchandiseFooterButtonDelegate>delegate;

@end
