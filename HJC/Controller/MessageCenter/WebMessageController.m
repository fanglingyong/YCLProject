//
//  WebMessageController.m
//  HJC
//
//  Created by 方灵勇 on 2018/5/4.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "WebMessageController.h"
#import "NavView.h"

@interface WebMessageController ()<UIWebViewDelegate>

@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation WebMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
    self.webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:GetNavYaoZixun]];
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"药资讯";
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
-(void)backLastControl_menthod{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
