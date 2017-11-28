//
//  MyOrderViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/27.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MyOrderViewController.h"
#import "NavView.h"
#import "OrderCell.h"

@interface MyOrderViewController ()

@property(nonatomic,strong)NavView *navView;
@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation MyOrderViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
    
    [self.tableView setMinY:64 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)dealloc{
    NSLog(@"MyOrderViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //        return self.modelArr.count;
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return HeightXiShu(168);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *model = [[OrderModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = AllBackLightGratColor;
    }
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    OrderDetailViewController *VC = [[OrderDetailViewController alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 事件
-(void)reloadData{
    NSLog(@"AllOrderViewController reloadData");
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}


#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"个人中心";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"orderSearch"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchClick {
    
    
}

#pragma mark - 接口
- (void)handleData {
    
    
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
