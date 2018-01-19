//
//  MyCenterViewController.m
//  JieBa
//
//  Created by zhifu360 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "NavView.h"
#import "OrdersTotalViewController.h"
#import "BindClinicViewController.h"//my clinic
#import "MyCollectViewController.h"
#import "ReceiveAddressViewController.h"
#import "ClinicRegisterInfoListViewController.h"
#import "CustomServiceViewController.h"
#import "IntegralDetailViewController.h"
#import "RegisterClinicViewController.h"
#import "ChangeUserViewController.h"

@interface MyCenterViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIButton *sh;
@property(nonatomic,strong)UIButton *rChange;
@property(nonatomic,strong)NSArray *tableViewData;
@property(nonatomic,strong)UIAlertController *alert;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self navView];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:_navView.maxY maxY:kScreenHeight -49];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableViewData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableViewData[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
        return HeightXiShu(250);
    return HeightXiShu(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(5))];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(5);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return HeightXiShu(5);
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(5))];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(indexPath.section == 0){
        
        UIButton *userImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - WidthXiShu(75), HeightXiShu(10), WidthXiShu(150), HeightXiShu(150))];
        userImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [userImageBtn setImage:[GetImagePath getImagePath:@"headPortrait"] forState:UIControlStateNormal];
        userImageBtn.layer.cornerRadius = userImageBtn.halfWidth;
        userImageBtn.layer.borderWidth = .5;
        userImageBtn.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        userImageBtn.layer.masksToBounds = YES;
        [userImageBtn setImageEdgeInsets:UIEdgeInsetsMake(.5, .5, .5, .5)];
        [userImageBtn addTarget:self action:@selector(userImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:userImageBtn];
        
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(14), WidthXiShu(81), HeightXiShu(76))];
        integralImg.image = [GetImagePath getImagePath:@"integral_bg"];
        [cell.contentView addSubview:integralImg];
        
        UILabel *integralLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), WidthXiShu(81), HeightXiShu(30))];
        integralLB.text = [NSString stringWithFormat:@"%@分",[UserModel getUserModel].ischoose?[UserModel getUserModel].ischoose:@"0"];
        integralLB.textAlignment = NSTextAlignmentCenter;
        integralLB.textColor = BlackColor;
        integralLB.font = HEITI(HeightXiShu(19));
        [cell.contentView addSubview:integralLB];
        
        UILabel *userNameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(180), kScreenWidth, HeightXiShu(25))];
        userNameLB.text = [UserModel getUserModel].P_NAME?[UserModel getUserModel].P_NAME:@"药联采";
        userNameLB.textAlignment = NSTextAlignmentCenter;
        userNameLB.textColor = BlackColor;
        userNameLB.font = HEITI(HeightXiShu(18));
        [cell.contentView addSubview:userNameLB];
        
        UILabel *clinicLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(206), kScreenWidth, HeightXiShu(20))];
        clinicLB.text = @"杏联诊所(天水桥)";
        clinicLB.textAlignment = NSTextAlignmentCenter;
        clinicLB.textColor = TitleColor;
        clinicLB.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:clinicLB];
        
        UIButton *reg_log_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        reg_log_btn.frame = CGRectMake(kScreenWidth/2-WidthXiShu(75), HeightXiShu(180), WidthXiShu(150), HeightXiShu(40));
        [reg_log_btn setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [reg_log_btn addTarget:self action:@selector(reg_log_action) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:reg_log_btn];
        if (_tableViewData.count > 2) {
            userNameLB.hidden = NO;
            clinicLB.hidden = NO;
            reg_log_btn.hidden = YES;
        }else{
            userNameLB.hidden = YES;
            clinicLB.hidden = YES;
            reg_log_btn.hidden = NO;
        }
        
    } else if(indexPath.section > 0){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(50))];
        titleLabel.text = _tableViewData[indexPath.section][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(17), WidthXiShu(15), HeightXiShu(16))];
        arrowImgView.image = [GetImagePath getImagePath:@"right_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        if (indexPath.row == 0) {
            UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
            cutLine.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:cutLine];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (_tableViewData.count == 2 ) {
            //客服
            CustomServiceViewController * VC = [[CustomServiceViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            //--@"我的订单");
            OrdersTotalViewController *VC = [[OrdersTotalViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        if (_tableViewData.count == 2 ) {
            //注册诊所
            RegisterClinicViewController * VC = [[RegisterClinicViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            //--@"我的收藏");
            MyCollectViewController * VC = [[MyCollectViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        //--@"我的诊所");
        BindClinicViewController * VC = [[BindClinicViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];

    } else if (indexPath.section == 2 && indexPath.row == 1) {
        //--我的地址");
        ReceiveAddressViewController * VC = [[ReceiveAddressViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        //--积分明细
        IntegralDetailViewController * VC = [[IntegralDetailViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 3 && indexPath.row == 1){
        //--联系客服
        CustomServiceViewController * VC = [[CustomServiceViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }if (indexPath.section == 4 && indexPath.row == 0){
        //--退出登录");
//        [self presentViewController:self.alert animated:YES completion:nil];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定退出登陆？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [UserModel initModel];
        [self initClinic];
        [self.tableView reloadData];
    }
}

#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"个人中心";
        navView.leftBtn.hidden = YES;
        self.sh = [UIButton buttonWithType:UIButtonTypeCustom];
        _sh.frame = CGRectMake(0, 4, 68, 36);
        [_sh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sh setTitle:@"诊所审核" forState:UIControlStateNormal];
        _sh.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sh addTarget:self action:@selector(jumpToSomething) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:_sh];
        _sh.hidden = YES;
        
        self.rChange = [UIButton buttonWithType:UIButtonTypeCustom];
        _rChange.frame = CGRectMake(kScreenWidth-70, 4, 68, 36);
        [_rChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rChange setTitle:@"资料修改" forState:UIControlStateNormal];
        _rChange.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rChange addTarget:self action:@selector(jumpToDoChangeUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:_rChange];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
#pragma mark - 事件
//隐藏诊所审核 只有管理员才有此权限
-(void)initClinic{
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];
//    if ([model.P_LEVER isEqualToString:@"1"]) {
//        _sh.hidden = NO;
//    }else{
//        _sh.hidden = YES;
//    }
    if([model.P_LSM intValue] > 0){
        _rChange.hidden = NO;
        self.tableViewData = [NSArray arrayWithObjects:@[@"0"],@[@"我的订单",@"我的收藏"],@[@"我的诊所",@"我的地址"],@[@"积分明细",@"联系客服"],@[@"退出登录"], nil];
    }else{
        _rChange.hidden = YES;
        self.tableViewData = [NSArray arrayWithObjects:@[@"0"],@[@"联系客服",@"注册诊所"], nil];
    }
    [self.tableView reloadData];
}
//诊所审核
-(void)jumpToSomething{
    ClinicRegisterInfoListViewController *audit = [[ClinicRegisterInfoListViewController alloc] init];
    audit.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:audit animated:YES];
}
//change user info
-(void)jumpToDoChangeUserInfo{
    ChangeUserViewController *changeUser = [[ChangeUserViewController alloc] init];
    changeUser.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeUser animated:YES];
}
//登录注册按钮 在用户没有登录的时候起到作用
-(void)reg_log_action{
    LoginViewController *login = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
    login.refeshBlock = ^{
        [self initClinic];
        [self.tableView reloadData];
    };
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//
- (void)integralBtnAction {
    
}
//头像点击方法
- (void)userImageBtnAction {
    
}


#pragma mark - 接口


#pragma mark - 选照片

@end
