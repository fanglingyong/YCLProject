//
//  MyCollectViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyCollectViewController.h"
#import "NavView.h"
#import "CollectCell.h"
#import "CollectModel.h"

@interface MyCollectViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self.tableView setMinY:64 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"收藏夹";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectModel *model = [[CollectModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"CollectCell";
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    return cell;
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
