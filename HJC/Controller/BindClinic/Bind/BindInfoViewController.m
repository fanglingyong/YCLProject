//
//  BindInfoViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BindInfoViewController.h"
#import "NavView.h"
#import <QuartzCore/QuartzCore.h>
#import "AssoSuccessViewController.h"

@interface BindInfoViewController ()<UISearchBarDelegate>
@property (nonatomic,strong) NavView * navView;
@property (nonatomic,strong) UISearchBar * searchBar;

@end

@implementation BindInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self searchBarView];
    [self tabbarView];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"关联已注册的诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}

- (void)searchBarView{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(2, _navView.maxY+8, kScreenWidth-62, 40)];
    _searchBar.placeholder = @"请输入诊所的结算银行卡号";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(kScreenWidth-60, _navView.maxY+11, 52, 35);
    searchBtn.backgroundColor = RGBCOLOR(37, 121, 228);
    [searchBtn addTarget:self action:@selector(searchResult:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}
-(void)searchResult:(UIButton*)sender{
    NSLog(@"开始搜索了");
}

-(void)tabbarView{
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
//    dView.layer.shadowRadius = 4.f;
//    dView.layer.shadowOffset = CGSizeMake(0, 0);
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
    AssoSuccessViewController * asso = [[AssoSuccessViewController alloc] init];
    [self.navigationController pushViewController:asso animated:YES];
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
