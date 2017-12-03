//
//  ForgetPasswordViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "BindClinicViewController.h"
#import "NavView.h"
#import "TextFiledView.h"
#import "SmsCodeTextField.h"

@interface ForgetPasswordViewController ()

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) TextFiledView *account;
@property (nonatomic,strong) TextFiledView *password;
@property (nonatomic,strong) TextFiledView *againpswd;
@property (nonatomic,strong) TextFiledView *phonenumber;
@property (nonatomic,strong) SmsCodeTextField *smsCode;


@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self createUI];
    // Do any additional setup after loading the view.
}

//UI布局
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"找回密码";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastController_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}

-(void)backLastController_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI{
    
    self.account = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _navView.maxY+40, kScreenWidth-50, 35)];
    _account.textField.placeholder = @"请输入预留的手机号";
    _account.leftView.image = [UIImage imageNamed:@"user_25_25"];
    
    self.password = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _account.maxY+10, kScreenWidth-50, 35)];
    _password.textField.placeholder = @"请输入密码";
    _password.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _password.textField.secureTextEntry = YES;//暗文
    
    self.againpswd = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _password.maxY+10, kScreenWidth-50, 35)];
    _againpswd.textField.placeholder = @"再输入一次密码";
    _againpswd.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _againpswd.textField.secureTextEntry = YES;//暗文
    
    self.smsCode = [[SmsCodeTextField alloc] initWithFrame:CGRectMake(25, _againpswd.maxY+10, kScreenWidth-50, 35)];
    _smsCode.textField.placeholder = @"请输入短信验证码";
    _smsCode.leftView.image = [UIImage imageNamed:@"code_25_25"];
    
    [self.view addSubview:_account];
    [self.view addSubview:_password];
    [self.view addSubview:_againpswd];
    [self.view addSubview:_smsCode];
    
    UIButton * rgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rgBtn.frame = CGRectMake(25, _smsCode.maxY+50, kScreenWidth-50, 40);
    [rgBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [rgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rgBtn.layer.cornerRadius = 5;
    rgBtn.clipsToBounds = YES;
    rgBtn.backgroundColor = sysBlue;
    [rgBtn addTarget:self action:@selector(registerAccountMenthod:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rgBtn];
}

-(void)registerAccountMenthod:(UIButton*)sender{
    NSLog(@"----->修改!!!");
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
