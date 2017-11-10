//
//  PurchasingRecordsViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "PurchasingRecordsViewController.h"
#import "MerchandiseFooterButton.h"

@interface PurchasingRecordsViewController ()<MerchandiseFooterButtonDelegate>
@property (nonatomic, retain)NSMutableArray *dateArray;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;

@end

@implementation PurchasingRecordsViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.tableView setMinY:0 maxY:kScreenHeight - HeightXiShu(110) - HeightXiShu(55)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self footerView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素
- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(104) - HeightXiShu(55), kScreenWidth, HeightXiShu(55))];
        footerView.delegate = self;
        footerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
    
}
#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(40))];
    view.backgroundColor = AllLightGrayColor;
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(120), HeightXiShu(40))];
    numberLabel.text = @"共 1766 笔";
    numberLabel.textColor = TitleColor;
    numberLabel.font = HEITI(HeightXiShu(13));
    [view addSubview:numberLabel];
    
    UILabel *sellLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(145), 0, WidthXiShu(130), HeightXiShu(40))];
    sellLabel.text = @"累计销售 681 盒";
    sellLabel.textColor = TitleColor;
    sellLabel.font = HEITI(HeightXiShu(13));
    [view addSubview:sellLabel];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *clinicsLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(70), HeightXiShu(40))];
    clinicsLabel.text = @[@"古**诊所", @"越**诊所", @"龙**诊所", @"山**诊所", @"古**诊所"][indexPath.row];
    clinicsLabel.textColor = BlackColor;
    clinicsLabel.font = HEITI(HeightXiShu(13));
    [cell.contentView addSubview:clinicsLabel];
    
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(95), 0, WidthXiShu(100), HeightXiShu(40))];
    numberLabel.text = @[@"6盒", @"6盒", @"6盒", @"6盒", @"6盒"][indexPath.row];
    numberLabel.textColor = BlackColor;
    numberLabel.font = HEITI(HeightXiShu(13));
    [cell.contentView addSubview:numberLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(120), 0, WidthXiShu(80), HeightXiShu(40))];
    dateLabel.text = @[@"2017-07-31", @"2017-07-31", @"2017-07-31", @"2017-07-31", @"2017-07-31"][indexPath.row];
    dateLabel.textColor = BlackColor;
    dateLabel.font = HEITI(HeightXiShu(13));
    [cell.contentView addSubview:dateLabel];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(39), kScreenWidth, .5)];
    lineView.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:lineView];
    
    return cell;
}
#pragma mark - 事件

#pragma mark - 事件
- (void)didOftenBuyListButton:(UIButton *)button {
    NSLog(@"加常购清单");
    
    
}

- (void)didCustomerServiceButton:(UIButton *)button {
    NSLog(@"联系客服");
    
    
}

- (void)didShoppingCartButton:(UIButton *)button {
    NSLog(@"购物车");
    
    
}

- (void)didAddShoppingCartButton:(UIButton *)button {
    NSLog(@"加购物车");
    
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
