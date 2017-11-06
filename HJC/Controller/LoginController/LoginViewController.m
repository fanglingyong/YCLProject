//
//  LoginViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "LoginViewController.h"
#import "PasswordLoginViewController.h"
#import "AppDelegate.h"
#import "BindClinicViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUIMenthed];
    // Do any additional setup after loading the view.
}
//跳转到密码登陆页面
-(void)jumpToPasswordLoginViewController:(UIButton *)sender{
    NSLog(@"跳转到密码登陆页面");
    PasswordLoginViewController * pwPage = [[PasswordLoginViewController alloc] init];
    [self.navigationController pushViewController:pwPage animated:YES];
}
//UI布局
-(void)createUIMenthed{
    
    UIButton * pwPageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    pwPageBtn.frame = CGRectMake(kScreenWidth-78, 30, 70, 30);
    [pwPageBtn setTitle:@"密码登陆" forState:UIControlStateNormal];
    [pwPageBtn addTarget:self action:@selector(jumpToPasswordLoginViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView * logo = [[UIImageView alloc] initWithFrame:CGRectMake([self.view centerX]-40, 100, 80, 80)];
    logo.image = [UIImage imageNamed:@"logo"];
    
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(8, 188, kScreenWidth-16, 22)];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:15];
    name.text =@"华东药联采提供服务";
    name.textColor = RGBACOLOR(118, 135, 156, 1);
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 400, kScreenWidth-40, 40);
    [sureBtn setTitle:@"手机号快键登陆" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    sureBtn.backgroundColor = RGBACOLOR(67, 155, 234, 1);
    [sureBtn addTarget:self action:@selector(sureForLoginActionMenthod:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pwPageBtn];
    [self.view addSubview:logo];
    [self.view addSubview:name];
    [self.view addSubview:[self textfiledView]];
    [self.view addSubview:sureBtn];
    [self.view addSubview:[self termsOfServiceView]];
}


/**
 this is sure button menthod for jump home page

 @param sender sure button
 */
- (void)sureForLoginActionMenthod:(UIButton *)sender{
    
    /** jumpMain
    NSLog(@"跳转到主页");
     AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate jumpMain];
     */
    /**jump bind clinic
     
     */
    NSLog(@"跳转到绑定页面");
    BindClinicViewController * bindClinic = [[BindClinicViewController alloc] init];
    [self.navigationController pushViewController:bindClinic animated:YES];
}

/**
 create view

 @return 返回一个带有输入框的view
 */
-(UIView *)textfiledView{
    UIView * tfView = [[UIView alloc] initWithFrame:CGRectMake(20, 240, kScreenWidth-40, 101)];
    tfView.backgroundColor = [UIColor cloudsColor];
    tfView.layer.borderWidth = 1;
    tfView.layer.borderColor = [RGBCOLOR(193, 204, 213) CGColor];
    
    UITextField * account = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, tfView.width-20, 30)];
    account.placeholder = @"请输入手机号";
    
    UIView * h_x = [[UIView alloc] initWithFrame:CGRectMake(0, 50, tfView.width, 1)];
    h_x.backgroundColor = RGBCOLOR(193, 204, 213);
    [tfView addSubview:h_x];
    
    UITextField* vailCode = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, tfView.width-130, 30)];
    vailCode.placeholder = @"请输入动态验证码";
    
    UIButton * vailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    vailBtn.frame = CGRectMake(tfView.width-110, 60, 100, 32);
    [vailBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [vailBtn setTitleColor:RGBCOLOR(116, 133, 147) forState:UIControlStateNormal];
    vailBtn.layer.borderColor = [RGBCOLOR(116, 133, 147) CGColor];
    vailBtn.layer.borderWidth = 1;
    [vailBtn addTarget:self action:@selector(getVailCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [tfView addSubview:account];
    [tfView addSubview:vailCode];
    [tfView addSubview:vailBtn];
    return tfView;
}

-(void) getVailCode:(UIButton*)sender {
    NSLog(@"获取验证码");
}
/**
 create view

 @return 返回一个服务条款同意view
 */
-(UIView *)termsOfServiceView{
    UIView *tosView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-111, 460, 222, 22)];
    
    UIButton * select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(0, 0, 22, 22);
    [select setTitle:@"Y" forState:UIControlStateNormal];
    [select setTitle:@"N" forState:UIControlStateSelected];
    select.backgroundColor = [UIColor blueColor];
    [select addTarget:self action:@selector(selectTersOfService:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 200, 22)];
    content.text = @"我已阅读并接受《服务条款》";
    content.font = [UIFont systemFontOfSize:15];
    content.textColor = [UIColor grayColor];
    
    [tosView addSubview:select];
    [tosView addSubview:content];
    return tosView;
}
-(void)selectTersOfService:(UIButton *)sender{
    sender.selected = !sender.selected;
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
