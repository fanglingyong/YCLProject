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
#import "LoginViewController.h"
#import "CycleScrollView.h"
#import "MerchandiseFooterButton.h"
#import "ShopCarViewController.h"

@interface MedicineDetailViewController ()<MerchandiseFooterButtonDelegate>

@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, strong) UIImageView *goodImageView;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;
@property (nonatomic, strong) MedicineDetailModel *model;

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
    [self net_goodsInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = [UIApplication sharedApplication].statusBarFrame.size.height;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"药品详情页";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
        
        navView.rightBtn.hidden = YES;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"more"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navView;
}

#pragma mark - UI
-(void)startUI{
    self.tableView.frame = CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-SafeAreaBottomHeight-_navView.maxY-HeightXiShu(50));
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footerView];
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",BigPic,_model.GOODSPIC] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"default"]];
    [self.tableView reloadData];
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
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight-SafeAreaBottomHeight - HeightXiShu(50), kScreenWidth, HeightXiShu(50))];
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
    static NSString* const identifier = @"MedicineDetailCell";
    MedicineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MedicineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _model;
    return cell;
}
#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moreClick {
//    NSLog(@"更多信息");
}
#pragma mark - 事件 MerchandiseFooterButtonDelegate
- (void)didCollectBtn:(UIButton *)button{
    //收藏
    if ([AnimaDefaultUtil getUserIsLogin]) {
        NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"Userid"];
        [pargrams setObject:_model.CORPID forKey:@"PROVIDER"];//供应商ID
        [pargrams setObject:_model.GOODSID forKey:@"GOODSID"];//货品ID
        NSLog(@"-- pargrams:%@",pargrams);
        [BaseApi getMenthodWithUrl:JoinCollect block:^(NSDictionary *dict, NSError *error) {
            if (!error) {
                [HUDUtil Hud_message:dict[@"message"] view:_headerView];
                self.footerView.collectImg.image = [UIImage imageNamed:@"collection"];
            }else{
                [HUDUtil Hud_message:error.domain view:_headerView];
            }
        } dic:pargrams noNetWork:nil];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }
}
- (void)didAddShopCartBtn:(UIButton *)button{
    if ([AnimaDefaultUtil getUserIsLogin]) {
        [self joinGoodsToShopCarWithJump:NO];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }
}
- (void)didProcurementBtn:(UIButton *)button{
    //立即采购-->加入购物车操作后立即立即跳转到购物车
    if ([AnimaDefaultUtil getUserIsLogin]) {
        [self joinGoodsToShopCarWithJump:YES];
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    }
}
- (void)joinGoodsToShopCarWithJump:(BOOL)isJump{
    //加入购物车
    if (isJump) {
        [MBProgressHUD showHUDAddedTo:_headerView animated:YES];
    }
    MedicineDetailCell *cell = (MedicineDetailCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *amout = [NSString stringWithFormat:@"%ld",cell.num];
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"1" forKey:@"Opcode"];//1、加入购物车，2、修改数量，3、删除品种，7、清空购物车
    [pargrams setObject:_model.CORPID forKey:@"PROVIDER"];//供应商ID
    [pargrams setObject:_model.GOODSID forKey:@"GOODSID"];//货品ID
    [pargrams setObject:_model.SELLPRICE forKey:@"SELLPRICE"];//协议价格
    [pargrams setObject:_model.RETAILPRICE forKey:@"RETAILPRICE"];//零售价
    [pargrams setObject:amout forKey:@"AMOUNT"];//数量
    [pargrams setObject:@"" forKey:@"ORDERMEMO"];
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:JoinShopCarURL block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            if (isJump) {
                [MBProgressHUD hideHUDForView:_headerView animated:YES];
                ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
                [self.navigationController pushViewController:shopcar animated:YES];
            }else{
                [HUDUtil Hud_message:dict[@"message"] view:_headerView];
            }
        }else{
            [HUDUtil Hud_message:error.domain view:_headerView];
        }
    } dic:pargrams noNetWork:nil];
}

#pragma mark - 药品详情
-(void)net_goodsInfo{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"UserID"];//
    [pargrams setObject:_goodsID forKey:@"GoodsId"];//货品ID
    [pargrams setObject:_provider forKey:@"Producer"];//供应商ID
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:GetGoodsDetailInfo block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            _model = [[MedicineDetailModel alloc] init];
            [_model setValuesForKeysWithDictionary:dict[@"data"][0]];
//            [self.modelArr addObject:_model];
            [self startUI];
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

