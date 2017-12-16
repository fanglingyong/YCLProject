//
//  BindInfoViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "BindInfoViewController.h"
#import "NavView.h"
#import <QuartzCore/QuartzCore.h>
#import "AssoSuccessViewController.h"
#import "ClinicCell.h"

@interface BindInfoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NavView * navView;
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation BindInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self searchBarView];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"关联已注册的诊所";
        navView.titleLabel.textColor = [UIColor blackColor];
        [navView.leftBtn addTarget:self action:@selector(back_lastController) forControlEvents:UIControlEventTouchUpInside];
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}
-(void)back_lastController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarView{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(2, _navView.maxY+8, kScreenWidth-42, 40)];
    _searchBar.placeholder = @"请输入诊所名称的关键词";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(kScreenWidth-40, _navView.maxY+11, 35, 35);
    [searchBtn addTarget:self action:@selector(searchResult:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}
-(void)searchResult:(UIButton*)sender{
    NSLog(@"开始搜索了");
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY+48, kScreenWidth, kScreenHeight-_navView.maxY-48) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorFromHexCode:@"#f2f2f2"];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    
    [self jumpToAssoSuccess];
    
}
//  is success
-(void)jumpToAssoSuccess{
    AssoSuccessViewController * asso = [[AssoSuccessViewController alloc] init];
    asso.assoText = @"关联申请已经提交 请耐心等待审核";
    [self.navigationController pushViewController:asso animated:YES];
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
