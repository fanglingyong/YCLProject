//
//  MsgListViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/4/24.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "MsgListViewController.h"
#import "NavView.h"
#import "AnnouncementCell.h"
#import "MessagesCell.h"
#import "AnnouncementViewController.h"
#import "MessageDetailViewController.h"
#import "MessageModel.h"
#import "MsgYaozixunModel.h"
#import "MJRefresh.h"
#import "WebMessageController.h"

@interface MsgListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NavView *navView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *msgList;
@property (nonatomic,strong) NSMutableArray *typeList;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,strong) UIView *noDataView;
@end

@implementation MsgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.view addSubview:self.tableView];
    _pageNum = 1;

//    [self net_MessageList];//此接口还未有，暂不开放
//    self.tableView.mj_footer = [[MJRefreshAutoNormalFooter alloc] init];
//    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(footRefresh)];

}

-(void)footRefresh{
    
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
        navView.titleLabel.text = @"药资讯";
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - tableView / Delgate &dataSource
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, kScreenHeight-SafeAreaBottomHeight-_navView.maxY-10) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = AllBackLightGratColor;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _msgList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /* if boss have need ，next play it
     if ([_typeList[indexPath.row] isEqualToString:@"2"]) {
     AnnouncementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"announcementCell"];
     if (!cell) {
     cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"announcementCell"];
     }
     return cell;
     }*/
    MsgYzxCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MsgYzxCell"];
    if (!cell) {
        cell = [[MsgYzxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MsgYzxCell"];
    }
    MsgYaozixunModel *model = _msgList[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebMessageController *web = [[WebMessageController alloc] init];
    MsgYaozixunModel * model = [[MsgYaozixunModel alloc] init];
    model = _msgList[indexPath.row];
    web.hmtlStr = model.messageconyent;
    [self.navigationController pushViewController:web animated:YES];
    
}
#pragma mark - net
-(void)net_MessageList{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"" forKey:@"Parastr"];
    //（信息标题、或者id）[--id是单条记录--查询条件此参数为字符行几个条件用,隔开]
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",_pageNum] forKey:@"WebPara"];
    [BaseApi getMenthodWithUrl:GetNavYaoZixun block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            if (_pageNum==1) {
                self.msgList = [NSMutableArray array];
//                self.typeList = [NSMutableArray array];
            }
            NSArray *arr = dict[@"data"];
            for (NSDictionary*oj in arr) {
//                [_typeList addObject:oj[@"MessageType"]];
                MsgYaozixunModel *model = [[MsgYaozixunModel alloc] init];
                [model setValuesForKeysWithDictionary:oj];
                [_msgList addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:@"暂无数据" view:self.view];
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
