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

@interface ProcurementViewController ()<UITableViewDataSource, UITableViewDelegate, DropdownViewDelegate, HDDropdownButtonDelegate>

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
    
    
    self.tableView.mj_header = [[MJRefreshNormalHeader alloc] init];
    [self.tableView.mj_header setRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    [self addNoDataView];
    
    
    [self.allClassArray addObject:@"全部分类"];
    [self.allClassArray addObject:@"全部分类1"];
    [self.allClassArray addObject:@"全部分类2"];

    [self.suppliersArray addObject:@"全部分类"];
    [self.suppliersArray addObject:@"全部分类"];
    [self.suppliersArray addObject:@"全部分类"];
    
    [self.promotionsArray addObject:@"全部分类"];
    [self.promotionsArray addObject:@"全部分类"];
    [self.promotionsArray addObject:@"全部分类"];

   
    
    NSArray *array = [NSArray arrayWithObjects:self.allClassArray, self.suppliersArray, self.promotionsArray, nil];
    [self.procurement setupBasicArray:array];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)headRefresh {
    self.pageIndex = 1;
    [self handleData];
    
}

- (void)footRefresh {
    self.pageIndex += 1;
    [self handleData];
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

- (void)handleData {
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"goldAgent" forKey:@"_cmd_"];
    [dic setObject:@"orderList" forKey:@"type"];
    [dic setObject:[NSNumber numberWithInteger:self.pageIndex] forKey:@"page"];
    
    [dic setObject:@"10" forKey:@"number"]; // 默认10条
    
    // 全部分类
    if (self.procurement.allClass == 0) {
        [dic setObject:@"0" forKey:@"status"];
        
    } else if (self.procurement.allClass == 1) {
        [dic setObject:@"2" forKey:@"status"];
    } else {
        [dic setObject:@"3" forKey:@"status"];
    }
    
    // 车辆类型
    if (self.procurement.suppliers == 0) {
        [dic setObject:@"0" forKey:@"is_fullmoney"]; 
        
    } else if (self.procurement.suppliers == 1) {
        [dic setObject:@"1" forKey:@"is_fullmoney"]; 
    } else {
        [dic setObject:@"2" forKey:@"is_fullmoney"]; 
    }
    
    // 车辆类型
    if (self.procurement.promotions == 0) {
        [dic setObject:@"" forKey:@"jobs"];
    } else {
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    NSLog(@"%@", dic);
    
//    [JiltOrderApi watchOthersOrderListGoldAgentBlock:^(NSMutableArray *array, NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        if(!error){
//            if (self.pageIndex == 1) {
//                [self.dataArray removeAllObjects];
//                [self.dataArray addObjectsFromArray:array];
//            } else {
//                [self.dataArray addObjectsFromArray:array];
//            }
//
//            if (self.dataArray.count > 0) {
//                self.noDateView.hidden = YES;
//            } else {
//                self.noDateView.hidden = NO;
//            }
//
//            self.tableView.mj_footer.hidden = array.count > 0 ? YES : NO;
//        }
//
//        [self.tableView reloadData];
//
//    } dic:dic noNetWork:nil];
    
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
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        //        navView.titleLabel.text = @"定位中";
        
        UIImageView *boxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 75, 10, 150, 24)];
        boxImageView.image = [GetImagePath getImagePath:@"Agent_cityChoose_box"];
        navView.titleLabel.userInteractionEnabled = YES;
        [navView.titleLabel addSubview:boxImageView];
        
        UIImageView *localImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 12, 14)];
        localImageView.image = [GetImagePath getImagePath:@"Agent_cityChoose_local"];
        [boxImageView addSubview:localImageView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (localAction:)];
        [navView.titleLabel addGestureRecognizer:tap];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 7, 7, 10)];
        arrowImageView.image = [GetImagePath getImagePath:@"Agent_cityChoose_arrow"];
        [boxImageView addSubview:arrowImageView];
        
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [navView.rightBtn addTarget:self action:@selector(goJiltAction) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        //        _cityButton = button;
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
//    return self.dataArray.count;
    return 5;
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
    
    
   
    
    
    
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
            
            NSLog(@"dropView%lu", (unsigned long)self.dropView.selectedIndex);
            
            NSLog(@"全部分类");
            
        }
        if ([titleView isEqual:self.suppliersButton]) {
            
            self.suppliersButton.selected = YES;
            self.dropView.dataArray = self.procurement.suppliersArray;
            self.dropView.tag = 1002;
            self.dropView.selectedIndex = self.procurement.suppliers;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"dropView%lu", (unsigned long)self.dropView.selectedIndex);
            NSLog(@"供应商");
            
            
        }
        if ([titleView isEqual:self.promotionsButton]) {
            
            self.promotionsButton.selected = YES;
            self.dropView.dataArray = self.procurement.promotionsArray;
            self.dropView.tag = 1003;
            self.dropView.selectedIndex = self.procurement.promotions;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            NSLog(@"dropView%lu", (unsigned long)self.dropView.selectedIndex);
            NSLog(@"促销");
            
        }
        
    }
    
    
}

- (void)didSelectRowOfFilterView:(DropdownView *)filterView {
    
    if (filterView.tag == 1001) {
        
        self.procurement.allClass = ((DropdownSimpleView *)filterView).selectedIndex;
        self.allClassButton.title = self.procurement.allClassTitle;
        
    }
    if (filterView.tag == 1002) {
        
        self.procurement.suppliers = ((DropdownSimpleView *)filterView).selectedIndex;
        self.suppliersButton.title = self.procurement.suppliersTitle;
        
    }
    if (filterView.tag == 1003) {
        
        self.procurement.promotions = ((DropdownSimpleView *)filterView).selectedIndex;
        
        self.promotionsButton.title = self.procurement.promotionsTitle;
        
    }
    
    [self deselectButtons];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)didHideFilterView:(DropdownView *)filterView {
    
    [self deselectButtons];
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


