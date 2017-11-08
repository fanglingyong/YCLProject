//
//  PositionAddressViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "PositionAddressViewController.h"
#import "NavView.h"
#import "CompletionInfoViewController.h"

@interface PositionAddressViewController ()

@property (nonatomic,strong) NavView *navView;

@end

@implementation PositionAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self addressPosotionView];
    [self tabbarView];
    // Do any additional setup after loading the view.
}
#pragma mark - 地图定位
-(void)addressPosotionView{
    
}
#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"定位诊所地址";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}
-(void)tabbarView{
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.layer.shadowColor = [[UIColor blackColor] CGColor];
    dView.layer.shadowOpacity = 0.5f;
    
    UIButton * lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lastBtn.frame = CGRectMake(10, 4, kScreenWidth/2-15, 40);
    lastBtn.layer.borderWidth = 1;
    lastBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    lastBtn.layer.cornerRadius = 3;
    lastBtn.clipsToBounds = YES;
    [lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [lastBtn setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(popLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:lastBtn];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kScreenWidth/2+5, 4, kScreenWidth/2-15, 40);
    nextBtn.layer.borderWidth = 1;
    nextBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    nextBtn.layer.cornerRadius = 3;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
    [nextBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(jumpToAssoSuccess:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:nextBtn];
    
    [self.view addSubview:dView];
}
// last / next button menthod
-(void)jumpToAssoSuccess:(UIButton*)sender{
    CompletionInfoViewController * comInfo = [[CompletionInfoViewController alloc] init];
    [self.navigationController pushViewController:comInfo animated:YES];
}
-(void)popLastPage:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
