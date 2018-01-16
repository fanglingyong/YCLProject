//
//  SCWebViewController.m
//  ad
//
//  Created by 致富360 on 16/1/19.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "SCWebViewController.h"
#import "NavView.h"
#define NavStatusnHeight (iPhoneX ? 88 : 64)

@interface SCWebViewController ()<UIWebViewDelegate>
{
    NavView * _navView;
    UIWebView * _webView;
    UIButton * leftBarButton1;
}
@end

@implementation SCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupWebView];
    [self showView];
}


- (void)setupWebView{
    if (_IsNav == NO) {
        [self navView];
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavStatusnHeight ,kScreenWidth , kScreenHeight - NavStatusnHeight)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }else{
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0 ,kScreenWidth , kScreenHeight)];
        self.navigationController.navigationBarHidden = NO;
        self.title = _titleString;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        UIButton * leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftBarButton.frame = CGRectMake(8, 11, 13, 22);
        [leftBarButton setImage:[UIImage imageNamed:@"icon_back_arrow.png"] forState:UIControlStateNormal];
        [leftBarButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
        leftBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftBarButton1.frame = CGRectMake(30, 11, 40, 22);

        leftBarButton1.hidden = YES;
        [leftBarButton1 addTarget:self action:@selector(endViewCont) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * button1 = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
        UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton1];
        self.navigationItem.leftBarButtonItems = @[button1,button2];
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0 ,kScreenWidth , kScreenHeight - NavStatusnHeight)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
}

#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"药品详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
#pragma mark - 事件
- (void)backAction{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

- (void)showView{
    if (self.urlString.length == 0) {
        [_webView loadHTMLString:self.HTMLString baseURL:nil];
        _webView.scalesPageToFit = YES;

    }else{
    NSURL * url = [NSURL URLWithString:[self.urlString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest * req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        [_webView loadRequest:req];
    }

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (webView.isLoading) {
        return;
    }
    if ([webView.request.URL.absoluteString rangeOfString:@"http"].location == NSNotFound) {
        return;
    }
    if (_webView.canGoBack) {
        if (_IsNav != NO) {
            leftBarButton1.hidden = NO;
        }
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%ld____%@",(long)error.code,error.domain);
      if (!(error.code == NSURLErrorCancelled) && error.code != 102 && ![error.domain isEqual:@"WebKitErrorDomain"]) {
          [self addAlertView:@"当前网络状况不佳,请检查网络后再试" block:nil];
       
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView{

}

- (void)endViewController{
   [self.navigationController popViewControllerAnimated:true];
}

- (void)endViewCont{
    
   }

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"------__%@", request);
    NSLog(@"___--%@", request.URL.absoluteString);
    return true;
}

#pragma mark --无数据刷新按钮点击事件
-(void)goToRefreshData{
    
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
