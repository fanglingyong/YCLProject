//
//  ChangeUserViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ChangeUserViewController.h"
#import "NavView.h"
#import "ChangeUserInfoViewController.h"
#import "ChangeUserPswdViewController.h"

@interface ChangeUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *list;
@end

@implementation ChangeUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    self.list = @[@"修改信息",@"修改密码"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"资料修改";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
#pragma mark - tableView
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, kScreenHeight-_navView.maxY-10) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderTotalCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"changeusercontrol"];
    }
    cell.textLabel.text = _list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //修改信息
        ChangeUserInfoViewController *userinfo = [[ChangeUserInfoViewController alloc]init];
        
        [self.navigationController pushViewController:userinfo animated:YES];
    }else if (indexPath.row == 1){
        //修改密码
        ChangeUserPswdViewController *userpswd = [[ChangeUserPswdViewController alloc] init];
        
        [self.navigationController pushViewController:userpswd animated:YES];
    }
}
#pragma mark - 事件
-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
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
