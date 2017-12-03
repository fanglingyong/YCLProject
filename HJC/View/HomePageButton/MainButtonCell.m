//
//  MainButtonCell.m
//  JieBa
//
//  Created by chenchen on 16/10/16.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainButtonCell.h"

@implementation MainButtonCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self bgView];
        [self introduceBtn]; //介绍
//        [self gojiltBtn];    // 去甩单  车险 homePage_CarInsurance
        [self carInsurance];
        [self creditBtn];  // 现金贷
        [self carloansBtn]; // 车贷宝
        
        [self carrentBtn];  //车租宝
        [self contactBtn]; // 联系我们
        [self assessBtn]; // 爱车估价
        [self businessBtn]; // 招商加盟
        [self dddBtn];
        [self ffffBtn];

//        [self loanBtn];    // 车贷宝流程
//        [self rentBtn];  // 活动转区
//        [self moreBtn];    // 更多
    }
    return self;
}

-(UIView *)bgView{
    if(!_bgView){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIButton *)introduceBtn{
    if(!_introduceBtn){
        UIButton *introduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        introduceBtn.frame = CGRectMake(0, HeightXiShu(15), kScreenWidth/5, HeightXiShu(65));
        [introduceBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        introduceBtn.tag = 0;
        [introduceBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:introduceBtn];
        _introduceBtn = introduceBtn;
    }
    return _introduceBtn;
}

-(UIButton *)carInsurance{
    if(!_carInsurance){
        UIButton *carInsurance = [UIButton buttonWithType:UIButtonTypeCustom];
        carInsurance.frame = CGRectMake(self.introduceBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(65));
        [carInsurance setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        carInsurance.tag = 1;
        [carInsurance addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:carInsurance];
        _carInsurance = carInsurance;
    }
    return _carInsurance;
}

-(UIButton *)creditBtn{
    if(!_creditBtn){
        UIButton *creditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        creditBtn.frame = CGRectMake(self.carInsurance.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(65));
        [creditBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        creditBtn.tag = 2;
        [creditBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:creditBtn];
        _creditBtn = creditBtn;
    }
    return _creditBtn;
}

-(UIButton *)carloansBtn{
    if(!_carloansBtn){
        UIButton *carloansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        carloansBtn.frame = CGRectMake(self.creditBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(65));
        [carloansBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        carloansBtn.tag = 3;
        [carloansBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:carloansBtn];
        _carloansBtn = carloansBtn;
    }
    return _carloansBtn;
}

-(UIButton *)dddBtn{
    if(!_dddBtn){
        UIButton *dddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dddBtn.frame = CGRectMake(self.carloansBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(65));
        [dddBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        dddBtn.tag = 5;
        [dddBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:dddBtn];
        _dddBtn = dddBtn;
    }
    return _dddBtn;
}

-(UIButton *)carrentBtn{
    if(!_carrentBtn){
        UIButton *carrentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        carrentBtn.frame = CGRectMake(0, self.introduceBtn.maxY+HeightXiShu(17), kScreenWidth/5, HeightXiShu(65));
        [carrentBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        carrentBtn.tag = 4;
        [carrentBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:carrentBtn];
        _carrentBtn = carrentBtn;
    }
    return _carrentBtn;
}

-(UIButton *)contactBtn{
    if(!_contactBtn){
        UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        contactBtn.frame = CGRectMake(self.carrentBtn.maxX, self.introduceBtn.maxY+HeightXiShu(17), kScreenWidth/5, HeightXiShu(65));
        [contactBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        contactBtn.tag = 5;
        [contactBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:contactBtn];
        _contactBtn = contactBtn;
    }
    return _contactBtn;
}



-(UIButton *)assessBtn{
    if(!_assessBtn){
        UIButton *assessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        assessBtn.frame = CGRectMake(self.contactBtn.maxX, self.introduceBtn.maxY+HeightXiShu(17), kScreenWidth/5, HeightXiShu(65));
        [assessBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        assessBtn.tag = 6;
        [assessBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:assessBtn];
        _assessBtn = assessBtn;
    }
    return _assessBtn;
}

-(UIButton *)businessBtn{
    if(!_businessBtn){
        UIButton *businessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        businessBtn.frame = CGRectMake(self.assessBtn.maxX, self.introduceBtn.maxY+HeightXiShu(17), kScreenWidth/5, HeightXiShu(65));
        [businessBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        businessBtn.tag = 7;
        [businessBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:businessBtn];
        _businessBtn = businessBtn;
    }
    return _businessBtn;
}


-(UIButton *)ffffBtn{
    if(!_ffffBtn){
        UIButton *ffffBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ffffBtn.frame = CGRectMake(self.carloansBtn.maxX, self.dddBtn.maxY+HeightXiShu(17), kScreenWidth/5, HeightXiShu(65));
        [ffffBtn setImage:[GetImagePath getImagePath:@"add_L"] forState:UIControlStateNormal];
        ffffBtn.tag = 7;
        [ffffBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:ffffBtn];
        _ffffBtn = ffffBtn;
    }
    return _ffffBtn;
}
-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(mainButtonClick:)]){
        [self.delegate mainButtonClick:button.tag];
    }
}
@end
