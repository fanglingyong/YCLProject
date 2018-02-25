//
//  ChangeUserInfoViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "NavView.h"
#import "ToolButtonView.h"

@interface ChangeUserInfoViewController ()

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UITextField *nickName;
@property (nonatomic,strong) UITextField *addressName;
@property (nonatomic,strong) UITextField *emailName;

@end

@implementation ChangeUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self changeUserInfoView];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"修改信息";
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

-(void)changeUserInfoView{
    UIView *userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, 150)];
    userInfo.backgroundColor = [UIColor whiteColor];
    
    UILabel *nickLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 80, 34)];
    nickLable.text = @"昵称";
    nickLable.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:nickLable];
    
    self.nickName = [[UITextField alloc] initWithFrame:CGRectMake(84, 10, kScreenWidth-92, 35)];
    _nickName.placeholder = @"请输入联系人昵称";
    _nickName.text = [UserModel getUserModel].P_NAME;
    _nickName.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:_nickName];
    
    UIView *fg = [[UIView alloc] initWithFrame:CGRectMake(8, 50, kScreenWidth-8, 1)];
    fg.backgroundColor = AllLightGrayColor;
    [userInfo addSubview:fg];
    
    UILabel *clinicLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 55, 68, 34)];
    clinicLable.text = @"地址";
    clinicLable.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:clinicLable];
    
    self.addressName = [[UITextField alloc] initWithFrame:CGRectMake(84, 55, kScreenWidth-92, 35)];
    _addressName.placeholder = @"请输入通讯地址";
    _addressName.text = [UserModel getUserModel].PostAddress;
    _addressName.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:_addressName];
    
    UIView *fg1 = [[UIView alloc] initWithFrame:CGRectMake(8, 95, kScreenWidth-8, 1)];
    fg1.backgroundColor = AllLightGrayColor;
    [userInfo addSubview:fg1];
    
    UILabel *emailLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 100, 68, 34)];
    emailLable.text = @"邮箱";
    emailLable.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:emailLable];
    
    self.emailName = [[UITextField alloc] initWithFrame:CGRectMake(84, 100, kScreenWidth-92, 35)];
    _emailName.placeholder = @"请输入E-mail";
    _emailName.text = [UserModel getUserModel].EMail;
    _emailName.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:_emailName];
    [self.view addSubview:userInfo];
    
    //--- sure button
    ToolButtonView * toolBtn = [[ToolButtonView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-49, kScreenWidth, 49) button:@"确定"];
    [toolBtn addToolTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];
}

#pragma mark - 事件
-(void)toolButtonAction:(UIButton*)sender{
    sender.userInteractionEnabled = NO;
    NSLog(@"what are you doing");
    NSString *nickname = _nickName.text;
    NSString *addressname = _addressName.text;
    NSString *emailname = _emailName.text;
    
    if (![AnimaDefaultUtil isNotNull:nickname]) {
        [HUDUtil Hud_message:@"用户昵称不能为空" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:addressname]){
        [HUDUtil Hud_message:@"通讯地址不能为空" view:self.view];
    }else if (![AnimaDefaultUtil isNotNull:emailname]){
        [HUDUtil Hud_message:@"电子邮箱不能为空" view:self.view];
    }else{
        NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];//用户ID
        [pargrams setObject:nickname forKey:@"Name"];
        [pargrams setObject:addressname forKey:@"Address"];
        [pargrams setObject:emailname forKey:@"Email"];
        [BaseApi getMenthodWithUrl:ChangUserInfo block:^(NSDictionary *dict, NSError *error) {
            if (dict) {
                //成功 fangly@gmail.com
                UserModel *model = [[UserModel alloc] init];
                model = [UserModel getUserModel];
//                [model setValue:nickname forKey:@"P_NAME"];
//                [model setValue:addressname forKey:@"PostAddress"];
//                [model setValue:emailname forKey:@"EMail"];
                model.P_NAME = nickname;
                model.PostAddress = addressname;
                model.EMail = emailname;
                [UserModel saveModel:model];
                [HUDUtil Hud_message:@"修改成功" view:self.view];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                //失败
                [HUDUtil Hud_message:error.domain view:self.view];
            }
        } dic:pargrams noNetWork:nil];
        sender.userInteractionEnabled = YES;
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
