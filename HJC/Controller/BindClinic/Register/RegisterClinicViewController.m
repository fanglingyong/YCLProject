//
//  RegisterClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "RegisterClinicViewController.h"
#import "NavView.h"

@interface RegisterClinicViewController ()

@property (nonatomic,strong) NavView * navView;

@end

@implementation RegisterClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self viewCrateUI];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"注册新诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}


- (void)viewCrateUI{
    
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
