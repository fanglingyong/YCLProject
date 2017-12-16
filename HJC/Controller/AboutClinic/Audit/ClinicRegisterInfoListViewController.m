//
//  ClinicRegisterInfoListViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/16.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ClinicRegisterInfoListViewController.h"
#import "NavView.h"
#import "AuditClinicViewController.h"
#import "MJRefresh.h"

@interface ClinicRegisterInfoListViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *clinicList;
@end

@implementation ClinicRegisterInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [_tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"诊所资质审核列表";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastController_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)backLastController_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableView;
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [[MJRefreshNormalHeader alloc] init];
        [_tableView.mj_header setRefreshingTarget:self refreshingAction:@selector(headRefresh_net)];
        _tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
        [_tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh_net)];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _clinicList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *staticIdentifuer = @"clinicRegisterInfoListCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:staticIdentifuer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:staticIdentifuer];
    }
    cell.textLabel.text = _clinicList[indexPath.row][@"clinicName"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuditClinicViewController *audit = [[AuditClinicViewController alloc] init];
    //传一个key过去，识别点击的是哪个
    audit.clinicInfo = _clinicList[indexPath.row];
    [self.navigationController pushViewController:audit animated:YES];
}
#pragma mark - 假数据/刷新
-(void)headRefresh_net{
    [self netWorkForData];
    [_tableView.mj_header endRefreshing];
}
-(void)footRefresh_net{
    [_tableView.mj_footer endRefreshingWithNoMoreData];
    [_tableView.mj_footer endRefreshing];
}
-(void)netWorkForData{
    self.clinicList = [NSMutableArray array];
    [_clinicList addObject:@{@"clinicName":@"浙江大学医学院附属第一人民医院",@"clinicLoader":@"王伟林",@"clinicAddress":@"浙江省杭州市上城区庆春路79号",@"businesslicense":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513412310963&di=4bd5f9b97db6367efcd71fb4b56e3497&imgtype=0&src=http%3A%2F%2Fdocs.ebdoor.com%2FImage%2FCompanyCertificate%2F19%2F199651.jpg",@"gsp":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513412348739&di=a1e810e57b07549199fa368433cee0e0&imgtype=0&src=http%3A%2F%2Fwww.21yod.com%2Fupload%2F2014-12%2Fb98bb1b5-cce5-4333-b311-93b4c7e64898.png",@"ptLicense":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513412371403&di=54bfa82af13dcfb10dd8669cafa3ff0f&imgtype=0&src=http%3A%2F%2Fwww.xinyao.com.cn%2Fimages%2Fimg%2Fshxh%2Fxkz.jpg",@"mebLicense":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513412391932&di=5041f054dffd4d2cb1f64895c001dc06&imgtype=0&src=http%3A%2F%2Fwww.youjk.com%2Fimages%2Fimage%2Ffoot%2Ffoot_zz_6.jpg"}];
    [_clinicList addObject:@{@"clinicName":@"浙江大学医学院附属第二人民医院",@"clinicLoader":@"王建安",@"clinicAddress":@"浙江省杭州市上城区解放路88号",@"businesslicense":@"http://b.hiphotos.baidu.com/image/pic/item/c9fcc3cec3fdfc03434927abde3f8794a4c226f4.jpg",@"gsp":@"http://a.hiphotos.baidu.com/image/pic/item/2934349b033b5bb5d11b20343fd3d539b700bc2f.jpg",@"ptLicense":@"",@"mebLicense":@"http://e.hiphotos.baidu.com/image/pic/item/a8773912b31bb0513409b3e23f7adab44bede0cf.jpg"}];
    [_clinicList addObject:@{@"clinicName":@"浙江大学医学院附属邵逸夫医院",@"clinicLoader":@"蔡秀军",@"clinicAddress":@"浙江杭州庆春东路3号",@"businesslicense":@"http://g.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697afa20e975cfbb2fb4216d883.jpg",@"gsp":@"http://g.hiphotos.baidu.com/image/pic/item/d439b6003af33a87cf571bd0cf5c10385243b5c5.jpg",@"ptLicense":@"http://c.hiphotos.baidu.com/image/pic/item/ac4bd11373f08202004f2f4c41fbfbedaa641be7.jpg",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"仙居县人民医院",@"clinicLoader":@"张文明",@"clinicAddress":@"浙江省台州市仙居县城北东路53号",@"businesslicense":@"http://c.hiphotos.baidu.com/image/pic/item/54fbb2fb43166d22b55b155e4f2309f79152d2c8.jpg",@"gsp":@"",@"ptLicense":@"http://g.hiphotos.baidu.com/image/pic/item/b3119313b07eca800b6ae3f49b2397dda14483b2.jpg",@"mebLicense":@"http://e.hiphotos.baidu.com/image/pic/item/314e251f95cad1c883654254753e6709c83d51e2.jpg"}];
    [_clinicList addObject:@{@"clinicName":@"西门子助听器健康馆",@"clinicLoader":@"胡耀东",@"clinicAddress":@"清泰街366号",@"businesslicense":@"http://f.hiphotos.baidu.com/image/pic/item/43a7d933c895d1434096253079f082025baf07c5.jpg",@"gsp":@"",@"ptLicense":@"",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"越秀外国语医疗院",@"clinicLoader":@"付强",@"clinicAddress":@"凤起路528号",@"businesslicense":@"http://g.hiphotos.baidu.com/image/pic/item/314e251f95cad1c8d93dfbed763e6709c83d5171.jpg",@"gsp":@"http://a.hiphotos.baidu.com/image/pic/item/3bf33a87e950352aeedf3ec25a43fbf2b3118bb9.jpg",@"ptLicense":@"",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"浙江民生医药附属10086号诊所",@"clinicLoader":@"郑钧",@"clinicAddress":@"杭州市定安路1号",@"businesslicense":@"http://b.hiphotos.baidu.com/image/pic/item/4b90f603738da977f0bb86e1b951f8198718e360.jpg",@"gsp":@"1111",@"ptLicense":@"",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"不知道叫什么的诊所",@"clinicLoader":@"鈄雅玲",@"clinicAddress":@"不知道在哪个地方的莫名居所",@"businesslicense":@"http://e.hiphotos.baidu.com/image/pic/item/0df3d7ca7bcb0a46fe3390f36263f6246a60afe2.jpg",@"gsp":@"http://a.hiphotos.baidu.com/image/h%3D300/sign=1d560dab70899e51678e3c1472a6d990/e824b899a9014c0846aaf6f3017b02087af4f4d7.jpg",@"ptLicense":@"",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"绍兴民心诊所",@"clinicLoader":@"昧民心",@"clinicAddress":@"绍兴市越城区垃圾街1124号",@"businesslicense":@"http://c.hiphotos.baidu.com/image/pic/item/5243fbf2b2119313d20633c56f380cd791238d7a.jpg",@"gsp":@"http://a.hiphotos.baidu.com/image/pic/item/e7cd7b899e510fb3a787775dd033c895d0430c59.jpg",@"ptLicense":@"",@"mebLicense":@""}];
    [_clinicList addObject:@{@"clinicName":@"清泰街神奇小诊所",@"clinicLoader":@"将宝宝",@"clinicAddress":@"浙江杭州清泰街521号",@"businesslicense":@"http://a.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd9fdf5fea23301213fb90e91f5.jpg",@"gsp":@"",@"ptLicense":@"",@"mebLicense":@"http://h.hiphotos.baidu.com/image/pic/item/d53f8794a4c27d1ef549ac0e12d5ad6edcc43888.jpg"}];
    [self.tableView reloadData];
    
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
