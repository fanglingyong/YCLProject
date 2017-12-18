//
//  BindClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BindClinicViewController.h"
#import "NavView.h"
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
    [self statusBar];
    [self.view addSubview:self.navView];
    [self networkForClinicInfo];
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
#pragma mark - network
-(void)networkForClinicInfo{
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:@"1" forKey:@"UserID"];
    [pargams setObject:@"1" forKey:@"Parastr"];
    [pargams setObject:@",10,1" forKey:@"WebPara"];
    [BaseApi getMenthodWithUrl:GetClinicList block:^(NSDictionary *dict, NSError *error) {
        if(dict){
            if ([dict[@"status"] intValue] == 1) {
                NSLog(@"自己诊所————数组%@",dict[@"data"]);
                NSDictionary*clinic = dict[@"data"][0];
                BindClinicModel *model = [[BindClinicModel alloc] init];
                [model setValuesForKeysWithDictionary:clinic];
                [self setValuesForClinicModel:model];
            }else{
                [HUDUtil Hud_message:dict[@"message"] view:self.view];
            }
        }
    } dic:pargams noNetWork:nil];
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
    
    [self.view addSubview:_clinicView];

}
-(void)setValuesForClinicModel:(BindClinicModel*)model{
    _clinicNmae.text = model.CORPNAME;
    _clinicLeader.text = model.LAWMAN;
    _clinicAddress.text = model.ADDRESS;
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
