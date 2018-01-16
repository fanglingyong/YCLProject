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
        [self chemicalBtn];  //化学药
        [self middleBtn];    //中成药
        [self careBtn];      //保健品
        [self integralBtn];  //积分
        [self salesBtn];     //促销
        
        [self chemicalLb];  //化学药
        [self middleLb];    //中成药
        [self careLb];      //保健品
        [self integralLb];  //积分
        [self salesLb];     //促销
    }
    return self;
}

-(UIView *)bgView{
    if(!_bgView){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(100))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}
// 化学药
-(UIButton *)chemicalBtn{
    if(!_chemicalBtn){
        UIButton *chemicalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chemicalBtn.frame = CGRectMake(0, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [chemicalBtn setImage:[GetImagePath getImagePath:@"home_middle"] forState:UIControlStateNormal];
        chemicalBtn.tag = 0;
        [chemicalBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:chemicalBtn];
        _chemicalBtn = chemicalBtn;
    }
    return _chemicalBtn;
}

-(UILabel *)chemicalLb{
    if(!_chemicalLb){
        UILabel *chemicalLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.chemicalBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        chemicalLb.text = @"化学药";
        chemicalLb.textColor = TitleColor;
        chemicalLb.font = HEITI(HeightXiShu(11));
        chemicalLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:chemicalLb];
        _chemicalLb = chemicalLb;
    }
    return _chemicalLb;
}
// 中成药
-(UIButton *)middleBtn{
    if(!_middleBtn){
        UIButton *middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        middleBtn.frame = CGRectMake(self.chemicalBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [middleBtn setImage:[GetImagePath getImagePath:@"home_chemical"] forState:UIControlStateNormal];
        middleBtn.tag = 1;
        [middleBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:middleBtn];
        _middleBtn = middleBtn;
    }
    return _middleBtn;
}
-(UILabel *)middleLb{
    if(!_middleLb){
        UILabel *middleLb = [[UILabel alloc] initWithFrame:CGRectMake(self.chemicalBtn.maxX, self.middleBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        middleLb.text = @"中成药";
        middleLb.textColor = TitleColor;
        middleLb.font = HEITI(HeightXiShu(11));
        middleLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:middleLb];
        _middleLb = middleLb;
    }
    return _middleLb;
}
// 保健品
-(UIButton *)careBtn{
    if(!_careBtn){
        UIButton *careBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        careBtn.frame = CGRectMake(self.middleBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [careBtn setImage:[GetImagePath getImagePath:@"home_care"] forState:UIControlStateNormal];
        careBtn.tag = 2;
        [careBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:careBtn];
        _careBtn = careBtn;
    }
    return _careBtn;
}
-(UILabel *)careLb{
    if(!_careLb){
        UILabel *careLb = [[UILabel alloc] initWithFrame:CGRectMake(self.middleBtn.maxX, self.careBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        careLb.text = @"保健品";
        careLb.textColor = TitleColor;
        careLb.font = HEITI(HeightXiShu(11));
        careLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:careLb];
        _careLb = careLb;
    }
    return _careLb;
}
// 积分
-(UIButton *)integralBtn{
    if(!_integralBtn){
        UIButton *integralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        integralBtn.frame = CGRectMake(self.careBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [integralBtn setImage:[GetImagePath getImagePath:@"home_integral"] forState:UIControlStateNormal];
        integralBtn.tag = 3;
        [integralBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:integralBtn];
        _integralBtn = integralBtn;
    }
    return _integralBtn;
}
-(UILabel *)integralLb{
    if(!_integralLb){
        UILabel *integralLb = [[UILabel alloc] initWithFrame:CGRectMake(self.careBtn.maxX, self.careBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        integralLb.text = @"积分";
        integralLb.textColor = TitleColor;
        integralLb.font = HEITI(HeightXiShu(11));
        integralLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:integralLb];
        _integralLb = integralLb;
    }
    return _integralLb;
}
// 促销
-(UIButton *)salesBtn{
    if(!_salesBtn){
        UIButton *salesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        salesBtn.frame = CGRectMake(self.integralBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [salesBtn setImage:[GetImagePath getImagePath:@"home_sales"] forState:UIControlStateNormal];
        salesBtn.tag = 4;
        [salesBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:salesBtn];
        _salesBtn = salesBtn;
    }
    return _salesBtn;
}
-(UILabel *)salesLb{
    if(!_salesLb){
        UILabel *salesLb = [[UILabel alloc] initWithFrame:CGRectMake(self.integralBtn.maxX, self.salesBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        salesLb.text = @"促销";
        salesLb.textColor = TitleColor;
        salesLb.font = HEITI(HeightXiShu(11));
        salesLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:salesLb];
        _salesLb = salesLb;
    }
    return _salesLb;
}

-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(mainButtonClick:)]){
        [self.delegate mainButtonClick:button.tag];
    }
}
@end
