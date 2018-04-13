//
//  ProcurementViewController.m
//  HJC
//
//  Created by 陈晨 on 2017/12/1.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ProcurementViewController.h"
#import "NavView.h"
#import "HDDropdownButton.h"
#import "DropdownSimpleView.h"
#import "Procurement.h"
#import "ProcurementModel.h"
#import "ProcurementCell.h"
#import "MJRefresh.h"
#import "MedicineDetailViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "ProcureSearchViewController.h"
@interface ProcurementViewController ()<UITableViewDataSource, UITableViewDelegate, DropdownViewDelegate, HDDropdownButtonDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong)NavView *navView;


@property (nonatomic, retain)Procurement *procurement;

@property (nonatomic, retain)DropdownSimpleView *dropView;

@property (nonatomic, retain)HDDropdownButton *suppliersButton;
@property (nonatomic, retain)UITextField *searchTF;
@property (nonatomic, retain)UIButton *searchBtn;

@property (nonatomic, retain)NSMutableArray *allClassArray;
@property (nonatomic, retain)NSMutableArray *suppliersArray;
@property (nonatomic, retain)NSMutableArray *promotionsArray;

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;

@property (nonatomic, assign)BOOL isRefresh;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, retain)UIView *noDateView;

@property (nonatomic, strong) NSMutableDictionary * pargrams;

@end

@implementation ProcurementViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allClassArray = [NSMutableArray array];
        self.suppliersArray = [NSMutableArray array];
        self.promotionsArray = [NSMutableArray array];
        
        self.procurement = [[Procurement alloc] init];
        self.dataArray = [NSMutableArray array];
        self.pageIndex = 1;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self statusBar];
    [self navView];
    [self creatTableView];
    [self creatDropDownView];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];
//    [self addNoDataView];
    [self getCategory];
    // 加载数据
    [self.allClassArray addObject:@"0"];
    [self.suppliersArray addObject:@"0"];
    [self.promotionsArray addObject:@""];
}
- (void)initLogin {
    
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];
    if([model.P_LSM intValue] == 0){
        LoginViewController *login = [[LoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
        login.refeshBlock = ^{
            [self.tableView reloadData];
        };
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else {
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    [self initLogin];
}


- (void)headRefresh {
    self.pageIndex = 1;
    if (self.searchTF.text.length > 0) {
        [self network_procurementList:self.searchTF.text];
    } else {
        [self network_procurementList];
    }}

- (void)footRefresh {
    self.pageIndex += 1;
    if (self.searchTF.text.length > 0) {
        [self network_procurementList:self.searchTF.text];
    } else {
        [self network_procurementList];
    }
}

- (void)addNoDataView {
    self.noDateView.hidden = YES;
    [self.tableView addSubview:self.noDateView];
}
- (UIView *)noDateView {
    
    if (!_noDateView) {
        UIView *noDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - HeightXiShu(50))];
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
    CGFloat toTop = kStateHeight+44;
    
    // 供应商
    self.suppliersButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake(0, toTop, (kScreenWidth - 2) / 3, HeightXiShu(49))];
    self.suppliersButton.delegate = self;
    self.suppliersButton.backgroundColor = [UIColor whiteColor];
    self.suppliersButton.frontColor = TitleColor;
    self.suppliersButton.title = self.procurement.suppliersTitle;
    [self.view addSubview:self.suppliersButton];
    
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - 2) / 3, toTop + HeightXiShu(15), WidthXiShu(200), HeightXiShu(20))];
    self.searchTF.delegate = self;
    self.searchTF.placeholder = @"搜索品名";
    self.searchTF.clearButtonMode = UITextFieldViewModeAlways;
    self.searchTF.font = HEITI(HeightXiShu(13));
    [self.view addSubview:self.searchTF];
    
    UIView *cutLine2 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 2) / 3, self.searchTF.maxY + HeightXiShu(2), WidthXiShu(200), 1)];
    cutLine2.backgroundColor = AllLightGrayColor;
    [self.view addSubview:cutLine2];

    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(40), toTop + HeightXiShu(17), WidthXiShu(16), HeightXiShu(16));
    [self.searchBtn setImage:[GetImagePath getImagePath:@"search"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.searchBtn];
    
    
    self.dropView = [[DropdownSimpleView alloc] initWithFrame:CGRectMake(0, toTop + HeightXiShu(50), kScreenWidth, kScreenHeight - HeightXiShu(50))];
    self.dropView.delegate = self;
    self.dropView.hidden = YES;
    [self.view addSubview:self.dropView];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  kStateHeight+44 + HeightXiShu(50), kScreenWidth, kScreenHeight - 64 - HeightXiShu(50)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - 页面元素

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"采购";
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchClick];
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTF resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"搜搜");
}

#pragma mark - tableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HeightXiShu(135);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProcurementModel *model = [[ProcurementModel alloc] init];
    if (self.dataArray.count > 0) {
        model = self.dataArray[indexPath.row];
    }
    static NSString *identifier = @"ProcurementCell";
    ProcurementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ProcurementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MedicineDetailViewController *VC = [[MedicineDetailViewController alloc] init];
    ProcurementModel *model = _dataArray[indexPath.row];
    VC.goodsID = model.GoodsID;
    VC.provider = model.provider;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 事件

- (void)searchClick {

    [self.searchTF resignFirstResponder];
    if (![AnimaDefaultUtil isNotNull:self.searchTF.text] ) {
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
            [self.tableView reloadData];
        }
        [self network_procurementList];
        return;
    }
    [self searchWillToDo];
    [self network_procurementList:self.searchTF.text];
}
-(void)searchWillToDo{
    if ([self.searchTF canResignFirstResponder]) {
        [self.searchTF resignFirstResponder];
    }
    if (self.dataArray.count > 0) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
    }
}


