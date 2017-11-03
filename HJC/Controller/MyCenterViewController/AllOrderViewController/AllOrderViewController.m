//
//  AllOrderViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AllOrderViewController.h"
#import "OrderCell.h"
#import "OrderModel.h"

@interface AllOrderViewController ()

@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation AllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    
    
    [self.tableView setMinY:0 maxY:kScreenHeight-HeightXiShu(110)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"AllOrderViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//        return self.modelArr.count + 3;
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

    if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 5) {
        return HeightXiShu(44);
    }
    return HeightXiShu(95);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    if (indexPath.row == 0) {

        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(44))];
        dateLabel.text = @"2017-07-28";
        dateLabel.textColor = TitleColor;
        dateLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:dateLabel];
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(80), 0, WidthXiShu(75), HeightXiShu(44))];
        statusLabel.text = @"待付款";
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = AllRedColor;
        statusLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:statusLabel];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(45), kScreenWidth, HeightXiShu(.5))];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
        
    } else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
        OrderModel *model = self.modelArr[indexPath.row];
        static NSString* const identifier = @"OrderCell";
        OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!orderCell) {
            orderCell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        orderCell.model = model;
        return orderCell;
        
    } else if (indexPath.row == 4) {

        UILabel *integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - WidthXiShu(5), HeightXiShu(44))];
        integralLabel.text = @"积分抵扣 $ 192.20";
        integralLabel.textAlignment = NSTextAlignmentRight;
        integralLabel.textColor = TitleColor;
        integralLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:integralLabel];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(44), kScreenWidth, HeightXiShu(.5))];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
        
    } else {
        NSInteger count = 24;
        float money = 284.20;
        float freight = 0;

        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - WidthXiShu(5), HeightXiShu(44))];
        detailLabel.text = [NSString stringWithFormat:@"共%ld件商品 合计: $%.2f(含运费%.2f元)", (long)count, money, freight];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = TitleColor;
        detailLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:detailLabel];
    }
    return cell;
    
}

#pragma mark - 事件
-(void)reloadData{
    NSLog(@"AllOrderViewController reloadData");
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

- (void)addShoppingCartClick:(NSInteger)index {
    
    NSLog(@"%ld", (long)index);
    
}

#pragma mark - 接口
- (void)handleData {
    
    
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

