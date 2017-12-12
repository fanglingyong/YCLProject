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
@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)UITableView *headTableView;
@property (nonatomic, retain)UITableView *footTableView;

@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    
    self.headTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    [self.headTableView setMinY:64 maxY:kScreenHeight - 49];
    self.headTableView.delegate = self;
    self.headTableView.dataSource = self;
    self.headTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headTableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.headTableView];
    
    self.footTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49 - HeightXiShu(160), kScreenWidth, HeightXiShu(160)) style:UITableViewStyleGrouped];
    self.footTableView.delegate = self;
    self.footTableView.dataSource = self;
    self.footTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.footTableView.backgroundColor = AllBackLightGratColor;
//    [self.view addSubview:self.footTableView];
    
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

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.headTableView) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.headTableView) {
        return 10;
    }
    if (section == 0) {
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.headTableView) {
        return HeightXiShu(10);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.headTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
        view.backgroundColor = AllLightGrayColor;
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(50))];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(16), WidthXiShu(15), HeightXiShu(18))];
    selectImg.image = [GetImagePath getImagePath:@"cartSelect"];
    [view addSubview:selectImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(60), 0, WidthXiShu(160), HeightXiShu(50))];
    label.text = @"总计: 43.00";
    label.textColor = BlackColor;
    label.font = HEITI(HeightXiShu(16));
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - WidthXiShu(125), 0, WidthXiShu(125), HeightXiShu(50));
    [button setTitle:@"生成订单" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor blueColor];
    [view addSubview:button];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.headTableView) {
        return HeightXiShu(96);
    }
    if (indexPath.section == 0) {
        return 0;
    }
    return HeightXiShu(110);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.headTableView) {
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
