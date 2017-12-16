//
//  AuditClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/13.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AuditClinicViewController.h"
#import "NavView.h"


@interface AuditClinicViewController ()

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation AuditClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"诊所资质审核";
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
#pragma mark - scrolView
-(void)createScrol{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY-49)];
    _scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_scrollView];
    [self contents];
}

-(void)contents{
    UILabel *clinicName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 30)];
    clinicName.text = [NSString stringWithFormat:@"诊所名称:%@",@"浙江仙琚制药有限公司"];
    [_scrollView addSubview:clinicName];
    
    UILabel *loaderName = [[UILabel alloc] initWithFrame:CGRectMake(10, clinicName.maxY+10, kScreenWidth-20, 30)];
    loaderName.text = [NSString stringWithFormat:@"联系人:%@",@"姜主恩"];
    [_scrollView addSubview:loaderName];
    
    UILabel *clinicAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, loaderName.maxY+10, kScreenWidth-20, 30)];
    clinicAddress.text = [NSString stringWithFormat:@"诊所地址:%@",@"仙居县南峰街道南峰山路1888号"];
    [_scrollView addSubview:clinicAddress];
    NSArray *arr = [NSArray arrayWithObjects:@"",@"",@"", nil];
    for (int i = 0; i<arr.count; i++) {
        if (![arr[i] isEqualToString:@""]) {
            UILabel *loaderName = [[UILabel alloc] initWithFrame:CGRectMake(10, clinicAddress.maxY+10+(kScreenWidth+20)*i, kScreenWidth-20, 30)];
            loaderName.text = [NSString stringWithFormat:@"联系人:%@",@"姜主恩"];
            [_scrollView addSubview:loaderName];
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, clinicAddress.maxY+50+(kScreenWidth+20)*i, kScreenWidth-20, kScreenWidth-20)];
            [image sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@""]];
            [_scrollView addSubview:image];
        }
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
