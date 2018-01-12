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

@property(nonatomic,strong)UIButton *chemicalBtn;
@property(nonatomic,strong)UIButton *middleBtn;
@property(nonatomic,strong)UIButton *careBtn;
@property(nonatomic,strong)UIButton *integralBtn;
@property(nonatomic,strong)UIButton *salesBtn;

@property(nonatomic,strong)UILabel *chemicalLb;
@property(nonatomic,strong)UILabel *middleLb;
@property(nonatomic,strong)UILabel *careLb;
@property(nonatomic,strong)UILabel *integralLb;
@property(nonatomic,strong)UILabel *salesLb;

@property(nonatomic,weak)id<MainButtonCellDelegate>delegate;
@end
