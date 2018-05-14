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
#import "SubmitOrdersViewController.h"

@interface ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource,ShopCartCellDelegate>
@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UITableView *mainTableView;

@property (nonatomic, retain)UIView *footView;
@property (nonatomic, strong)UILabel*momeyLable;

@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,assign) double total;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.footView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 页面元素
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"购物车";
        navView.leftBtn.hidden = YES;
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
-(UIView*)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-89, kScreenWidth, 40)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *allSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        allSelect.frame = CGRectMake(0, 0, 60, 40);
        [allSelect setImage:[UIImage imageNamed:@"cartDefault"] forState:UIControlStateNormal];
        [allSelect setImage:[UIImage imageNamed:@"cartSelect"] forState:UIControlStateSelected];
        [allSelect setTitle:@" 全选" forState:UIControlStateNormal];
        [allSelect setTitle:@" 全选" forState:UIControlStateSelected];
        allSelect.titleLabel.font = [UIFont systemFontOfSize:15];
        [allSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allSelect setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [allSelect addTarget:self action:@selector(allselectOrdersAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:allSelect];
        
        self.momeyLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-248, 5, 160, 30)];
        _momeyLable.text = @"合计:￥0.00";
        _momeyLable.textAlignment = NSTextAlignmentRight;
        _momeyLable.font = [UIFont systemFontOfSize:15];
        [_footView addSubview:_momeyLable];
        
        UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
        submit.frame = CGRectMake(kScreenWidth-80, 0, 80, 40);
        [submit setTitle:@"去结算 >>" forState:UIControlStateNormal];
        submit.backgroundColor = [UIColor colorFromHexCode:@"#2E58FF"];
        submit.titleLabel.font = [UIFont systemFontOfSize:13 weight:500];
        [submit addTarget:self action:@selector(submitOrdersAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:submit];
    }
    return _footView;
}
#pragma mark - 事件
-(void)allselectOrdersAction:(UIButton*)sender{
    sender.userInteractionEnabled = NO;
    if (sender.isSelected) {
        for (ShoppingCartModel*model in _modelArr) {
            [model setIsSelect:NO];
        }
    }else{
        for (ShoppingCartModel*model in _modelArr) {
            [model setIsSelect:YES];
        }
    }
    [_mainTableView reloadData];
    [self updatePrice];
    sender.selected = !sender.isSelected;
    sender.userInteractionEnabled = YES;
}
-(void)submitOrdersAction:(UIButton*)sender{
    NSString *tempOrder = @"";
    NSString *orderno = @"";
    NSMutableArray * tempArray = [NSMutableArray array];
    for (ShoppingCartModel*model in _modelArr) {
        if (model.isSelect) {
            if ([tempOrder isEqualToString:@""]) {
                tempOrder = [NSString stringWithFormat:@"%@",model.orderid];
            }else{
                tempOrder = [NSString stringWithFormat:@"%@,%@",tempOrder,model.orderid];
            }
            orderno = model.orderno;
            [tempArray addObject:model];
        }
    }
    if ([AnimaDefaultUtil isNotNull:tempOrder]) {
//        NSLog(@"提交订单");
        SubmitOrdersViewController *submitOrder = [[SubmitOrdersViewController alloc]init];
        submitOrder.hidesBottomBarWhenPushed = YES;
        submitOrder.orderIDs = [NSString stringWithFormat:@"%@",tempOrder];
        submitOrder.orderNo = orderno;
        submitOrder.modelArr = tempArray;
        submitOrder.totalMoeny = _total;
        [self.navigationController pushViewController:submitOrder animated:YES];
    }else{
//        NSLog(@"购物车为空");
        [HUDUtil Hud_message:@"无订单可提交" view:self.view];
    }
}
-(void)updatePrice{
    _total = 0.00;
    if (_modelArr.count>0) {
        for (ShoppingCartModel *model in _modelArr) {
            if (model.isSelect) {
                _total += [model.sellprice doubleValue]*[model.amount integerValue];
            }
        }
    }
    NSString*totalStr = [NSString stringWithFormat:@"合计:￥%.2f",_total];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#2E58FF"] range:NSMakeRange(3,totalStr.length-3)];
    _momeyLable.attributedText = attStr;
}
#pragma mark - tableView delegate dataSource
-(UITableView*)mainTableView{
    if (!_mainTableView) {
        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-89) style:UITableViewStylePlain];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mainTableView.backgroundColor = AllBackLightGratColor;
    }
    return _mainTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArr.count;
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
    return HeightXiShu(96);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    cell.delegate = self;
    cell.model = model;
    cell.row = indexPath.row;
    return cell;
}
#pragma mark - cell delegate
-(void)updateCellForData:(NSInteger)row{
//    NSLog(@"选中/取消");
    [self updatePrice];
}
-(void)deleteThisCell:(NSInteger)row{
//    NSLog(@"删除品种");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该记录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self net_update:_modelArr[row] type:@"3" oldCount:@""];
        [_modelArr removeObjectAtIndex:row];
        [self updatePrice];
        [_mainTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        //    [_mainTableView reloadData];
    }];
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)changeOrderDetail:(NSInteger)row oldCount:(NSString*)oldCount{
//    NSLog(@"修改品种数量");
    [self updatePrice];
    [self net_update:_modelArr[row] type:@"2" oldCount:oldCount];
}
#pragma mark - 网络请求
/**
 更新细单请求

 @param model modeldata
 @param type 更新类型 1、加入购物车，2、修改数量，3、删除品种，7、清空购物车
 */
-(void)net_update:(ShoppingCartModel*)model type:(NSString*)type oldCount:(NSString*)oldCount{

    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:type forKey:@"Opcode"];//
    [pargrams setObject:model.provider forKey:@"PROVIDER"];//供应商ID
    [pargrams setObject:model.goodsid forKey:@"GOODSID"];//货品ID
    [pargrams setObject:model.sellprice forKey:@"SELLPRICE"];//协议价格
    [pargrams setObject:model.retailprice forKey:@"RETAILPRICE"];//零售价
    [pargrams setObject:model.amount forKey:@"AMOUNT"];//数量
    [pargrams setObject:@"" forKey:@"ORDERMEMO"];
    NSLog(@"参数-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:JoinShopCarURL block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"success:%@",dict[@"message"]);
        }else{
            NSLog(@"error:%@",error);
            if ([type isEqualToString:@"2"]) {
                model.amount = oldCount;
                [self.mainTableView reloadData];
                [self updatePrice];
            }else if ([type isEqualToString:@"3"]){
                [_modelArr addObject:model];
                [self.mainTableView reloadData];
                [self updatePrice];
            }
        }
    } dic:pargrams noNetWork:nil];
}
/**
 拉取服务器上的购物车内容
 */
- (void)net_workforshopcar{
    if ([UserModel getUserModel]) {
        NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
        [pargrams setObject:@",1000,1" forKey:@"WebPara"];
        [BaseApi getMenthodWithUrl:GetShopCarInfo block:^(NSDictionary *dict, NSError *error) {
            if (!error) {
                _modelArr = [NSMutableArray array];
                for (NSDictionary *modelDic in dict[@"data"]) {
                    ShoppingCartModel*model = [[ShoppingCartModel alloc] init];
                    [model setValuesForKeysWithDictionary:modelDic];
                    [_modelArr addObject:model];
                }
                [self updatePrice];
                [_mainTableView reloadData];
            }else{
                [self updatePrice];
                [HUDUtil Hud_message:error.domain view:self.view];
            }
        } dic:pargrams noNetWork:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self net_workforshopcar];
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
