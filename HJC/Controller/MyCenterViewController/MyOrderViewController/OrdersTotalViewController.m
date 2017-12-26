//
//  OrdersTotalViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrdersTotalViewController.h"
#import "NavView.h"
#import "OrderTotalModel.h"
#import "OrderTotalCell.h"
#import "MyOrderViewController.h"

@interface OrdersTotalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) NSMutableArray *OrdersArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation OrdersTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    self.page = 1;
    [self networkGetOrders];
    // Do any additional setup after loading the view.
}

#pragma mark - 事件

#pragma mark - net
-(void)networkGetOrders{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"2017-12-01 17:20:26,2017-12-25 17:20:44" forKey:@"Parastr"];
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",_page] forKey:@"WebPara"];
    [BaseApi getMenthodWithUrl:GetOdersNo block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            if (_page==1) {
                self.OrdersArr = [NSMutableArray array];
            }
            for (NSDictionary *orderDic in dict[@"data"]) {
                OrderTotalModel *orderModel = [[OrderTotalModel alloc] init];
                [orderModel setValuesForKeysWithDictionary:orderDic];
                [_OrdersArr addObject:orderModel];
            }
            [_tableView reloadData];
        }else{
            
        }
    } dic:pargrams noNetWork:nil];
}
#pragma mark - headerView
-(UIView*)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, 40)];
        _headerView.backgroundColor = [UIColor whiteColor];
        //这里补全下 
    }
    return _headerView;
}
#pragma mark - tableView
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY+40, kScreenWidth, kScreenHeight-_navView.maxY-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.OrdersArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTotalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderTotalCell"];
    if (!cell) {
        cell = [[OrderTotalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderTotalCell"];
    }
    cell.model = _OrdersArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderViewController *myorder = [[MyOrderViewController alloc] init];
    OrderTotalModel * model = [[OrderTotalModel alloc] init];
    model = _OrdersArr[indexPath.row];
    myorder.orderNO = model.ORDERNO;
    [self.navigationController pushViewController:myorder animated:YES];
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"我的订单";
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
