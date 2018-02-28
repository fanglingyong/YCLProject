//
//  PromotionViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/2/28.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "PromotionViewController.h"
#import "NavView.h"

@interface PromotionViewController ()

@property(nonatomic,strong) NavView *navView;

@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"促销";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)backLastControl_menthod{
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
