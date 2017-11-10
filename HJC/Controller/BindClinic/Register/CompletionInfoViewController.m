//
//  CompletionInfoViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "CompletionInfoViewController.h"
#import "NavView.h"
#import "InputTextFiledView.h"
#import "AssoSuccessViewController.h"

@interface CompletionInfoViewController ()
@property (nonatomic,strong) NavView *navView;
@end

@implementation CompletionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    [self createSomeUI];
    [self tabbarView];
    // Do any additional setup after loading the view.
}


-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"上传信息";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.leftBtn.hidden = YES;
        navView.rightBtn.hidden = YES;
        _navView = navView;
    }
    return _navView;
}
-(void)createSomeUI{
    InputTextFiledView * relName = [[InputTextFiledView alloc] initWithFrame:CGRectMake(8, _navView.maxY+8, kScreenWidth-16, 50)];
    relName.textField.frame = CGRectMake(10, 8, relName.width-20, 31);
    relName.placeholder = @"请输入真实姓名";
    relName.placeholderColor = [UIColor colorFromHexCode:@"#696969"];
    relName.backgroundColor = [UIColor colorFromHexCode:@"#fdfdfd"];
    relName.layer.borderWidth = 1;
    relName.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
    [self.view addSubview:relName];
    
    InputTextFiledView * contact = [[InputTextFiledView alloc] initWithFrame:CGRectMake(8, relName.maxY+8, kScreenWidth-16, 50)];
    contact.textField.frame = CGRectMake(10, 8, contact.width-20, 31);
    contact.placeholder = @"请输入联系方式";
    contact.placeholderColor = [UIColor colorFromHexCode:@"#696969"];
    contact.backgroundColor = [UIColor colorFromHexCode:@"#fdfdfd"];
    contact.layer.borderWidth = 1;
    contact.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
    [self.view addSubview:contact];
    
    InputTextFiledView * payCardInfo = [[InputTextFiledView alloc] initWithFrame:CGRectMake(8, contact.maxY+8, kScreenWidth-16, 50)];
    payCardInfo.textField.frame = CGRectMake(10, 8, payCardInfo.width-20, 31);
    payCardInfo.placeholder = @"请输入支付银行卡信息";
    payCardInfo.placeholderColor = [UIColor colorFromHexCode:@"#696969"];
    payCardInfo.backgroundColor = [UIColor colorFromHexCode:@"#fdfdfd"];
    payCardInfo.layer.borderWidth = 1;
    payCardInfo.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
    [self.view addSubview:payCardInfo];
    
    CGFloat imgSize = kScreenWidth/2-16;
    UIImageView *bussinessLicense = [[UIImageView alloc]initWithFrame:CGRectMake(8, payCardInfo.maxY+8, imgSize, imgSize)];
    bussinessLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bussinessLicense];
    UILabel * bLable = [[UILabel alloc] initWithFrame:CGRectMake(8, bussinessLicense.maxY+8, imgSize, 22)];
    bLable.textAlignment = NSTextAlignmentCenter;
    bLable.text = @"营业执照(必填)";
    bLable.font = [UIFont systemFontOfSize:16 weight:500];
    [self.view addSubview:bLable];
    
    UIImageView *gspLicense = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+8, payCardInfo.maxY+8, imgSize, imgSize)];
    gspLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:gspLicense];
    UILabel * gspLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+8, gspLicense.maxY+8, imgSize, 22)];
    gspLable.textAlignment = NSTextAlignmentCenter;
    gspLable.text = @"GSP证";
    gspLable.font = [UIFont systemFontOfSize:16 weight:500];
    [self.view addSubview:gspLable];
    
    UIImageView *ptLicense = [[UIImageView alloc]initWithFrame:CGRectMake(8, bLable.maxY+8, imgSize, imgSize)];
    ptLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:ptLicense];
    UILabel * ptLable = [[UILabel alloc] initWithFrame:CGRectMake(8, ptLicense.maxY+8, imgSize, 22)];
    ptLable.textAlignment = NSTextAlignmentCenter;
    ptLable.text = @"药品经营许可证";
    ptLable.font = [UIFont systemFontOfSize:16 weight:500];
    [self.view addSubview:ptLable];
    
    UIImageView *mebLicense = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+8, gspLable.maxY+8, imgSize, imgSize)];
    mebLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:mebLicense];
    UILabel * mebLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+8, mebLicense.maxY+8, imgSize, 22)];
    mebLable.textAlignment = NSTextAlignmentCenter;
    mebLable.text = @"医疗器械经营许可证";
    mebLable.font = [UIFont systemFontOfSize:16 weight:500];
    [self.view addSubview:mebLable];
    
    UIImage *img = [UIImage imageNamed:@"sysIcon1.jpg"];
    bussinessLicense.image = img;
    gspLicense.image = [UIImage imageNamed:@"sysIcon2.jpg"];
    ptLicense.image = [UIImage imageNamed:@"sysIcon3.jpg"];
    mebLicense.image = [UIImage imageNamed:@"sysIcon1.jpg"];
}
-(void)tabbarView{
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.layer.shadowColor = [[UIColor blackColor] CGColor];
    dView.layer.shadowOpacity = 0.5f;
    
    UIButton * lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lastBtn.frame = CGRectMake(10, 4, kScreenWidth/2-15, 40);
    lastBtn.layer.borderWidth = 1;
    lastBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    lastBtn.layer.cornerRadius = 3;
    lastBtn.clipsToBounds = YES;
    [lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [lastBtn setTitleColor:[UIColor colorFromHexCode:@"#000000"] forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(popLastPage:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:lastBtn];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kScreenWidth/2+5, 4, kScreenWidth/2-15, 40);
    nextBtn.layer.borderWidth = 1;
    nextBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    nextBtn.layer.cornerRadius = 3;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
    [nextBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(commitToService:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:nextBtn];
    
    [self.view addSubview:dView];
}
// last / next button menthod
-(void)commitToService:(UIButton*)sender{
    //提交
    AssoSuccessViewController * asso = [[AssoSuccessViewController alloc] init];
    asso.assoText = @"资料已经提交 请耐心等待审核";
    [self.navigationController pushViewController:asso animated:YES];
}
-(void)popLastPage:(UIButton*)sender{
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
