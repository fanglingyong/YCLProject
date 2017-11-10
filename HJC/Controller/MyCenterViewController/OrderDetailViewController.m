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

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
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
        return 2;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 1;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return HeightXiShu(5);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(5))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return HeightXiShu(70);
        }
        return HeightXiShu(60);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return HeightXiShu(40);
        } else if (indexPath.row == 1) {
            return HeightXiShu(95);
        } else {
            return HeightXiShu(30);
        }
    }
    if (indexPath.section == 2) {
        return HeightXiShu(44);
    }
    return HeightXiShu(30);
    
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
            OrderModel *model = self.modelArr[indexPath.row];
            static NSString* const identifier = @"OrderCell";
            OrderLogisticsInfoCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!orderCell) {
                orderCell = [[OrderLogisticsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            orderCell.model = model;
            return orderCell;
        } else {
            OrderModel *model = self.modelArr[indexPath.row];
            static NSString* const identifier = @"OrderCell";
            OrderAddressCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!orderCell) {
                orderCell = [[OrderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            orderCell.model = model;
            return orderCell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(40))];
            dateLabel.text = @"2017-07-28";
            dateLabel.textColor = TitleColor;
            dateLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:dateLabel];
        } else if (indexPath.row == 1) {
            OrderModel *model = self.modelArr[indexPath.row];
            static NSString* const identifier = @"OrderCell";
            OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!orderCell) {
                orderCell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            orderCell.model = model;
            return orderCell;
        } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(30))];
            titleLabel.text = @[@"采购总价", @"积分折扣", @"运费"][indexPath.row - 2];
            titleLabel.textColor = TitleColor;
            titleLabel.font = HEITI(HeightXiShu(14));
            [cell.contentView addSubview:titleLabel];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(235), 0,kScreenWidth - WidthXiShu(235), HeightXiShu(30))];
            priceLabel.text = @[@"$228.0", @"$192.2", @"$0.00"][indexPath.row - 2];
            priceLabel.textColor = TitleColor;
            priceLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:priceLabel];
        } else {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(30))];
            titleLabel.text = @"实付金额";
            titleLabel.textColor = BlackColor;
            titleLabel.font = HEITI(HeightXiShu(14));
            [cell.contentView addSubview:titleLabel];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(235), 0,kScreenWidth - WidthXiShu(235), HeightXiShu(30))];
            priceLabel.text = @"$22.59";
            priceLabel.textColor = AllRedColor;
            priceLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:priceLabel];
        }
    } else if (indexPath.section == 2) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(44))];
        titleLabel.textColor = BlackColor;
        NSString *text = @"返积分 12 点";
        NSLog(@"%lu", (unsigned long)text.length);
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:AllRedColor range:NSMakeRange(4, text.length - 6)];
        titleLabel.attributedText = AttributedStr;
        titleLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:titleLabel];
        
    } else {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(70), HeightXiShu(30))];
        titleLabel.text = @[@"订单编号:", @"支付卡号:", @"支付编号:"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:titleLabel];
        
        UILabel *snLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(80), 0,kScreenWidth - WidthXiShu(80), HeightXiShu(30))];
        snLabel.text = @[@"4544887874654654646", @"7864874564649643", @"54984564954654951564"][indexPath.row];
        snLabel.textColor = TitleColor;
        snLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:snLabel];
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
