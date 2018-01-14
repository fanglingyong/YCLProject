//
//  MedicineDetailViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailViewController.h"
#import "NavView.h"
#import "MedicineDetailCell.h"
#import "MedicineDetailModel.h"

#import "CycleScrollView.h"
#import "MerchandiseFooterButton.h"

@interface MedicineDetailViewController ()<MerchandiseFooterButtonDelegate>

@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;


@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation MedicineDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.startIndex = 0;
        self.modelArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self navView];
    // Do any additional setup after loading the view.
    [self startUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"药品详情页";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
        
        navView.rightBtn.hidden = NO;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"more"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navView;
}

#pragma mark - UI
-(void)startUI{
    self.tableView.frame = CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY-HeightXiShu(50));
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footerView];
    _goodImageView.image = [UIImage imageNamed:@"sysIcon3.jpg"];
    [self.modelArr addObject:[self getMedicModel]];
    [self.tableView reloadData];
}

-(MedicineDetailModel *)getMedicModel{
    NSMutableDictionary * dic = [_model returnToDictionaryWithModel];
    MedicineDetailModel *model = [[MedicineDetailModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350))];
        headerView.backgroundColor = [UIColor whiteColor];
        self.goodImageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
        [headerView addSubview:_goodImageView];
        _headerView = headerView;
    }
    return _headerView;
}
- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(50), kScreenWidth, HeightXiShu(50))];
        footerView.delegate = self;
        footerView.backgroundColor = [UIColor whiteColor];
        _footerView = footerView;
    }
    return _footerView;
}
#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(1);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(1))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(200);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicineDetailModel *model = [[MedicineDetailModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"MedicineDetailCell";
    MedicineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MedicineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    return cell;
}
#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moreClick {
    NSLog(@"更多信息");
}
#pragma mark - 事件 MerchandiseFooterButtonDelegate
- (void)didCollectBtn:(UIButton *)button{
    //收藏
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];
    [pargrams setObject:_model.provider forKey:@"PROVIDER"];//供应商ID
    [pargrams setObject:_model.GoodsID forKey:@"GOODSID"];//货品ID
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:JoinCollect block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            [HUDUtil Hud_message:dict[@"message"] view:_headerView];
            self.footerView.collectImg.image = [UIImage imageNamed:@"collection"];
        }else{
            [HUDUtil Hud_message:error.domain view:_headerView];
        }
    } dic:pargrams noNetWork:nil];
}
- (void)didAddShopCartBtn:(UIButton *)button{
    //加入购物车
    MedicineDetailCell *cell = (MedicineDetailCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *amout = [NSString stringWithFormat:@"%ld",cell.num];
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"1" forKey:@"Opcode"];//1、加入购物车，2、修改数量，3、删除品种，7、清空购物车
    [pargrams setObject:_model.provider forKey:@"PROVIDER"];//供应商ID
    [pargrams setObject:_model.GoodsID forKey:@"GOODSID"];//货品ID
    [pargrams setObject:_model.asprice forKey:@"SELLPRICE"];//协议价格
    [pargrams setObject:_model.arprice forKey:@"RETAILPRICE"];//零售价
    [pargrams setObject:amout forKey:@"AMOUNT"];//数量
    [pargrams setObject:@"" forKey:@"ORDERMEMO"];
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:JoinShopCarURL block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            [HUDUtil Hud_message:dict[@"message"] view:_headerView];
        }else{
            [HUDUtil Hud_message:error.domain view:_headerView];
        }
    } dic:pargrams noNetWork:nil];
}
- (void)didProcurementBtn:(UIButton *)button{
    //立即采购
    
}

#pragma mark - 药品详情
-(void)net_goodsInfo{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];//
    [pargrams setObject:_model.GoodsID forKey:@"GoodsId"];//货品ID
    [pargrams setObject:_model.producer forKey:@"Producer"];//供应商ID
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:GetGoodsDetailInfo block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            
        }else{
            [HUDUtil Hud_message:error.domain view:_headerView];
        }
    } dic:pargrams noNetWork:nil];
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

