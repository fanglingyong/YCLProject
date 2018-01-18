//
//  MyCollectViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyCollectViewController.h"
#import "NavView.h"
#import "CollectCell.h"
#import "CollectModel.h"
#import "MJRefresh.h"

@interface MyCollectViewController ()<CollectCancelDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,assign)NSInteger page;
@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    self.page = 1;
    self.modelArr = [NSMutableArray array];
    [self.tableView setMinY:kStateHeight+44 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextPage)];
    [self network_get_collect];
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
        navView.titleLabel.text = @"收藏夹";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - tableView delegate dataSource
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
    return HeightXiShu(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectModel *model = [[CollectModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"CollectCell";
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.model = model;
    return cell;
}
-(void)deleteCollectAction:(NSInteger)row{
    [self net_cancel_collect:row];
}
#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - net
-(void)nextPage{
    _page+=1;
}
-(void)network_get_collect{
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"4," forKey:@"Parastr"];//供应商ID 4-股份
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",_page] forKey:@"WebPara"];//货品ID
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:GetCollect block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
//            NSLog(@"%@",dict);
            for (NSDictionary*modelDic in dict[@"data"]) {
                CollectModel*model = [[CollectModel alloc] init];
                [model setValuesForKeysWithDictionary:modelDic];
                [_modelArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:error.domain view:self.view];
        }
    } dic:pargrams noNetWork:nil];
}
-(void)net_cancel_collect:(NSInteger)row{
    CollectModel *model = [[CollectModel alloc] init];
    model = _modelArr[row];
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];
    [pargrams setObject:model.GoodsID forKey:@"GOODSID"];
    [pargrams setObject:model.provider forKey:@"PROVIDER"];
    NSLog(@"-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:CancelShouCang block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            //            NSLog(@"%@",dict);
            //删除数组里面的值 然后再删除cell
            [_modelArr removeObjectAtIndex:row];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
//            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:error.domain view:self.view];
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
