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
#import "ClinicCell.h"

@interface BindClinicViewController ()

@property(nonatomic,strong) NavView * navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *bindStatus;
@property (nonatomic,strong) UILabel *clinicNmae;
@property (nonatomic,strong) UILabel *clinicLeader;
@property (nonatomic,strong) UILabel *clinicAddress;
@property (nonatomic,strong) UILabel *noClinic;
@property (nonatomic,strong) UIView  *clinicView;

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
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"我的诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        [navView.leftBtn addTarget:self action:@selector(back_lastController) forControlEvents:UIControlEventTouchUpInside];
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}
-(void)back_lastController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlertViewController{
    UIAlertController *alControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alControl addAction:[UIAlertAction actionWithTitle:@"注册并绑定诊所" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //添加
        [self jumpToRegisterAccount];
    }]];
    [alControl addAction:[UIAlertAction actionWithTitle:@"绑定已有诊所" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //添加
        [self jumpToBindAccount];
    }]];
    [alControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }]];
    [self presentViewController:alControl animated:YES completion:^{
        
    }];
}
//loadUI
-(void)loadUI{
    self.clinicView = [[UIView alloc] initWithFrame:CGRectMake(10, _navView.maxY+30, kScreenWidth-20, 150)];
    _clinicView.backgroundColor = [UIColor colorFromHexCode:@"#f2f2f2"];
    _clinicView.backgroundColor = [UIColor whiteColor];
    _clinicView.clipsToBounds = YES;
    _clinicView.layer.cornerRadius = 5;
    
    _bindStatus = [[UIImageView alloc] initWithFrame:CGRectMake(_clinicView.maxX-60, 10, 37, 16)];
    _bindStatus.image = [UIImage imageNamed:@"didBin"];
    [_clinicView addSubview:_bindStatus];
    
    _clinicNmae = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, _clinicView.maxX-20, 30)];
    _clinicNmae.font = [UIFont systemFontOfSize:17 weight:600];
    [_clinicView addSubview:_clinicNmae];
    
    _clinicLeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 63, _clinicView.maxX-20, 24)];
    _clinicLeader.font = [UIFont systemFontOfSize:15];
    [_clinicView addSubview:_clinicLeader];
    
    _clinicAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 87, _clinicView.maxX-20, 48)];
    _clinicAddress.numberOfLines = 2;
    _clinicAddress.textColor = [UIColor grayColor];
    _clinicAddress.font = [UIFont systemFontOfSize:14];
    [_clinicView addSubview:_clinicAddress];
    
    _noClinic = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, _clinicView.maxX-20, 30)];
    _noClinic.text = @"点击绑定诊所或注册诊所";
    _noClinic.textAlignment = NSTextAlignmentCenter;
    _noClinic.textColor = [UIColor grayColor];
    [_clinicView addSubview:_noClinic];
    
    UITapGestureRecognizer *clinicClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAlertViewController)];
    [_clinicView addGestureRecognizer:clinicClick];
    
    [self.view addSubview:_clinicView];
    [self setNoData];
}
-(void)setValuesForClinicName:(NSString*)name leader:(NSString*)leader address:(NSString*)address{
    _clinicNmae.text = name;
    _clinicLeader.text = leader;
    _clinicAddress.text = address;
    _bindStatus.hidden = NO;
    _noClinic.hidden = YES;
    _clinicView.userInteractionEnabled = NO;
}
-(void)setNoData{
    _clinicNmae.hidden = YES;
    _clinicLeader.hidden = YES;
    _clinicAddress.hidden = YES;
    _bindStatus.hidden = YES;
    _noClinic.hidden = NO;
    _clinicView.userInteractionEnabled = YES;
}
#pragma mark - other
-(void) jumpToBindAccount{
    BindInfoViewController *bindinfo = [[BindInfoViewController alloc] init];
    [self.navigationController pushViewController:bindinfo animated:YES];
}
-(void) jumpToRegisterAccount{
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
