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

@property(nonatomic,strong)UIButton *introduceBtn;
//@property(nonatomic,strong)UIButton *gojiltBtn;
@property(nonatomic,strong)UIButton *carInsurance;


@property(nonatomic,strong)UIButton *creditBtn;
@property(nonatomic,strong)UIButton *carloansBtn;

@property(nonatomic,strong)UIButton *carrentBtn;
@property(nonatomic,strong)UIButton *contactBtn;
@property(nonatomic,strong)UIButton *dddBtn;
@property(nonatomic,strong)UIButton *ffffBtn;


@property(nonatomic,strong)UIButton *assessBtn;
@property(nonatomic,strong)UIButton *businessBtn;


@property(nonatomic,strong)UIButton *loanBtn;
@property(nonatomic,strong)UIButton *rentBtn;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,weak)id<MainButtonCellDelegate>delegate;
@end
