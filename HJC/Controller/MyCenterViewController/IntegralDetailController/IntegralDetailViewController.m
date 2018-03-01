//
//  IntegralDetailViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "IntegralDetailViewController.h"
#import "NavView.h"

@interface IntegralDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView*noDataView;
@end

@implementation IntegralDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.noDataView];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"积分明细";
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
/****
 * need false View for nodata
 **/
-(UIView*)noDataView{
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-122, _navView.maxY+60, 244, 166)];
        _noDataView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodata.jpg"]];
    }
    return _noDataView;
}
#pragma mark - tableView
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"integralCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"integralCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"integeal detail %ld",indexPath.row];
    return cell;
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
