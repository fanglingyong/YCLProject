//
//  BindClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BindClinicViewController.h"
#import "NavView.h"
#import "BindInfoViewController.h"
#import "RegisterClinicViewController.h"

@interface BindClinicViewController ()

@property(nonatomic,strong) NavView * navView;

@end

@implementation BindClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self loadUI];
    // Do any additional setup after loading the view.
}

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"绑定店铺";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}

-(void)loadUI{
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    UIView *view_had = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, kScreenHeight/2-120, kScreenWidth*0.8, 100)];
    view_had.backgroundColor = [UIColor whiteColor];
    view_had.layer.borderWidth = 1;
    view_had.clipsToBounds=YES;
    view_had.layer.cornerRadius = 8;
    view_had.layer.borderColor = [RGBCOLOR(116, 133, 147) CGColor];
    UILabel * had_title = [[UILabel alloc] initWithFrame:CGRectMake(8, 20, view_had.width-16, 30)];
    had_title.textAlignment = NSTextAlignmentCenter;
    had_title.font = [UIFont systemFontOfSize:25 weight:600];
    had_title.text = @"关联已有诊所";
    UILabel *had_descration = [[UILabel alloc] initWithFrame:CGRectMake(8, 58, view_had.width-16, 22)];
    had_descration.textAlignment = NSTextAlignmentCenter;
    had_descration.font = [UIFont systemFontOfSize:15];
    had_descration.text = @"诊所已在华东开户";
    [view_had addSubview:had_title];
    [view_had addSubview:had_descration];
    UIButton * jump_had = [UIButton buttonWithType:UIButtonTypeSystem];
    jump_had.frame = view_had.bounds;
    [jump_had addTarget:self action:@selector(jumpToBindAccount:) forControlEvents:UIControlEventTouchUpInside];
    [view_had addSubview:jump_had];
    
    UIView *view_no = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, kScreenHeight/2+20, kScreenWidth*0.8, 100)];
    view_no.backgroundColor = [UIColor whiteColor];
    view_no.layer.borderWidth = 1;
    view_no.clipsToBounds=YES;
    view_no.layer.cornerRadius = 8;
    view_no.layer.borderColor = [RGBCOLOR(116, 133, 147) CGColor];
    UILabel * no_title = [[UILabel alloc] initWithFrame:CGRectMake(8, 20, view_no.width-16, 30)];
    no_title.textAlignment = NSTextAlignmentCenter;
    no_title.font = [UIFont systemFontOfSize:25 weight:600];
    no_title.text = @"注册新诊所";
    UILabel *no_descration = [[UILabel alloc] initWithFrame:CGRectMake(8, 58, view_no.width-16, 22)];
    no_descration.textAlignment = NSTextAlignmentCenter;
    no_descration.font = [UIFont systemFontOfSize:15];
    no_descration.text = @"尚未在华东开户";
    [view_no addSubview:no_title];
    [view_no addSubview:no_descration];
    
    UIButton * jump_register = [UIButton buttonWithType:UIButtonTypeSystem];
    jump_register.frame = view_no.bounds;
    [jump_register addTarget:self action:@selector(jumpToRegisterAccount:) forControlEvents:UIControlEventTouchUpInside];
    [view_no addSubview:jump_register];
    
    [self.view addSubview:view_had];
    [self.view addSubview:view_no];
}

-(void) jumpToBindAccount:(UIButton*)sender{
    BindInfoViewController *bindinfo = [[BindInfoViewController alloc] init];
    [self.navigationController pushViewController:bindinfo animated:YES];
}
-(void) jumpToRegisterAccount:(UIButton*)sender{
    RegisterClinicViewController * reg_clinic = [[RegisterClinicViewController alloc] init];
    [self.navigationController pushViewController:reg_clinic animated:YES];
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
