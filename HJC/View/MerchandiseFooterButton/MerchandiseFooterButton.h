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
- (void)didOftenBuyListButton:(UIButton *)button;
- (void)didCustomerServiceButton:(UIButton *)button;
- (void)didShoppingCartButton:(UIButton *)button;
- (void)didAddShoppingCartButton:(UIButton *)button;
@end

@interface MerchandiseFooterButton : UIView

@property (nonatomic, retain)UIImageView *oftenBuyListIMG;
@property (nonatomic, retain)UIButton *oftenBuyListBtn;
@property (nonatomic, retain)UILabel *oftenBuyListLB;
@property (nonatomic, retain)NSString *oftenBuyListTitle;

@property (nonatomic, retain)UIImageView *customerServiceIMG;
@property (nonatomic, retain)UIButton *customerServiceBtn;
@property (nonatomic, retain)UILabel *customerServiceLB;

@property (nonatomic, retain)UIImageView *shoppingCartIMG;
@property (nonatomic, retain)UIButton *shoppingCartBtn;
@property (nonatomic, retain)UILabel *shoppingCartLB;
@property (nonatomic, retain)UILabel *shoppingCartCornerLB;
@property (nonatomic, retain)NSString *shoppingCartCornerTitle;

@property (nonatomic, retain)UIButton *addShoppingCartBtn;

@property (nonatomic, assign) id <MerchandiseFooterButtonDelegate>delegate;

@end
