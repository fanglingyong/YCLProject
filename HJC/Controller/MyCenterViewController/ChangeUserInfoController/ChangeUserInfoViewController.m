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
@property (nonatomic,strong) UITextField *clinicName;

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
    UIView *userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, 100)];
    userInfo.backgroundColor = [UIColor whiteColor];
    
    UILabel *nickLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 80, 34)];
    nickLable.text = @"昵称";
    nickLable.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:nickLable];
    
    self.nickName = [[UITextField alloc] initWithFrame:CGRectMake(84, 10, kScreenWidth-92, 35)];
    _nickName.placeholder = @"请输入联系人昵称";
    _nickName.text = @"月落光阴过 繁华一梦醒";
    _nickName.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:_nickName];
    
    UIView *fg = [[UIView alloc] initWithFrame:CGRectMake(8, 50, kScreenWidth-8, 1)];
    fg.backgroundColor = AllLightGrayColor;
    [userInfo addSubview:fg];
    
    UILabel *clinicLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 55, 68, 34)];
    clinicLable.text = @"诊所昵称";
    clinicLable.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:clinicLable];
    
    self.clinicName = [[UITextField alloc] initWithFrame:CGRectMake(84, 55, kScreenWidth-92, 35)];
    _clinicName.placeholder = @"请输入诊所名称";
    _clinicName.text = @"上海戏剧学院";
    _clinicName.font = [UIFont systemFontOfSize:15];
    [userInfo addSubview:_clinicName];
    [self.view addSubview:userInfo];
    
    //--- sure button
    ToolButtonView * toolBtn = [[ToolButtonView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49) button:@"确定"];
    [toolBtn addToolTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];
}

#pragma mark - 事件
-(void)toolButtonAction:(UIButton*)sender{
    NSLog(@"what are you doing");
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
