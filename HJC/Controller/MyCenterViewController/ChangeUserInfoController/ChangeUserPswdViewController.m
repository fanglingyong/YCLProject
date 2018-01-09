//
//  ChangeUserPswdViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ChangeUserPswdViewController.h"
#import "NavView.h"
#import "TextFiledView.h"
#import "ToolButtonView.h"

@interface ChangeUserPswdViewController ()

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) TextFiledView *account;
@property (nonatomic,strong) TextFiledView *oldpswd;
@property (nonatomic,strong) TextFiledView *password;
@property (nonatomic,strong) TextFiledView *againpswd;
@property (nonatomic,strong) TextFiledView *phonenumber;


@end

@implementation ChangeUserPswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self createUI];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"修改密码";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(goLastController) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)goLastController{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createUI{
    UIView *userpswd = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY+8, kScreenWidth, kScreenHeight-105-kStateHeight)];
    userpswd.backgroundColor = [UIColor whiteColor];
    
    self.account = [[TextFiledView alloc] initWithFrame:CGRectMake(25, 8, kScreenWidth-50, 35)];
    _account.textField.placeholder = @"请输入账号/手机号";
    _account.leftView.image = [UIImage imageNamed:@"user_25_25"];
    
    self.oldpswd = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _account.maxY+10, kScreenWidth-50, 35)];
    _oldpswd.textField.placeholder = @"请输入旧密码";
    _oldpswd.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _oldpswd.textField.secureTextEntry = YES;//暗文
    
    self.password = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _oldpswd.maxY+10, kScreenWidth-50, 35)];
    _password.textField.placeholder = @"请输入新密码";
    _password.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _password.textField.secureTextEntry = YES;//暗文
    
    self.againpswd = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _password.maxY+10, kScreenWidth-50, 35)];
    _againpswd.textField.placeholder = @"再输入一次新密码";
    _againpswd.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _againpswd.textField.secureTextEntry = YES;//暗文
    
    [userpswd addSubview:_account];
    [userpswd addSubview:_oldpswd];
    [userpswd addSubview:_password];
    [userpswd addSubview:_againpswd];
    [self.view addSubview:userpswd];
    
    ToolButtonView * toolBtn = [[ToolButtonView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49) button:@"确定"];
    [toolBtn addToolTarget:self action:@selector(registerAccountMenthod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];

}
#pragma mark - 事件
-(void)registerAccountMenthod:(UIButton*)sender{
    NSLog(@"----->修改密码!!!");
    
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
