//
//  AssoSuccessViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AssoSuccessViewController.h"
#import "NavView.h"
#import "AppDelegate.h"

@interface AssoSuccessViewController ()
@property (nonatomic,strong) NavView * navView;

@end

@implementation AssoSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self loadSomeView];
    // Do any additional setup after loading the view.
}


-(void)loadSomeView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.centerX-80, _navView.maxY+40, 160, 160)];
    imageView.image = [UIImage imageNamed:@"success.png"];
    [self.view addSubview:imageView];
    
    UILabel *assoTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, imageView.maxY+10, kScreenWidth-16, 22)];
    assoTitle.text = self.assoText;;
    assoTitle.textAlignment = NSTextAlignmentCenter;
    assoTitle.font = [UIFont systemFontOfSize:17 weight:800];
    
    [self.view addSubview:assoTitle];
    
    UILabel *descText = [[UILabel alloc] initWithFrame:CGRectMake(8, assoTitle.maxY+40, kScreenWidth-16, 44)];
    descText.text = @"你的专属客服是138-8888-7777，如有任何问题，请直接电话联系";
    descText.numberOfLines = 2;
    descText.textAlignment = NSTextAlignmentCenter;
    descText.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:descText];
    
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.layer.shadowRadius = 2.f;
    dView.layer.shadowColor = [[UIColor blackColor] CGColor];
    dView.layer.shadowOpacity = 0.5f;
    
    UIButton * jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpBtn.frame = CGRectMake(8, 4, kScreenWidth-16, 40);
    jumpBtn.layer.borderWidth = 1;
    jumpBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    jumpBtn.layer.cornerRadius = 3;
    jumpBtn.clipsToBounds = YES;
    [jumpBtn setTitle:@"进入产品页" forState:UIControlStateNormal];
    jumpBtn.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
    [jumpBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(jumpProcutPage:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:jumpBtn];

    [self.view addSubview:dView];
}
-(void)jumpProcutPage:(UIButton*)sender{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate jumpMain];
}
// 导航栏
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"请等待后台审核";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
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
