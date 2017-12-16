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
#import "MyOrderViewController.h"
#import "BindClinicViewController.h"
#import "MyCollectViewController.h"
#import "ReceiveAddressViewController.h"
#import "BusinessLicenseViewController.h"
#import "AuditClinicViewController.h"

@interface MyCenterViewController ()
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)UIButton *sh;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self navView];

    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:64 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}
#pragma mark - tableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else if(section == 2){
        return 2;
    }else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return HeightXiShu(250);
    }
    return HeightXiShu(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(8))];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(10);
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
        
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(14), WidthXiShu(81), HeightXiShu(76))];
        integralImg.image = [GetImagePath getImagePath:@"integral_bg"];
        [cell.contentView addSubview:integralImg];
        
        UILabel *integralLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), WidthXiShu(81), HeightXiShu(30))];
        integralLB.text = @"233分";
        integralLB.textAlignment = NSTextAlignmentCenter;
        integralLB.textColor = BlackColor;
        integralLB.font = HEITI(HeightXiShu(19));
        [cell.contentView addSubview:integralLB];
        
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
        
        
        UILabel *userNameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(180), kScreenWidth, HeightXiShu(25))];
        userNameLB.text = @"王小明123";
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
        
    } else if(indexPath.section == 1){
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(50))];
        titleLabel.text = @[@"我的订单", @"我的收藏"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(17), WidthXiShu(15), HeightXiShu(16))];
        arrowImgView.image = [GetImagePath getImagePath:@"right_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
        cutLine.backgroundColor = AllLightGrayColor;
        if (indexPath.row == 0) {
            [cell.contentView addSubview:cutLine];
        }
    } else if (indexPath.section == 2){
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(50))];
        titleLabel.text = @[@"我的诊所", @"我的地址"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(17), WidthXiShu(15), HeightXiShu(16))];
        arrowImgView.image = [GetImagePath getImagePath:@"right_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
        cutLine.backgroundColor = AllLightGrayColor;
        if (indexPath.row == 0) {
            [cell.contentView addSubview:cutLine];
        }
    } else {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(50))];
        titleLabel.text = @[@"联系客服", @"退出登录"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(17), WidthXiShu(15), HeightXiShu(16))];
        arrowImgView.image = [GetImagePath getImagePath:@"right_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
        cutLine.backgroundColor = AllLightGrayColor;
        if (indexPath.row == 0) {
            [cell.contentView addSubview:cutLine];
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"我的订单");
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        NSLog(@"我的收藏");
        MyCollectViewController * VC = [[MyCollectViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        NSLog(@"我的诊所");
        BindClinicViewController * VC = [[BindClinicViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];

    } else if (indexPath.section == 2 && indexPath.row == 1) {
        NSLog(@"我的地址");
        ReceiveAddressViewController * VC = [[ReceiveAddressViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        NSLog(@"联系客服");
        BusinessLicenseViewController * businessLicense = [[BusinessLicenseViewController alloc] init];
        businessLicense.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:businessLicense animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 1){
        NSLog(@"退出登录");
        UIAlertController *alet = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           //取消
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alet addAction:cancle];
        [alet addAction:sure];
        [self presentViewController:alet animated:YES completion:^{
           //弹出提示框完成后TODO
        }];
    }
    
}
#pragma mark - 页面元素
- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
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
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
-(void)auditClinic{
    _sh.hidden = YES;
}
-(void)jumpToSomething{
    //诊所审核
    AuditClinicViewController *audit = [[AuditClinicViewController alloc] init];
    audit.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:audit animated:YES];
}
#pragma mark - 事件
-(void)loginAction{
    LoginViewController *login = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)integralBtnAction {
    
}

- (void)userImageBtnAction {
    
}


#pragma mark - 接口


#pragma mark - 选照片

@end
