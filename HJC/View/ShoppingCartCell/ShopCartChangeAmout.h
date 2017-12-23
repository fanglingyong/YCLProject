//
//  ShopCartChangeAmout.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCartChangeAmoutBlock)(NSInteger amout);

@interface ShopCartChangeAmout : UIView

@property (nonatomic,strong) UITextField *amoutTf;
@property (nonatomic,strong) UIButton *numAddBtn;
@property (nonatomic,strong) UIButton *numSubBtn;
@property (nonatomic,strong) UIButton *successBtn;

@property (nonatomic,strong) UILabel *goosInfo;
@property (nonatomic,assign) NSInteger numCount;
@property (nonatomic,assign) NSInteger newCount;

@property (nonatomic,copy) ShopCartChangeAmoutBlock block;

-(void)setGoodsInfo:(NSString*)info count:(NSInteger)count block:(ShopCartChangeAmoutBlock)compleBlock;

@end
