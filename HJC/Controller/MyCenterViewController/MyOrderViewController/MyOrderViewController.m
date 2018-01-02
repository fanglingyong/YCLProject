//
//  MyOrderViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/27.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyOrderViewController.h"
#import "NavView.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "MJRefresh.h"

@interface MyOrderViewController ()

@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)NSMutableArray *orderStatusArray;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIView *noDateView;

@property(nonatomic)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation MyOrderViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelArr = [NSMutableArray array];
        self.orderStatusArray = [NSMutableArray array];
        self.pageIndex = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [self.tableView setMinY:64 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    self.tableView.mj_header = [[MJRefreshNormalHeader alloc] init];
    [self.tableView.mj_header setRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self addNoDataView];

    [self networkGetOrdersDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"MyOrderViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

- (void)headRefresh {
    self.pageIndex = 1;
    [self handleData];
    
}

- (void)footRefresh {
    self.pageIndex += 1;
    [self handleData];
}

- (void)addNoDataView {
    self.noDateView.hidden = YES;
    [self.tableView addSubview:self.noDateView];
}


#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(165);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *model = [[OrderModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = AllBackLightGratColor;
    }
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailViewController *VC = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"我的订单";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (UIView *)noDateView {
    if (!_noDateView) {
        UIView *noDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(160), kScreenWidth, HeightXiShu(20))];
        label.text = @"没有此类药品!";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = HEITI(HeightXiShu(15));
        label.textColor = NavColor;
        [noDateView addSubview:label];
        _noDateView  = noDateView;
    }
    return _noDateView;
}




#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchClick {
    
    
}



#pragma mark - 接口
- (void)handleData {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}
#pragma mark - net
-(void)networkGetOrdersDetail{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:_orderNO forKey:@"OrderNo"];
    [BaseApi getMenthodWithUrl:GetOrderDetail block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            for (NSDictionary *orderDic in dict[@"data"]) {
                OrderModel *orderModel = [[OrderModel alloc] init];
                [orderModel setValuesForKeysWithDictionary:orderDic];
                [self.modelArr addObject:orderModel];
            }
            [self.tableView reloadData];
        }else{
            
        }
    } dic:pargrams noNetWork:nil];
}
/*
 返回：
 ORDERID        订单细单ID
 GOODSID        货品ID
 GOODSNAME        货品名称
 SPEC        规格
 PRODUCER    厂家
 CALCUNIT    单位
 ORDERAMOUNT    数量
 SELLPRICE        会员价
 RETAILPRICE    零售价
 ORDERSUMS    订单细单金额
 [NAME]        状态
 CREATETIME    创建时间
 COMMITTIME    完成时间
 [ADDRESS]        送货地址（可不显示）
 
 */


@end
