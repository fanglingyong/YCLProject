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
@interface ProcurementViewController ()<UITableViewDataSource, UITableViewDelegate, DropdownViewDelegate, HDDropdownButtonDelegate, UIScrollViewDelegate>

@property(nonatomic,strong)NavView *navView;


@property (nonatomic, retain)Procurement *procurement;

@property (nonatomic, retain)DropdownSimpleView *dropView;

@property (nonatomic, retain)HDDropdownButton *allClassButton;
@property (nonatomic, retain)HDDropdownButton *suppliersButton;
@property (nonatomic, retain)HDDropdownButton *promotionsButton;

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
    [self network_procurementList];
}

- (void)footRefresh {
    self.pageIndex += 1;
    [self network_procurementList];
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
    
    // 全部分类
    self.allClassButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake(0, 64, (kScreenWidth - 2) / 3, HeightXiShu(49))];
    self.allClassButton.delegate = self;
    self.allClassButton.backgroundColor = [UIColor whiteColor];
    self.allClassButton.frontColor = TitleColor;
    self.allClassButton.title = self.procurement.allClassTitle;
    [self.view addSubview:self.allClassButton];
    
    UIView *cutLine1 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 2) / 3, 64 + HeightXiShu(15), 1, HeightXiShu(20))];
    cutLine1.backgroundColor = AllLightGrayColor;
    [self.view addSubview:cutLine1];
    
    // 供应商
    self.suppliersButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake((kScreenWidth - 2) / 3 + 1, 64, (kScreenWidth - 2) / 3, HeightXiShu(49))];
    self.suppliersButton.delegate = self;
    self.suppliersButton.backgroundColor = [UIColor whiteColor];
    self.suppliersButton.frontColor = TitleColor;
    self.suppliersButton.title = self.procurement.suppliersTitle;
    [self.view addSubview:self.suppliersButton];
    
    UIView *cutLine2 = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 2) * 2 / 3 + 1, 64 + HeightXiShu(15), 1, HeightXiShu(20))];
    cutLine2.backgroundColor = AllLightGrayColor;
    [self.view addSubview:cutLine2];
    
    // 促销
    self.promotionsButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake((kScreenWidth - 2) * 2 / 3 + 2, 64, (kScreenWidth - 2) / 3, HeightXiShu(49))];
    self.promotionsButton.backgroundColor = [UIColor whiteColor];
    self.promotionsButton.frontColor = TitleColor;
    self.promotionsButton.delegate = self;
    self.promotionsButton.title = self.procurement.promotionsTitle;
    [self.view addSubview:self.promotionsButton];
    
    
    UIView *cutLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + HeightXiShu(49), kScreenWidth, 1)];
    cutLine3.backgroundColor = AllLightGrayColor;
    [self.view addSubview:cutLine3];
    
    self.dropView = [[DropdownSimpleView alloc] initWithFrame:CGRectMake(0, 64 + HeightXiShu(50), kScreenWidth, kScreenHeight - HeightXiShu(50))];
    self.dropView.delegate = self;
    self.dropView.hidden = YES;
    [self.view addSubview:self.dropView];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  64 + HeightXiShu(50), kScreenWidth, kScreenHeight - 64 - HeightXiShu(50)) style:UITableViewStylePlain];
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
        
        navView.rightBtn.hidden = NO;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"search"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}
#pragma mark - 事件

- (void)searchClick {
    ProcureSearchViewController *VC = [[ProcureSearchViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)deselectButtons {
    self.allClassButton.selected = NO;
    self.suppliersButton.selected = NO;
    self.promotionsButton.selected = NO;
    self.dropView.hidden = YES;
}

- (void)dropdownButton:(HDDropdownButton *)titleView didTapButton:(UIButton *)sender {
    if (titleView.selected == YES) {
        [self deselectButtons];
    } else {
        [self deselectButtons];
        if ([titleView isEqual:self.allClassButton]) {
            self.allClassButton.selected = YES;
            self.dropView.dataArray = self.procurement.allClassArray;
            self.dropView.tag = 1001;
            self.dropView.selectedIndex = self.procurement.allClass;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"全部分类：dropView%lu", (unsigned long)self.dropView.selectedIndex);
        }
        if ([titleView isEqual:self.suppliersButton]) {
            self.suppliersButton.selected = YES;
            self.dropView.dataArray = self.procurement.suppliersArray;
            self.dropView.tag = 1002;
            self.dropView.selectedIndex = self.procurement.suppliers;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"供应商：dropView%lu", (unsigned long)self.dropView.selectedIndex);
        }
        if ([titleView isEqual:self.promotionsButton]) {
            self.promotionsButton.selected = YES;
            self.dropView.dataArray = self.procurement.promotionsArray;
            self.dropView.tag = 1003;
            self.dropView.selectedIndex = self.procurement.promotions;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"促销：dropView%lu", (unsigned long)self.dropView.selectedIndex);
        }
    }
}

- (void)didSelectRowOfFilterView:(DropdownView *)filterView {
    if (filterView.tag == 1001) {
        self.procurement.allClass = ((DropdownSimpleView *)filterView).selectedIndex;
        self.allClassButton.title = self.procurement.allClassTitle;
        NSLog(@"%lu", (unsigned long)self.procurement.allClass);
    }
    if (filterView.tag == 1002) {
        self.procurement.suppliers = ((DropdownSimpleView *)filterView).selectedIndex;
        self.suppliersButton.title = self.procurement.suppliersTitle;
        NSLog(@"%lu", (unsigned long)self.procurement.suppliers);
    }
    if (filterView.tag == 1003) {
        self.procurement.promotions = ((DropdownSimpleView *)filterView).selectedIndex;
        self.promotionsButton.title = self.procurement.promotionsTitle;
        NSLog(@"%lu", (unsigned long)self.procurement.promotions);
        return;//因为促销不和前面两个流程一样。
    }
    [self deselectButtons];
    self.pageIndex = 1;
    [self network_procurementList];
}

- (void)didHideFilterView:(DropdownView *)filterView {
    
    [self deselectButtons];
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
            NSMutableArray *promotionsName = [NSMutableArray arrayWithObjects:@"不限",@"corpid", @"买100W送iPhone X 10台", nil];
            [self.promotionsArray addObjectsFromArray:@[@"", @"", @""]];
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


