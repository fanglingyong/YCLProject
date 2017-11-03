//
//  PasswordLoginViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "BindClinicViewController.h"
#import "AppDelegate.h"
#import "ForgetPasswordViewController.h"

@interface PasswordLoginViewController ()


@end

@implementation PasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUIMenthed];
    // Do any additional setup after loading the view.
}

//UI布局
-(void)createUIMenthed{
    
    UIButton * pwPageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    pwPageBtn.frame = CGRectMake(8, 30, 70, 30);
    [pwPageBtn setTitle:@"快键登陆" forState:UIControlStateNormal];
    [pwPageBtn addTarget:self action:@selector(jumpLasrViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * logo = [[UIImageView alloc] initWithFrame:CGRectMake([self.view centerX]-40, 100, 80, 80)];
    logo.image = [UIImage imageNamed:@"logo"];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(8, 188, kScreenWidth-16, 22)];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:15];
    name.text =@"华东药联采提供服务";
    name.textColor = RGBACOLOR(118, 135, 156, 1);
    
    UIButton * forgetPWBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetPWBtn.frame = CGRectMake(kScreenWidth-20-70, 345, 70, 32);
    [forgetPWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPWBtn addTarget:self action:@selector(jumpForgetPasswordController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, 400, kScreenWidth-40, 40);
    [sureBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    sureBtn.backgroundColor = RGBACOLOR(67, 155, 234, 1);
    [sureBtn addTarget:self action:@selector(sureForLoginActionMenthod:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pwPageBtn];
    [self.view addSubview:logo];
    [self.view addSubview:name];
    [self.view addSubview:[self textfiledView]];
    [self.view addSubview:forgetPWBtn];
    [self.view addSubview:sureBtn];
    [self.view addSubview:[self termsOfServiceView]];
}
//跳转
-(void)jumpLasrViewController:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) jumpForgetPasswordController:(UIButton*)sender {
    ForgetPasswordViewController * forget = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES
     ];
}


/**
 this is sure button menthod for jump home page
 
 @param sender sure button
 */
- (void)sureForLoginActionMenthod:(UIButton *)sender{
    NSLog(@"跳转到主页");
    /** jumpMain
     AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
     [appDelegate jumpMain];
     */
    /**jump bind clinic
     
     */
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
    
    UITextField* passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(10, 61, tfView.width-20, 30)];
    passwordTf.placeholder = @"请输入密码";
    
    [tfView addSubview:account];
    [tfView addSubview:passwordTf];
    return tfView;
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
