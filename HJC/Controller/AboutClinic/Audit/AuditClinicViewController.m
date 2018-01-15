//
//  AuditClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/13.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AuditClinicViewController.h"
#import "NavView.h"


@interface AuditClinicViewController ()

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation AuditClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self createScrol];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"诊所资质审核";
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
#pragma mark - createUI
-(void)createScrol{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY-49)];
    _scrollView.bounces = NO;//滑动弹性关闭
    [self.view addSubview:_scrollView];
    [self contents];
    [self toolBtnsView];
}
#pragma mark - scrolView
-(void)contents{
    UILabel *clinicContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 90)];
    clinicContent.text = [NSString stringWithFormat:@"诊所名称:%@\n联系人:%@\n诊所地址:%@",_clinicInfo[@"clinicName"],_clinicInfo[@"clinicLoader"],_clinicInfo[@"clinicAddress"]];
    clinicContent.numberOfLines = 0;
    clinicContent.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:clinicContent];
    
    NSArray *arr = [NSArray arrayWithObjects:_clinicInfo[@"businesslicense"],_clinicInfo[@"gsp"],_clinicInfo[@"ptLicense"],_clinicInfo[@"mebLicense"], nil];
    int j = 0;
    CGFloat scroll_H = 100;
    for (int i = 0; i<arr.count; i++) {
        if ([AnimaDefaultUtil isNotNull:arr[i]]) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, clinicContent.maxY+10+(kScreenWidth+22)*j, kScreenWidth-20, kScreenWidth+20)];
            view.clipsToBounds = YES;
            view.layer.borderWidth = 1;
            view.layer.borderColor = [[UIColor colorFromHexCode:@"#999999"] CGColor];
            
            UILabel *loaderName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth-20, 30)];
            loaderName.text = @[@"营业执照",@"GSP证书",@"药品营业许可证",@"医疗器械营业许可证"][i];
            loaderName.font = [UIFont systemFontOfSize:15];
            loaderName.textAlignment = NSTextAlignmentCenter;
            [view addSubview:loaderName];
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth-20, kScreenWidth-20)];
            image.contentMode = UIViewContentModeScaleAspectFit;
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SmallPic,arr[i]]] placeholderImage:[UIImage imageNamed:@"sysIcon3.jpg"]];
            [view addSubview:image];
            
            [_scrollView addSubview:view];
            scroll_H += kScreenWidth+22;
            j++;
        }
    }
    _scrollView.contentSize = CGSizeMake(kScreenWidth, scroll_H+20);
}

#pragma mark - tool button
-(void)toolBtnsView{
    UIView *toolButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    
    toolButtonView.backgroundColor = [UIColor whiteColor];
    toolButtonView.layer.shadowColor = [[UIColor blackColor] CGColor];
    toolButtonView.layer.shadowOpacity = 0.5f;
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passBtn.frame = CGRectMake(kScreenWidth/2+4, 4, kScreenWidth/2-12, 40);
    passBtn.layer.borderWidth = 1;
    passBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    passBtn.layer.cornerRadius = 3;
    passBtn.clipsToBounds = YES;
    [passBtn setTitle:@"同意" forState:UIControlStateNormal];
    passBtn.backgroundColor = [UIColor colorFromHexCode:@"#74A815"];
    [passBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [passBtn addTarget:self action:@selector(agreenThisClinic) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(8, 4, kScreenWidth/2-12, 40);
    stopBtn.layer.borderWidth = 1;
    stopBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    stopBtn.layer.cornerRadius = 3;
    stopBtn.clipsToBounds = YES;
    [stopBtn setTitle:@"不同意" forState:UIControlStateNormal];
    stopBtn.backgroundColor = [UIColor colorFromHexCode:@"#A8152B"];
    [stopBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(refseThisClinic) forControlEvents:UIControlEventTouchUpInside];
    
    [toolButtonView addSubview:stopBtn];
    [toolButtonView addSubview:passBtn];
    [self.view addSubview:toolButtonView];
}
//同意
-(void)agreenThisClinic{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请再次确认" message:@"资料是否无误，同意其注册？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *default_ac = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //网络请求
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *default_cancel = [UIAlertAction actionWithTitle:@"考虑一下" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:default_ac];
    [ac addAction:default_cancel];
    [self presentViewController:ac animated:YES completion:^{
        //完成咯
    }];
}
//拒绝
-(void)refseThisClinic{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"拒绝注册" message:@"若确认拒绝请填写拒绝理由" preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"请输入拒绝理由";
        textField.text = @"您的资料已不合格，请修改后再提交";
    }];
    UIAlertAction *default_ac = [UIAlertAction actionWithTitle:@"确认拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //网络请求
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *default_cancel = [UIAlertAction actionWithTitle:@"考虑一下" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:default_ac];
    [ac addAction:default_cancel];
    [self presentViewController:ac animated:YES completion:^{
        //完成咯
    }];
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
