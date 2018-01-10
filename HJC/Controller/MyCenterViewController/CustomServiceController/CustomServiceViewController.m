//
//  CustomServiceViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "CustomServiceViewController.h"
#import "NavView.h"


@interface CustomServiceViewController ()

@property (nonatomic,strong) NavView *navView;

@end

@implementation CustomServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self todoloadingUI];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"联系客服";
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

- (void)todoloadingUI{
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, kScreenWidth)];
    imageView.image = [UIImage imageNamed:@"customService"];
    [self.view addSubview:imageView];
    
    UILabel *someLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-120, imageView.maxY+10, 240, 110)];
    someLable.text = @"联系电话:\n                     15236526969\n                     0571-85779601\n QQ:\n                     25315264";
    someLable.numberOfLines = 5;
    someLable.textColor = [UIColor colorFromHexCode:@"#416DDC"];
    [self.view addSubview:someLable];
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
