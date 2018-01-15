//
//  OrderDetailInfoViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/10.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "OrderDetailInfoViewController.h"
#import "NavView.h"
#import "OrderTotalCell.h"

@interface OrderDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation OrderDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"细单详情";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableView / Delgate &dataSource
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = AllBackLightGratColor;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    view.backgroundColor = [UIColor colorFromHexCode:@"#e9e9e9"];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section==3){
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 53;
        }
        return 88;
    }else if (indexPath.section==1){
        return 50;
    }else if (indexPath.section == 2){
        return 50;
    }else if (indexPath.section==3){
        return 60;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            OrderDetailOrderNumCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailOrderNumCell"];
            if (!cell) {
                cell = [[OrderDetailOrderNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailOrderNumCell"];
            }
            return cell;
        }else{
            OrderDetailInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailInfoCell"];
            if (!cell) {
                cell = [[OrderDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailInfoCell"];
            }
            return cell;
        }
    }else if (indexPath.section<=2){
        OrderDetailPublicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailPublicCell"];
        if (!cell) {
            cell = [[OrderDetailPublicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDetailPublicCell"];
        }
        if (indexPath.section==1) {
            cell.contentlb.textAlignment = NSTextAlignmentLeft;
            if (indexPath.row==0) {
                //收货地址
                cell.titlelb.text = @"收货地址";
                cell.contentlb.text = @"刘亦菲  18850015505 \n杭州市上城区清泰街444号东方大厦B幢1704室";
                cell.contentlb.font = [UIFont systemFontOfSize:12];
                cell.contentlb.textColor = [UIColor colorFromHexCode:@"#000000"];
            }else if (indexPath.row==1){
                //备注
                cell.titlelb.text = @"备注";
                cell.contentlb.text = @"你在逗我玩吗？？？";
                cell.contentlb.font = [UIFont systemFontOfSize:12];
                cell.contentlb.textColor = [UIColor colorFromHexCode:@"#8c8c8c"];
            }
        }else if (indexPath.section==2){
            cell.contentlb.textAlignment = NSTextAlignmentRight;
            if (indexPath.row==0) {
                //优惠促销
                cell.titlelb.text = @"优惠促销";
                cell.contentlb.text = @"-$3.80";
                cell.contentlb.textColor = [UIColor colorFromHexCode:@"#9c9c9c"];
                cell.contentlb.font = [UIFont systemFontOfSize:13];
            }else if (indexPath.row==1){
                //实际付款
                cell.titlelb.text = @"实付款";
                cell.contentlb.text = @"$17834123.32";
                cell.contentlb.textColor = [UIColor colorFromHexCode:@"#6079ff"];
                cell.contentlb.font = [UIFont systemFontOfSize:17];
            }
        }
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.numberOfLines=3;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor colorFromHexCode:@"#9c9c9c"];
    cell.textLabel.text = @"下单时间:2018-01-13 17:10:29\n发货时间:2018-01-13 17:10:29\n收货时间:2018-01-13 17:10:29";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
#pragma mark - page element



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
