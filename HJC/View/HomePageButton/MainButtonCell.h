//
//  MainButtonCell.h
//  JieBa
//
//  Created by chenchen on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainButtonCellDelegate <NSObject>
-(void)mainButtonClick:(NSInteger)index;
@end

@interface MainButtonCell : UIView
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIButton *preferentialBtn;
@property(nonatomic,strong)UIButton *worldBtn;
@property(nonatomic,strong)UIButton *integralBtn;
@property(nonatomic,strong)UIButton *pharmacyBtn;
@property(nonatomic,strong)UIButton *informationBtn;

@property(nonatomic,strong)UILabel *preferentialLb;
@property(nonatomic,strong)UILabel *worldLb;
@property(nonatomic,strong)UILabel *integralLb;
@property(nonatomic,strong)UILabel *pharmacyLb;
@property(nonatomic,strong)UILabel *informationLb;

@property(nonatomic,weak)id<MainButtonCellDelegate>delegate;
@end
