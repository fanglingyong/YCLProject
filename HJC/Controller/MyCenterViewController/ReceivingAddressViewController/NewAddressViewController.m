//
//  NewAddressViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "NewAddressViewController.h"
#import "NavView.h"

@interface NewAddressViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic,strong)UITextView *addressTV;
@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIButton *sureButton;

//@property (nonatomic, retain)NSString *name;
//@property (nonatomic, retain)NSString *phone;
//@property (nonatomic, retain)NSString *address;
@property (nonatomic, assign)BOOL isAcquiescence;

@end

@implementation NewAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    self.isAcquiescence = NO;
    [self sureButton];
    [self dadiView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 页面元素
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"收货地址管理";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(0, kScreenHeight-SafeAreaBottomHeight - HeightXiShu(50), kScreenWidth, HeightXiShu(50));
        sureButton.backgroundColor = [UIColor colorFromHexCode:@"#4172e4"];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font = HEITI(HeightXiShu(18));
        [sureButton addTarget:self action:@selector(sureChangeOrAddbuttonMenthod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureButton];
        _sureButton = sureButton;
    }
    return _sureButton;
}

-(void)dadiView{
    UIView *dadiView = [[UIView alloc] initWithFrame:CGRectMake(0,  SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight - HeightXiShu(50) - HeightXiShu(5))];
    dadiView.backgroundColor = AllBackLightGratColor;
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, WidthXiShu(60), HeightXiShu(55))];
    nameLb.text = @"收货人";
    nameLb.textColor = BlackColor;
    nameLb.font = HEITI(HeightXiShu(15));
    [dadiView addSubview:nameLb];
    
   
    [dadiView addSubview:self.nameTF];
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(54), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
    cutLine.backgroundColor = AllLightGrayColor;
    [dadiView addSubview:cutLine];
//------
    UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), WidthXiShu(55), WidthXiShu(60), HeightXiShu(50))];
    phoneLb.text = @"手机号";
    phoneLb.textColor = BlackColor;
    phoneLb.font = HEITI(HeightXiShu(15));
    [dadiView addSubview:phoneLb];
    [dadiView addSubview:self.phoneTF];
    
    UIImageView *cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(109), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
    cutLine1.backgroundColor = AllLightGrayColor;
    [dadiView addSubview:cutLine1];
//---------
    UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), WidthXiShu(110), WidthXiShu(60), HeightXiShu(55))];
    addressLb.text = @"地址";
    addressLb.textColor = BlackColor;
    addressLb.font = HEITI(HeightXiShu(15));
    [dadiView addSubview:addressLb];
    [dadiView addSubview:self.addressTV];
    
    [self.view addSubview:dadiView];
}
-(UITextField*)nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(80), 0, kScreenWidth - WidthXiShu(80), HeightXiShu(55))];
        _nameTF.text = @"";
        _nameTF.delegate = self;
        _nameTF.tag = 100;
        _nameTF.textColor = BlackColor;
        _nameTF.font = HEITI(HeightXiShu(15));
    }
    return _nameTF;
}
-(UITextField*)phoneTF{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(80), WidthXiShu(55), kScreenWidth - WidthXiShu(80), HeightXiShu(50))];
        _phoneTF.text = @"";
        _phoneTF.delegate = self;
        _phoneTF.tag = 101;
        _phoneTF.textColor = BlackColor;
        _phoneTF.font = HEITI(HeightXiShu(15));    }
    return _phoneTF;
}
-(UITextView*)addressTV{
    if (!_addressTV) {
        _addressTV = [[UITextView alloc] initWithFrame:CGRectMake(WidthXiShu(80), HeightXiShu(120), kScreenWidth - WidthXiShu(80) - WidthXiShu(10), HeightXiShu(110))];
        _addressTV.textColor = BlackColor;
        _addressTV.backgroundColor = AllLightGrayColor;
        _addressTV.delegate = self;
        _addressTV.text = @"";
        _addressTV.font = HEITI(HeightXiShu(15));
    }
    return _addressTV;
}



#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureChangeOrAddbuttonMenthod{
    if (![AnimaDefaultUtil isNotNull:self.nameTF.text]) {
        [HUDUtil Hud_message:@"收货人不能为空" view:self.view];
        return;
    }else if (![AnimaDefaultUtil isNotNull:self.addressTV.text]) {
        [HUDUtil Hud_message:@"地址不能为空" view:self.view];
        return;
    }else if (![AnimaDefaultUtil isNotNull:self.phoneTF.text]) {
        [HUDUtil Hud_message:@"手机号不能为空" view:self.view];
        return;
    }
    [self network_corpAddress];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  
}
- (void)textViewDidEndEditing:(UITextView *)textView {
   

}
-(void)setModel:(ReceiveAddressModel *)model{
   self.nameTF.text = model.POSTCODE;
    self.phoneTF.text = model.LINK;
    self.addressTV.text = model.ADDRESS;
    self.addressID = model.ADDRESSID;
}
/**
 修改新增 收货地址
 */
-(void)network_corpAddress{
    
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];
    [pargams setObject:self.addressID forKey:@"ADDRESSID"];
    [pargams setObject:[UserModel getUserModel].RID forKey:@"CORPID"];
    [pargams setObject:self.addressTV.text forKey:@"ADDRESS"];
    [pargams setObject:self.nameTF.text forKey:@"POSTCODE"];
    [pargams setObject:self.phoneTF.text forKey:@"LINK"];
    [pargams setObject:@"1" forKey:@"ISVALID"];//新增和修改填1，删除记录填2
    NSLog(@"%@", pargams);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseApi getMenthodWithUrl:UpdateCorpAddressURL block:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (dict) {
                self.block();
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [HUDUtil Hud_message:error.domain view:self.view];
            }
        });
    } dic:pargams noNetWork:nil];
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

