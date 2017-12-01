//
//  ProcurementViewController.m
//  HJC
//
//  Created by 陈晨 on 2017/12/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ProcurementViewController.h"
#import "NavView.h"
@interface ProcurementViewController ()
@property(nonatomic,strong)NavView *navView;

@end

@implementation ProcurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.tableView setMinY:64 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"采购";
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
