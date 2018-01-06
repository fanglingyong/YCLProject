//
//  MyOrderViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/27.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyOrderViewController.h"
#import "NavView.h"
#import "HDDropdownButton.h"
#import "DropdownSimpleView.h"
#import "OrderStatus.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "MJRefresh.h"

@interface MyOrderViewController ()<UITableViewDataSource, UITableViewDelegate, DropdownViewDelegate, HDDropdownButtonDelegate>

@property(nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)OrderStatus *orderStatus;
@property (nonatomic, retain)DropdownSimpleView *dropView;
@property (nonatomic, retain)HDDropdownButton *orderStatusButton;
@property (nonatomic, retain)UILabel *orderTimeLB;
@property (nonatomic, retain)UIButton *orderBegTimeBtn;
@property (nonatomic, retain)UIImageView *orderLineView;
@property (nonatomic, retain)UIButton *orderEndTimeBtn;
@property (nonatomic, retain)UIButton *orderSearchBtn;

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
        self.orderStatus = [[OrderStatus alloc] init];
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
    [self creatTableView];
    [self creatDropDownView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    self.tableView.mj_header = [[MJRefreshNormalHeader alloc] init];
    [self.tableView.mj_header setRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self addNoDataView];
    
    [self.orderStatusArray addObject:@"订单状态0"];
    [self.orderStatusArray addObject:@"订单状态1"];
    [self.orderStatusArray addObject:@"订单状态2"];
    
    NSArray *array = [NSArray arrayWithObject:self.orderStatusArray];
    [self.orderStatus setupBasicArray:array];
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
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"订单详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (UIView *)headerView {
    
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, HeightXiShu(44))];
        headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}
- (UIView *)noDateView {
    if (!_noDateView) {
        UIView *noDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - HeightXiShu(44))];
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

- (void)creatDropDownView {
    // 全部分类
    self.orderStatusButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(120), HeightXiShu(44))];
    self.orderStatusButton.delegate = self;
    self.orderStatusButton.backgroundColor = [UIColor whiteColor];
    self.orderStatusButton.frontColor = TitleColor;
    self.orderStatusButton.title = self.orderStatus.orderStatusTitle;
    [self.headerView addSubview:self.orderStatusButton];
    
    self.orderTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(120), 0, WidthXiShu(70), HeightXiShu(44))];
    self.orderTimeLB.text = @"订单时间";
    self.orderTimeLB.backgroundColor = [UIColor whiteColor];
    self.orderTimeLB.textColor = TitleColor;
    self.orderTimeLB.font = HEITI(HeightXiShu(14));
    [self.headerView addSubview:self.orderTimeLB];
    
    self.orderBegTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBegTimeBtn.frame = CGRectMake(WidthXiShu(190), HeightXiShu(12), WidthXiShu(70), HeightXiShu(20));
    self.orderBegTimeBtn.titleLabel.font = HEITI(HeightXiShu(12));
    [self.orderBegTimeBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [self.orderBegTimeBtn setTitle:@"2017/02/10" forState:UIControlStateNormal];
    self.orderBegTimeBtn.backgroundColor = AllBackLightGratColor;
    [self.headerView addSubview:self.orderBegTimeBtn];
    
    self.orderLineView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(263), HeightXiShu(22), WidthXiShu(8), .5)];
    self.orderLineView.backgroundColor = TitleColor;
    [self.headerView addSubview:self.orderLineView];
    
    self.orderEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderEndTimeBtn.frame = CGRectMake(WidthXiShu(275),  HeightXiShu(12), WidthXiShu(70), HeightXiShu(20));
    self.orderEndTimeBtn.titleLabel.font = HEITI(HeightXiShu(12));
    [self.orderEndTimeBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [self.orderEndTimeBtn setTitle:@"2017/02/10" forState:UIControlStateNormal];
    self.orderEndTimeBtn.backgroundColor = AllBackLightGratColor;
    [self.headerView addSubview:self.orderEndTimeBtn];
    
    self.orderSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderSearchBtn.frame = CGRectMake(WidthXiShu(345), HeightXiShu(12), WidthXiShu(20), HeightXiShu(20));
    [self.orderSearchBtn setImage:[GetImagePath getImagePath:@"search"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.orderSearchBtn];
    
    self.dropView = [[DropdownSimpleView alloc] initWithFrame:CGRectMake(0, 64 + HeightXiShu(44), kScreenWidth, kScreenHeight - HeightXiShu(44))];
    self.dropView.delegate = self;
    self.dropView.hidden = YES;
    [self.view addSubview:self.dropView];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  64 + HeightXiShu(44), kScreenWidth, kScreenHeight - 64 - HeightXiShu(44)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.tableView];
    
}


#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchClick {
    
    
}

- (void)deselectButtons {
    self.orderStatusButton.selected = NO;
    self.dropView.hidden = YES;
}

- (void)dropdownButton:(HDDropdownButton *)titleView didTapButton:(UIButton *)sender {
    
    
    if (titleView.selected == YES) {
        [self deselectButtons];
        
    } else {
        [self deselectButtons];
        if ([titleView isEqual:self.orderStatusButton]) {
            self.orderStatusButton.selected = YES;
            self.dropView.dataArray = self.orderStatus.orderStatusArray;
            self.dropView.tag = 1001;
            self.dropView.selectedIndex = self.orderStatus.orderStatus;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            
            NSLog(@"dropView%lu", (unsigned long)self.dropView.selectedIndex);
            
            NSLog(@"全部分类");
        }
    }
}

- (void)didSelectRowOfFilterView:(DropdownView *)filterView {
    
    if (filterView.tag == 1001) {
        
        self.orderStatus.orderStatus = ((DropdownSimpleView *)filterView).selectedIndex;
        self.orderStatusButton.title = self.orderStatus.orderStatusTitle;
        
    }
    
    [self deselectButtons];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didHideFilterView:(DropdownView *)filterView {
    
    [self deselectButtons];
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
