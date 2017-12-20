//
//  ShoppingCartViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/10/17.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "NavView.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartCell.h"
@interface ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)UIView *footerView;
@property (nonatomic, retain)UITableView *mainTableView;
@property (nonatomic, retain)UITableView *addressTableView;

@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];

    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    [self.mainTableView setMinY:64 maxY:kScreenHeight - 49];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.mainTableView];
    
    
    self.addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49 - HeightXiShu(110) - HeightXiShu(45) * 3, kScreenWidth, HeightXiShu(45) * 3) style:UITableViewStylePlain];
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.addressTableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.addressTableView];
    
    [self headerView];
    [self footerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"购物车";
        navView.leftBtn.hidden = YES;
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49 - HeightXiShu(110) - HeightXiShu(45) * 3 - HeightXiShu(50), kScreenWidth, HeightXiShu(50))];
        headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(16), WidthXiShu(15), HeightXiShu(15))];
        selectImg.image = [GetImagePath getImagePath:@"cartSelect"];
        [headerView addSubview:selectImg];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(60), 0, WidthXiShu(160), HeightXiShu(50))];
        label.text = @"总计: 43.00";
        label.textColor = BlackColor;
        label.font = HEITI(HeightXiShu(15));
        [headerView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth - WidthXiShu(125), 0, WidthXiShu(125), HeightXiShu(50));
        [button setTitle:@"生成订单" forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.backgroundColor = [UIColor blueColor];
        [headerView addSubview:button];
        
        [self.view addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49 - HeightXiShu(110), kScreenWidth, HeightXiShu(110))];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *addressTitle = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(70), HeightXiShu(60))];
        addressTitle.text = @"收货地址";
        addressTitle.textColor = TitleColor;
        addressTitle.font = HEITI(HeightXiShu(14));
        [footerView addSubview:addressTitle];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(5), WidthXiShu(45), HeightXiShu(25))];
        nameLabel.text = @"王小明";
        nameLabel.textColor = TitleColor;
        nameLabel.font = HEITI(HeightXiShu(12));
        [footerView addSubview:nameLabel];
        
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(150), HeightXiShu(5), WidthXiShu(100), HeightXiShu(25))];
        phoneLabel.text = @"15998568988";
        phoneLabel.textColor = TitleColor;
        phoneLabel.font = HEITI(HeightXiShu(10));
        [footerView addSubview:phoneLabel];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(30), WidthXiShu(180), HeightXiShu(30))];
        addressLabel.text = @"浙江省杭州市下城区延安路168号外经贸B座9楼";
        addressLabel.numberOfLines = 2;
        addressLabel.textColor = TitleColor;
        addressLabel.font = HEITI(HeightXiShu(10));
        [footerView addSubview:addressLabel];
        
        
        UILabel *remarkTitle = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(60), WidthXiShu(70), HeightXiShu(50))];
        remarkTitle.text = @"备注";
        remarkTitle.textColor = TitleColor;
        remarkTitle.font = HEITI(HeightXiShu(14));
        [footerView addSubview:remarkTitle];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(WidthXiShu(70), HeightXiShu(70), WidthXiShu(180), HeightXiShu(40))];
        textView.text = @"请填写备注";
        textView.textColor = TitleColor;
        [footerView addSubview:textView];

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
    if (tableView == self.mainTableView) {
        return 10;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return HeightXiShu(10);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
        view.backgroundColor = AllLightGrayColor;
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        return HeightXiShu(96);
    }
    return HeightXiShu(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.mainTableView) {
        ShoppingCartModel *model = [[ShoppingCartModel alloc] init];
        if (self.modelArr.count > 0) {
            model = self.modelArr[indexPath.row];
        }
        static NSString* const identifier = @"ShoppingCartCell";
        ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        return cell;
    }
    
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(25), 0, WidthXiShu(50), HeightXiShu(45))];
    nameLb.text = @"王小黑";
    nameLb.textColor = TitleColor;
    nameLb.font = HEITI(HeightXiShu(12));
    [cell.contentView addSubview:nameLb];
    
    UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(78), HeightXiShu(8), WidthXiShu(240), HeightXiShu(14))];
    addressLb.text = @"浙江省杭州市下城区延安路168号外经贸B座9楼";
    addressLb.numberOfLines = 1;
    addressLb.textColor = TitleColor;
    addressLb.font = HEITI(HeightXiShu(10));
    [cell.contentView addSubview:addressLb];
    
    UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(78), HeightXiShu(22), WidthXiShu(240), HeightXiShu(14))];
    phoneLb.text = @"15236554566";
    phoneLb.numberOfLines = 1;
    phoneLb.textColor = TitleColor;
    phoneLb.font = HEITI(HeightXiShu(10));
    [cell.contentView addSubview:phoneLb];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(44), kScreenWidth, .5)];
    lineView.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:lineView];

    return cell;
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