- (void)deselectButtons {
    self.suppliersButton.selected = NO;
    self.dropView.hidden = YES;
}

- (void)dropdownButton:(HDDropdownButton *)titleView didTapButton:(UIButton *)sender {
    if (titleView.selected == YES) {
        [self deselectButtons];
    } else {
        [self deselectButtons];
        if ([titleView isEqual:self.suppliersButton]) {
            self.suppliersButton.selected = YES;
            self.dropView.dataArray = self.procurement.suppliersArray;
            self.dropView.tag = 1002;
            self.dropView.selectedIndex = self.procurement.suppliers;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"供应商：dropView%lu", (unsigned long)self.dropView.selectedIndex);
        }
    }
}

- (void)didSelectRowOfFilterView:(DropdownView *)filterView {
    if (filterView.tag == 1002) {
        self.procurement.suppliers = ((DropdownSimpleView *)filterView).selectedIndex;
        self.suppliersButton.title = self.procurement.suppliersTitle;
        NSLog(@"%lu", (unsigned long)self.procurement.suppliers);
    }
    [self deselectButtons];
    self.pageIndex = 1;
    [self network_procurementList];
}

- (void)didHideFilterView:(DropdownView *)filterView {
    
    [self deselectButtons];
}

#pragma mark - 接口
-(void)network_procurementList:(NSString*)searchContent{
    
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",self.pageIndex] forKey:@"WebPara"];

    [pargrams setObject:[NSString stringWithFormat:@"0,0,%@",searchContent] forKey:@"Parastr"];// 分类DataID,供应商id,药品名称 [药品名称，不要传促销，促销会单独跳转。而不是放到参数里面请求]
    [pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"UserID"];//暂时设置为0因为只有0才有结果
    NSLog(@"这是采购页面pargrams :%@", pargrams);
    [BaseApi getMenthodWithUrl:GetGoodsListURL block:^(NSDictionary *dict, NSError *error) {
        [_tableView.mj_footer endRefreshing];
        if(!error){
            NSLog(@"请求成功了~~~~~~~~");
            NSArray *goodsArr = [NSArray arrayWithArray:dict[@"data"]];
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
                if (goodsArr.count > 0) {
                    self.noDateView.hidden = YES;
                }
                self.noDateView.hidden = NO;
            }
            for (NSDictionary *dic in goodsArr) {
                ProcurementModel *model = [[ProcurementModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            self.tableView.mj_footer.hidden = goodsArr.count == 10 ? NO : YES;
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:error.domain view:self.view];
        }
    } dic:pargrams noNetWork:nil];
    
}

#pragma mark - net
- (void)getCategory {
    /**
     参数说明
     */
    [BaseApi getMenthodWithUrl:GetORDERLIST block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            // 种类
            NSMutableArray *allClassName = [NSMutableArray array];
            [allClassName addObject:@"不限"];
            for (NSDictionary *tempDic in [dict[@"data"] objectForKey:@"yaopin"]) {
                [self.allClassArray addObject:[tempDic objectForKey:@"DataID"]];
                [allClassName addObject:[tempDic objectForKey:@"Name"]];
            }
            // 供应商
            NSMutableArray *suppliersName = [NSMutableArray array];
            [suppliersName addObject:@"不限"];
            for (NSDictionary *tempDic in [dict[@"data"] objectForKey:@"gongyingshang"]) {
                [self.suppliersArray addObject:[tempDic objectForKey:@"corpid"]];
                [suppliersName addObject:[tempDic objectForKey:@"corpname"]];
            }
            NSMutableArray *promotionsName = [NSMutableArray arrayWithObjects:@"不限", nil];
            [self.promotionsArray addObjectsFromArray:@[@""]];
            NSArray *array = [NSArray arrayWithObjects:allClassName, suppliersName, promotionsName, nil];
            [self.procurement setupBasicArray:array];
            
        }else{
            NSLog(@"error:%@",error);
        }
    } dic:nil noNetWork:nil];
    
    
}
-(void)network_procurementList{
    if (_pageIndex == 1) {
        self.pargrams = [NSMutableDictionary dictionary];
    }
    [_pargrams setObject:[NSString stringWithFormat:@",10,%ld",self.pageIndex] forKey:@"WebPara"];
    NSString *dataID = [AnimaDefaultUtil isNotNull:self.allClassArray]?self.allClassArray[self.procurement.allClass]:@"0";
    NSString *gysID = [AnimaDefaultUtil isNotNull:self.suppliersArray]?self.suppliersArray[self.procurement.suppliers]:@"0";
    [_pargrams setObject:[NSString stringWithFormat:@"%@,%@,%@",dataID,gysID,@""] forKey:@"Parastr"];// 分类DataID,供应商id,药品名称 [药品名称，不要传促销，促销会单独跳转。而不是放到参数里面请求]
    [_pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"UserID"];//暂时设置为0因为只有0才有结果
    NSLog(@"这是采购页面pargrams :%@", _pargrams);
    [BaseApi getMenthodWithUrl:GetGoodsListURL block:^(NSDictionary *dict, NSError *error) {
        [_tableView.mj_footer endRefreshing];
        if(!error){
            NSLog(@"请求成功了~~~~~~~~");
            NSArray *goodsArr = [NSArray arrayWithArray:dict[@"data"]];
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
                if (goodsArr.count > 0) {
                    self.noDateView.hidden = YES;
                }
                self.noDateView.hidden = NO;
            }
            for (NSDictionary *dic in goodsArr) {
                ProcurementModel *model = [[ProcurementModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            self.tableView.mj_footer.hidden = goodsArr.count == 10 ? NO : YES;
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:error.domain view:self.view];
        }
    } dic:_pargrams noNetWork:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


