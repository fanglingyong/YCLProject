//
//  OrderDetailViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "NavView.h"
#import "OrderCell.h"
#import "OrderModel.h"

@interface OrderDetailViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.tableView setMinY:64 maxY:kScreenHeight];
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
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

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"订单详情";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    } else {
        return 1;
    }
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return HeightXiShu(35);
        }
        return HeightXiShu(105);
    }
    if (indexPath.section == 1) {
        return HeightXiShu(90);
    }
    if (indexPath.section == 2) {
        return HeightXiShu(70);
    }
    return HeightXiShu(78);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(240), HeightXiShu(35))];
            dateLabel.text = @"订单号: 2017112014250001";
            dateLabel.textColor = TitleColor;
            dateLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:dateLabel];
            
            UILabel *statesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(70), 0, WidthXiShu(60), HeightXiShu(35))];
            statesLabel.text = @"已收货";
            statesLabel.textColor = TitleColor;
            statesLabel.textAlignment = NSTextAlignmentRight;
            statesLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:statesLabel];
            
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(34), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
            
        } else {
            OrderModel *model = self.modelArr[indexPath.row];
            static NSString* const identifier = @"OrderDetailCell";
            OrderDetailCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!orderCell) {
                orderCell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            orderCell.model = model;
            return orderCell;
        }
    } else if (indexPath.section == 1) {
        OrderModel *model = self.modelArr[indexPath.row];
        static NSString* const identifier = @"OrderAddressCell";
        OrderAddressCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!orderCell) {
            orderCell = [[OrderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        orderCell.model = model;
        return orderCell;
        
    } else if (indexPath.section == 2) {
        OrderModel *model = self.modelArr[indexPath.row];
        static NSString* const identifier = @"OrderPriceInfoCell";
        OrderPriceInfoCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!orderCell) {
            orderCell = [[OrderPriceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        orderCell.model = model;
        return orderCell;
    } else if (indexPath.section == 2) {
        OrderModel *model = self.modelArr[indexPath.row];
        static NSString* const identifier = @"OrderPriceInfoCell";
        OrderPriceInfoCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!orderCell) {
            orderCell = [[OrderPriceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        orderCell.model = model;
        return orderCell;
        
    } else {
        OrderModel *model = self.modelArr[indexPath.row];
        static NSString* const identifier = @"OrderTimeCell";
        OrderTimeCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!orderCell) {
            orderCell = [[OrderTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        orderCell.model = model;
        return orderCell;
    }
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

