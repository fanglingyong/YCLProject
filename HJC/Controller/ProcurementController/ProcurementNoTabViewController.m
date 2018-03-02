//
//  ProcurementNoTabViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/2/28.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ProcurementNoTabViewController.h"
#import "NavView.h"
#import "ProcurementModel.h"
#import "ProcurementCell.h"
#import "MJRefresh.h"
#import "MedicineDetailViewController.h"

@interface ProcurementNoTabViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NavView *navView;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, assign)NSInteger pageIndex;
@property (nonatomic, retain)UIView *noDateView;

@end

@implementation ProcurementNoTabViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    // Do any additional setup after loading the view.
    [self creatTableView];
    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [self network_procurementList];
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

#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        switch (self.classType) {
            case 1:
                navView.titleLabel.text = @"化学药";
                break;
            case 2:
                navView.titleLabel.text = @"中成药";
                break;
            case 3:
                navView.titleLabel.text = @"抗生素剂";
                break;
            default:
                break;
        }
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  kStateHeight + 44, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.tableView];
    
}

-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)network_procurementList{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    if (_pageIndex == 1) {
        pargrams = [NSMutableDictionary dictionary];
    }
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",self.pageIndex] forKey:@"WebPara"];
    [pargrams setObject:[NSString stringWithFormat:@"%ld,%@,%@",(long)self.classType,@"0",@""] forKey:@"Parastr"];// 分类DataID,供应商id,药品名称 [药品名称，不要传促销，促销会单独跳转。而不是放到参数里面请求]
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
