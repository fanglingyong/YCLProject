//
//  BindClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/2.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BindClinicViewController.h"
#import "NavView.h"
#import "BindInfoViewController.h"
#import "RegisterClinicViewController.h"
#import "ClinicCell.h"

@interface BindClinicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NavView * navView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation BindClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self loadUI];
    // Do any additional setup after loading the view.
}

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"我的诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        [navView.leftBtn addTarget:self action:@selector(back_lastController) forControlEvents:UIControlEventTouchUpInside];
        [navView.rightBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
        [navView.rightBtn addTarget:self action:@selector(showAlertViewController) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)back_lastController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlertViewController{
    UIAlertController *alControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alControl addAction:[UIAlertAction actionWithTitle:@"绑定已有诊所" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //添加
        [self jumpToBindAccount];
    }]];
    [alControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }]];
    [self presentViewController:alControl animated:YES completion:^{
        
    }];
}
/**
 create UI
 */
-(void)loadUI{
    
    [self.view addSubview:self.tableView];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorFromHexCode:@"#f2f2f2"];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClinicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clinic"];
    if (!cell) {
        cell = [[ClinicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"clinic"];
    }
    [cell setValuesForClinicName:@"华东医药股份有限公司药品分公司" leader:@"李邦良" address:@"杭州市上城区小营街道清泰街366号北五楼信息中心"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - other
-(void) jumpToBindAccount{
    BindInfoViewController *bindinfo = [[BindInfoViewController alloc] init];
    [self.navigationController pushViewController:bindinfo animated:YES];
}
-(void) jumpToRegisterAccount{
    RegisterClinicViewController * reg_clinic = [[RegisterClinicViewController alloc] init];
    [self.navigationController pushViewController:reg_clinic animated:YES];
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
