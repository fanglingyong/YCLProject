//
//  RegisterClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "RegisterClinicViewController.h"
#import "NavView.h"
#import "InputTextFiledView.h"
#import "SelectBoxView.h"
#import "PositionAddressViewController.h"

@interface RegisterClinicViewController ()

@property (nonatomic,strong) NavView * navView;

@end

@implementation RegisterClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self viewCrateUI];
    [self tabbarView];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"注册新诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}


- (void)viewCrateUI{
    InputTextFiledView * clinicName = [[InputTextFiledView alloc] initWithFrame:CGRectMake(8, _navView.maxY+8, kScreenWidth-16, 50)];
    clinicName.textField.frame = CGRectMake(10, 8, clinicName.width-20, 31);
    clinicName.placeholder = @"请输入诊所名称";
    clinicName.placeholderColor = [UIColor colorFromHexCode:@"#696969"];
    clinicName.backgroundColor = [UIColor colorFromHexCode:@"#fdfdfd"];
    clinicName.layer.borderWidth = 1;
    clinicName.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
    [self.view addSubview:clinicName];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(8, clinicName.maxY+20, 100, 22)];
    title.text = @"诊所具体地址";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIColor colorFromHexCode:@"#2c2c2c"];
    [self.view addSubview:title];
    
    SelectBoxView * proBox = [[SelectBoxView alloc] initWithFrame:CGRectMake(8, title.maxY+8, (kScreenWidth-32)/3, 40)];
    proBox.placeholder = @"选择省";
    [self.view addSubview:proBox];
    
    SelectBoxView * citBox = [[SelectBoxView alloc] initWithFrame:CGRectMake(proBox.maxX+8, title.maxY+8, (kScreenWidth-32)/3, 40)];
    citBox.placeholder = @"选择市";
    [self.view addSubview:citBox];

    SelectBoxView * areBox = [[SelectBoxView alloc] initWithFrame:CGRectMake(citBox.maxX+8, title.maxY+8, (kScreenWidth-32)/3, 40)];
    areBox.placeholder = @"选择区";
    [self.view addSubview:areBox];
    
    SelectBoxView * streetBox = [[SelectBoxView alloc] initWithFrame:CGRectMake(8, proBox.maxY+8, kScreenWidth-16, 40)];
    streetBox.placeholder = @"选择街道";
    [self.view addSubview:streetBox];
    
    InputTextFiledView * addDetail = [[InputTextFiledView alloc] initWithFrame:CGRectMake(8, streetBox.maxY+8, kScreenWidth-16, 50)];
    addDetail.textField.frame = CGRectMake(10, 8, clinicName.width-20, 31);
    addDetail.placeholder = @"请输入诊所所在的具体地址";
    addDetail.placeholderColor = [UIColor colorFromHexCode:@"#696969"];
    addDetail.backgroundColor = [UIColor colorFromHexCode:@"#fdfdfd"];
    addDetail.layer.borderWidth = 1;
    addDetail.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
    [self.view addSubview:addDetail];
}

-(void)tabbarView{
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.layer.shadowColor = [[UIColor blackColor] CGColor];
    dView.layer.shadowOpacity = 0.5f;
    
    UIButton * lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lastBtn.frame = CGRectMake(10, 4, kScreenWidth/2-15, 40);
    lastBtn.layer.borderWidth = 1;
    lastBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    lastBtn.layer.cornerRadius = 3;
    lastBtn.clipsToBounds = YES;
    [lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [lastBtn setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(popLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:lastBtn];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kScreenWidth/2+5, 4, kScreenWidth/2-15, 40);
    nextBtn.layer.borderWidth = 1;
    nextBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    nextBtn.layer.cornerRadius = 3;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
    [nextBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(jumpToAssoSuccess:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:nextBtn];
    
    [self.view addSubview:dView];
}
// last / next button menthod
-(void)jumpToAssoSuccess:(UIButton*)sender{
    PositionAddressViewController * pa = [[PositionAddressViewController alloc] init];
    [self.navigationController pushViewController:pa animated:YES];
}
-(void)popLastPage:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
