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
        [self preferentialBtn];  //诊特惠
        [self worldBtn];    //药世界
        [self integralBtn];      //换积分
        [self pharmacyBtn];  //云药房
        [self informationBtn];     //药资讯

        [self preferentialLb];  //诊特惠
        [self worldLb];    //药世界
        [self integralLb];      //换积分
        [self pharmacyLb];  //云药房
        [self informationLb];     //药资讯

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
// 诊特惠
-(UIButton *)preferentialBtn{
    if(!_preferentialBtn){
        UIButton *preferentialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        preferentialBtn.frame = CGRectMake(0, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [preferentialBtn setImage:[GetImagePath getImagePath:@"home_sales"] forState:UIControlStateNormal];
        preferentialBtn.tag = 0;
        [preferentialBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:preferentialBtn];
        _preferentialBtn = preferentialBtn;
    }
    return _preferentialBtn;
}

-(UILabel *)preferentialLb{
    if(!_preferentialLb){
        UILabel *preferentialLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.preferentialBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        preferentialLb.text = @"诊特惠";
        preferentialLb.textColor = TitleColor;
        preferentialLb.font = HEITI(HeightXiShu(11));
        preferentialLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:preferentialLb];
        _preferentialLb = preferentialLb;
    }
    return _preferentialLb;
}
// 药世界
-(UIButton *)worldBtn{
    if(!_worldBtn){
        UIButton *worldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        worldBtn.frame = CGRectMake(self.preferentialBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [worldBtn setImage:[GetImagePath getImagePath:@"home_chemical"] forState:UIControlStateNormal];
        worldBtn.tag = 1;
        [worldBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:worldBtn];
        _worldBtn = worldBtn;
    }
    return _worldBtn;
}
-(UILabel *)worldLb{
    if(!_worldLb){
        UILabel *worldLb = [[UILabel alloc] initWithFrame:CGRectMake(self.preferentialBtn.maxX, self.worldBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        worldLb.text = @"药世界";
        worldLb.textColor = TitleColor;
        worldLb.font = HEITI(HeightXiShu(11));
        worldLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:worldLb];
        _worldLb = worldLb;
    }
    return _worldLb;
}
// 换积分
-(UIButton *)integralBtn{
    if(!_integralBtn){
        UIButton *integralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        integralBtn.frame = CGRectMake(self.worldBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [integralBtn setImage:[GetImagePath getImagePath:@"home_integral"] forState:UIControlStateNormal];
        integralBtn.tag = 2;
        [integralBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:integralBtn];
        _integralBtn = integralBtn;
    }
    return _integralBtn;
}
-(UILabel *)integralLb{
    if(!_integralLb){
        UILabel *integralLb = [[UILabel alloc] initWithFrame:CGRectMake(self.worldBtn.maxX, self.integralBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        integralLb.text = @"换积分";
        integralLb.textColor = TitleColor;
        integralLb.font = HEITI(HeightXiShu(11));
        integralLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:integralLb];
        _integralLb = integralLb;
    }
    return _integralLb;
}
// 云药房
-(UIButton *)pharmacyBtn{
    if(!_pharmacyBtn){
        UIButton *pharmacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pharmacyBtn.frame = CGRectMake(self.integralBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [pharmacyBtn setImage:[GetImagePath getImagePath:@"home_middle"] forState:UIControlStateNormal];
        pharmacyBtn.tag = 3;
        [pharmacyBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:pharmacyBtn];
        _pharmacyBtn = pharmacyBtn;
    }
    return _pharmacyBtn;
}
-(UILabel *)pharmacyLb{
    if(!_pharmacyLb){
        UILabel *pharmacyLb = [[UILabel alloc] initWithFrame:CGRectMake(self.integralBtn.maxX, self.integralBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        pharmacyLb.text = @"云药房";
        pharmacyLb.textColor = TitleColor;
        pharmacyLb.font = HEITI(HeightXiShu(11));
        pharmacyLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:pharmacyLb];
        _pharmacyLb = pharmacyLb;
    }
    return _pharmacyLb;
}
// 药资讯
-(UIButton *)informationBtn{
    if(!_informationBtn){
        UIButton *informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        informationBtn.frame = CGRectMake(self.pharmacyBtn.maxX, HeightXiShu(15), kScreenWidth/5, HeightXiShu(50));
        [informationBtn setImage:[GetImagePath getImagePath:@"home_care"] forState:UIControlStateNormal];
        informationBtn.tag = 4;
        [informationBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:informationBtn];
        _informationBtn = informationBtn;
    }
    return _informationBtn;
}
-(UILabel *)informationLb{
    if(!_informationLb){
        UILabel *informationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.pharmacyBtn.maxX, self.informationBtn.maxY, kScreenWidth/5, HeightXiShu(25))];
        informationLb.text = @"药资讯";
        informationLb.textColor = TitleColor;
        informationLb.font = HEITI(HeightXiShu(11));
        informationLb.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:informationLb];
        _informationLb = informationLb;
    }
    return _informationLb;
}

-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(mainButtonClick:)]){
        [self.delegate mainButtonClick:button.tag];
    }
}
@end
