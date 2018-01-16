//
//  RegisterUserViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/27.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "NavView.h"
#import "TextFiledView.h"
#import "SmsCodeTextField.h"
#import "AssoSuccessViewController.h"
#import "EncrtDecrt.h"
#import "RegDelegateViewController.h"

@interface RegisterUserViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) TextFiledView *account;
@property (nonatomic,strong) TextFiledView *password;
@property (nonatomic,strong) TextFiledView *againpswd;
@property (nonatomic,strong) TextFiledView *phonenumber;
@property (nonatomic,strong) SmsCodeTextField *smsCode;
@property (nonatomic,strong) UIButton * isSelectXY;

@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"注册";
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
    _account.textField.placeholder = @"请输入账号";
    _account.textField.delegate = self;
    _account.leftView.image = [UIImage imageNamed:@"user_25_25"];
    
    self.password = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _account.maxY+10, kScreenWidth-50, 35)];
    _password.textField.placeholder = @"请输入密码";
    _password.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _password.textField.secureTextEntry = YES;//暗文
    
    self.againpswd = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _password.maxY+10, kScreenWidth-50, 35)];
    _againpswd.textField.placeholder = @"再输入一次密码";
    _againpswd.leftView.image = [UIImage imageNamed:@"password_25_25"];
    _againpswd.textField.secureTextEntry = YES;//暗文
    
    self.phonenumber = [[TextFiledView alloc] initWithFrame:CGRectMake(25, _againpswd.maxY+10, kScreenWidth-50, 35)];
    _phonenumber.textField.placeholder = @"请输入手机号";
    _phonenumber.textField.delegate = self;
    _phonenumber.leftView.image = [UIImage imageNamed:@"code_25_25"];
    
    self.smsCode = [[SmsCodeTextField alloc] initWithFrame:CGRectMake(25, _phonenumber.maxY+10, kScreenWidth-50, 35)];
    _smsCode.textField.placeholder = @"请输入短信验证码";
    _smsCode.textField.delegate = self;
    _smsCode.leftView.image = [UIImage imageNamed:@"code_25_25"];
    
    [self.view addSubview:_account];
    [self.view addSubview:_password];
    [self.view addSubview:_againpswd];
    [self.view addSubview:_phonenumber];
    [self.view addSubview:_smsCode];
    
    UIView *tosView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-135, _smsCode.maxY+50, 270, 22)];
    
    self.isSelectXY = [UIButton buttonWithType:UIButtonTypeCustom];
    _isSelectXY.frame = CGRectMake(0, 0, 22, 22);
    [_isSelectXY setImage:[UIImage imageNamed:@"gou_select"] forState:UIControlStateNormal];
    [_isSelectXY setImage:[UIImage imageNamed:@"gou_normal"] forState:UIControlStateSelected];
    [_isSelectXY addTarget:self action:@selector(selectTersOfService:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(_isSelectXY.maxX, 0, 248, 22)];
    lable1.textColor = [UIColor colorFromHexCode:@"#111111"];
    lable1.font = [UIFont systemFontOfSize:14];
    NSString *oldStr = @"同意《华东医药药联采用户注册协议》";
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"3795e2"]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:oldStr];
    [attribtStr addAttributes:attribtDic range:NSMakeRange(3, oldStr.length-4)];
    lable1.attributedText = attribtStr;
    
    UIButton *content = [UIButton buttonWithType:UIButtonTypeSystem];
    content.frame = CGRectMake(44, 0, 196, 22);
    [content addTarget:self action:@selector(jumpProtocolHtml) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rgBtn.frame = CGRectMake(25, tosView.maxY+10, kScreenWidth-50, 40);
    [rgBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rgBtn.layer.cornerRadius = 5;
    rgBtn.clipsToBounds = YES;
    rgBtn.backgroundColor = sysBlue;
    [rgBtn addTarget:self action:@selector(registerAccountMenthod:) forControlEvents:UIControlEventTouchUpInside];
    
    [tosView addSubview:_isSelectXY];
    [tosView addSubview:lable1];
    [tosView addSubview:content];
    
    [self.view addSubview:tosView];
    [self.view addSubview:rgBtn];
}
-(void)selectTersOfService:(UIButton *)sender{
    sender.selected = !sender.selected;
}
-(void)jumpProtocolHtml{
    //jump protocol web page
    RegDelegateViewController *delegateVC = [[RegDelegateViewController alloc] init];
    [self.navigationController pushViewController:delegateVC animated:YES];
}
-(void)registerAccountMenthod:(UIButton*)sender{
//    NSLog(@"注册成功!!!");
    NSString * account = _account.textField.text;
    NSString * password1 = _password.textField.text;
    NSString * password2 = _againpswd.textField.text;
    NSString * phone = _phonenumber.textField.text;
    NSString * smsCode = _smsCode.textField.text;
    if (![AnimaDefaultUtil isNotNull:account]) {
        [HUDUtil Hud_message:@"账号不能为空" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:password1]){
        [HUDUtil Hud_message:@"密码不能为空" view:self.view];
    }else if (![password1 isEqualToString:password2]){
        [HUDUtil Hud_message:@"两次密码不相同" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:phone]){
        [HUDUtil Hud_message:@"手机号不能为空" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:smsCode]){
        [HUDUtil Hud_message:@"验证码不能为空" view:self.view];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:account forKey:@"Username"];
        [pargrams setObject:password1 forKey:@"Password"];
//        [EncrtDecrt md5:password1]
        [pargrams setObject:phone forKey:@"HandPhone"];
        [pargrams setObject:_corpId forKey:@"RID"];
//        [pargrams setObject:_smsCode forKey:@"smscode"];
        [BaseApi getMenthodWithUrl:RegisterURL block:^(NSDictionary *dict, NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (dict) {
                    AssoSuccessViewController *asso = [[AssoSuccessViewController alloc] init];
                    asso.assoText = @"注册账号提交成功";
                    [self.navigationController pushViewController:asso animated:YES];
                }else{
                    [HUDUtil Hud_message:dict[@"message"] view:self.view];
                }
        } dic:pargrams noNetWork:nil];
        
    }
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
