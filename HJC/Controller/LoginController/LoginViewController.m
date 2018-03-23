//
//  LoginViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "LoginViewController.h"
#import "BindClinicViewController.h"
#import "AppDelegate.h"
#import "ForgetPasswordViewController.h"
//#import "RegisterUserViewController.h"
#import "BindInfoViewController.h"
#import "TextFiledView.h"
#import "EncrtDecrt.h"

@interface LoginViewController ()

@property (nonatomic,strong) TextFiledView * accountView;
@property (nonatomic,strong) TextFiledView * passwordView;
@property (nonatomic,strong) UIView * dView;
@property (nonatomic,strong) UIView * headView;

@end

@implementation LoginViewController

+ (instancetype)instance {
    static LoginViewController *_viewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _viewController = [[LoginViewController alloc] init];
    });
    return _viewController;
}

+ (BOOL)openLogin {
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];
    if([model.P_LSM intValue] == 0){
        LoginViewController *view = [LoginViewController instance];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
        nav.navigationBarHidden = YES;
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"openLogin"];
        return YES;
    }else {
        return NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self statusBar];
    self.statusBar.backgroundColor = sysBlue;
    [self createUIMenthed];
    // Do any additional setup after loading the view.
}

//UI布局
-(void)createUIMenthed{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, kStateHeight, kScreenWidth, kScreenWidth*0.6)];
    _headView.backgroundColor = sysBlue;
//    UIImageView * logo = [[UIImageView alloc] initWithFrame:CGRectMake([_headView centerX]-120, kScreenWidth*0.3-29, 240, 58)];
//    logo.image = [UIImage imageNamed:@"LOGO_hd"];
//    [_headView addSubview:logo];
    UILabel *logoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kStateHeight, kScreenWidth, 120)];
    logoLable.text = @"微  药";
    logoLable.font = [UIFont systemFontOfSize:60 weight:600];
    logoLable.textAlignment = NSTextAlignmentCenter;
    logoLable.textColor = [UIColor whiteColor];
    [_headView addSubview:logoLable];
    
    [self xUIcreateMenthod];
    [self.view addSubview:_headView];
    [self.view addSubview:self.dView];
}

-(void) jumpForgetPasswordController:(UIButton*)sender {
    /* forget password
     */
     ForgetPasswordViewController * forget = [[ForgetPasswordViewController alloc] init];
     [self.navigationController pushViewController:forget animated:YES
     ];
     
    /*
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"please call admin,phone is 0571-88888888" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alert show];
     */
}
-(void) registerNewUserController:(UIButton*)sender{
    BindInfoViewController * rgUser = [[BindInfoViewController alloc] init];
    [self.navigationController pushViewController:rgUser animated:YES
     ];
}


/**
 this is sure button menthod for jump home page
 
 @param sender sure button
 */
- (void)sureForLoginActionMenthod:(UIButton *)sender{
    NSString * account = _accountView.textField.text;
    NSString * password =_passwordView.textField.text;
    if (![AnimaDefaultUtil isNotNull:account]) {
        [HUDUtil Hud_message:@"请输入账号" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:password]){
        [HUDUtil Hud_message:@"请输入密码" view:self.view];
    }else{
        NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
        [pargams setObject:account forKey:@"Username"];
        [pargams setObject:password forKey:@"Password"];
        __block typeof (self)wself = self;
        [BaseApi getMenthodWithUrl:LoginURL block:^(NSDictionary *dict, NSError *error) {
            if (error) {
                [AnimaDefaultUtil alertUtil:self message:@"sorry,have a error."];
            }else{
                //解析数据
                UserModel *model = [[UserModel alloc] init];
                [model setValuesForKeysWithDictionary:dict[@"data"][0]];
                [UserModel saveModel:model];
                if (model.RID) {
                    if (wself.refeshBlock) {
                        wself.refeshBlock();
                    }
                    [wself dismissViewControllerAnimated:YES completion:nil];
                }else{
                    /**jump bind clinic*/
                     BindClinicViewController * bindClinic = [[BindClinicViewController alloc] init];
                     [wself.navigationController pushViewController:bindClinic animated:YES];
                     
                }
            }
        } dic:pargams noNetWork:^{
            [HUDUtil Hud_message:@"请检查网络" view:self.view];
        }];
    }
    
}

/**
 create view
 
 @return 返回一个带有输入框的view
 */
-(UIView *)dView{
    if (!_dView) {
        _dView = [[UIView alloc] initWithFrame:CGRectMake(0, _headView.maxY, kScreenWidth, kScreenHeight-_headView.maxY)];
        //        _dView.backgroundColor = [UIColor cloudsColor];
        
        self.accountView = [[TextFiledView alloc] initWithFrame:CGRectMake(25, 30, kScreenWidth-50, 35)];
        _accountView.textField.placeholder = @"请输入用户名";
        _accountView.leftView.image = [UIImage imageNamed:@"user_25_25"];
        
        self.passwordView = [[TextFiledView alloc] initWithFrame:CGRectMake(25, 75, kScreenWidth-50, 35)];
        _passwordView.textField.placeholder = @"请输入密码";
        _passwordView.leftView.image = [UIImage imageNamed:@"password_25_25"];
        _passwordView.textField.secureTextEntry = YES;//暗文
        
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(25, 140, kScreenWidth-50, 40);
        [sureBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.clipsToBounds = YES;
        sureBtn.backgroundColor = sysBlue;
        [sureBtn addTarget:self action:@selector(sureForLoginActionMenthod:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * forgetPWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgetPWBtn.frame = CGRectMake(20, sureBtn.maxY+5, 80, 32);
        [forgetPWBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        forgetPWBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forgetPWBtn setTitleColor:[UIColor colorFromHexCode:@"3975e2"] forState:UIControlStateNormal];
        [forgetPWBtn addTarget:self action:@selector(jumpForgetPasswordController:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * registerUsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerUsBtn.frame = CGRectMake(kScreenWidth-20-80, sureBtn.maxY+5, 80, 32);
        [registerUsBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
        registerUsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [registerUsBtn setTitleColor:sysBlue forState:UIControlStateNormal];
        [registerUsBtn addTarget:self action:@selector(registerNewUserController:) forControlEvents:UIControlEventTouchUpInside];
        
        [_dView addSubview:_accountView];
        [_dView addSubview:_passwordView];
        [_dView addSubview:sureBtn];
        [_dView addSubview:forgetPWBtn];
        [_dView addSubview:registerUsBtn];
    }
    return _dView;
}
#pragma mark - X button
-(void)xUIcreateMenthod{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 8, 50, 30);
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(xBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
}
-(void)xBtnAction:(UIButton*)sender{
    if (self.backBlock) {
        self.backBlock();
    }
    [self dismissViewControllerAnimated:YES completion:^{

    }];
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
