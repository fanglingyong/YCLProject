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
#import "BindClinicModel.h"
#import "MJRefresh.h"
#import "RegisterClinicViewController.h"//--
#import "RegisterUserViewController.h"
#import "ToolButtonView.h"

@interface BindInfoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NavView * navView;
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) NSMutableDictionary *pargams;

@end

@implementation BindInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
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
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, 48)];
    searchView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(2, 4, kScreenWidth-42, 40)];
    _searchBar.placeholder = @"请输入诊所名称的关键词";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    [searchView addSubview:_searchBar];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(kScreenWidth-40, 7, 35, 35);
    [searchBtn addTarget:self action:@selector(searchResult:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    [self.view addSubview:searchView];
}
-(void)toolViewCreate{
    ToolButtonView *tool = [[ToolButtonView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-49, kScreenWidth, 49) button:@"未找到,去注册诊所"];
    [tool addToolTarget:self action:@selector(jumpToRegister) forControlEvents:UIControlEventTouchUpInside];
}
-(void)jumpToRegister{
    RegisterClinicViewController*vc = [[RegisterClinicViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)searchResult:(UIButton*)sender{
    NSLog(@"开始搜索了");
    
    _page = 1;
    NSString *searchText =_searchBar.text;
    self.pargams = [NSMutableDictionary dictionary];
    [_pargams setObject:searchText forKey:@"Parastr"];
    [_pargams setObject:@"0" forKey:@"UserID"];
    [self net_work];
}
-(void)net_work{

    [_pargams setObject:[NSString stringWithFormat:@",10,%d",_page] forKey:@"WebPara"];
    //做点什么...
    NSLog(@"参数%@",_pargams);
    [BaseApi getMenthodWithUrl:GetClinicList block:^(NSDictionary *dict, NSError *error) {
        if(dict){
            if ([dict[@"status"] intValue] == 1) {
                if (_page == 1){
                    self.dataList = [NSMutableArray array];
                }
                for (NSDictionary*dic in dict[@"data"]) {
                    BindClinicModel *model = [[BindClinicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [_dataList addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(),^ {
                    if ([dict[@"data"] count] < 10) {
                        [_tableView.mj_footer endRefreshingWithNoMoreData];
                    }else{
                        [_tableView.mj_footer resetNoMoreData];
                    }
                    [_tableView reloadData];
                    
                });
            }else{
                dispatch_async(dispatch_get_main_queue(),^ {
                    [HUDUtil Hud_message:dict[@"message"] view:self.view];
                });
            }
        }
    } dic:_pargams noNetWork:nil];
}
-(void)nextData{
    if (_dataList.count != 0 && _dataList.count % 10 == 0) {
        _page+=1;
        [self net_work];
    }else{
        NSLog(@"不加载了");
    }
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY+48, kScreenWidth, kScreenHeight-_navView.maxY-48-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorFromHexCode:@"#f2f2f2"];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextData)];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClinicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clinic"];
    if (!cell) {
        cell = [[ClinicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"clinic"];
    }
    cell.model = _dataList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BindClinicModel *model = [[BindClinicModel alloc] init];
    model = _dataList[indexPath.row];
    [self jumpToAssoSuccess:model.CORPID];
    
}
//  is success
-(void)jumpToAssoSuccess:(NSString*)corpid{
    RegisterUserViewController*user = [[RegisterUserViewController alloc] init];
    user.corpId = corpid;
    [self.navigationController pushViewController:user animated:YES];
    /*
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseApi getMenthodWithUrl:BindClinicURL block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES ];
                if ([dict[@"status"] integerValue]==1) {
                    AssoSuccessViewController * asso = [[AssoSuccessViewController alloc] init];
                    asso.assoText = @"关联申请已经提交 请耐心等待审核";
                    [self.navigationController pushViewController:asso animated:YES];
                }else{
                    [HUDUtil Hud_message:dict[@"message"] view:self.view];
                }
            });
        }
    } dic:[NSMutableDictionary dictionaryWithDictionary:@{@"UserID":@"0",@"Corpid":corpid}] noNetWork:nil];
     */
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
