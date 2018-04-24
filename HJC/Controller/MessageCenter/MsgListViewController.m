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
    MessagesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"messagesCell"];
    if (!cell) {
        cell = [[MessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messagesCell"];
    }
    MessageModel *model = _msgList[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     if ([_typeList[indexPath.row] isEqualToString:@"2"]) {
     //公告
     AnnouncementViewController *ann = [[AnnouncementViewController alloc] init];
     ann.hidesBottomBarWhenPushed = YES;
     ann.msgModel = _msgList[indexPath.row];
     [self.navigationController pushViewController:ann animated:YES];
     }else{
     }
     */        //消息
    MessageDetailViewController *msgDetail = [[MessageDetailViewController alloc] init];
    msgDetail.hidesBottomBarWhenPushed = YES;
    msgDetail.msgModel = _msgList[indexPath.row];
    [self.navigationController pushViewController:msgDetail animated:YES];
}
#pragma mark - net
-(void)net_MessageList{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"," forKey:@"Parastr"];
    [pargrams setObject:[NSString stringWithFormat:@",15,%ld",_pageNum>1?_pageNum:1] forKey:@"WebPara"];
    [BaseApi getMenthodWithUrl:GetMessageInfo block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            if (_pageNum==1) {
                self.msgList = [NSMutableArray array];
                self.typeList = [NSMutableArray array];
            }
            NSArray *arr = dict[@"data"];
            for (NSDictionary*oj in arr) {
                [_typeList addObject:oj[@"MessageType"]];
                MessageModel *model = [[MessageModel alloc] init];
                [model setValuesForKeysWithDictionary:oj];
                [_msgList addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:@"暂无数据" view:self.view];
        }
    } dic:pargrams noNetWork:nil];
}
#pragma mark - read
-(void)net_deleteMessage{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:@"" forKey:@"MESSAGEID"];
    [pargrams setObject:@"2" forKey:@"OPCODE"];
    [BaseApi getMenthodWithUrl:GetDealMessage block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            
        }else{
            
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
