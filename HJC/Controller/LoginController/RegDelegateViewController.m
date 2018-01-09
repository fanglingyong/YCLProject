//
//  RegDelegateViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "RegDelegateViewController.h"
#import "NavView.h"

@interface RegDelegateViewController ()

@property (nonatomic,strong) NavView *navView;

@end

@implementation RegDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self loadWebView];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"注册协议";
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
#pragma mark - loadWebView
-(void)loadWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-kStateHeight-44)];
    webView.backgroundColor = [UIColor colorFromHexCode:@"#3e3e3e"];
//    webView.scrollView.bounces = NO;
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [webView loadRequest:request];
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
