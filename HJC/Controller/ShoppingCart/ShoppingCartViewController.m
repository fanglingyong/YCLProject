//
//  ShoppingCartViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/10/17.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "NavView.h"

@interface ShoppingCartViewController ()
@property(nonatomic,strong)NavView *navView;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"购物车";
        navView.leftBtn.hidden = YES;
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
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
