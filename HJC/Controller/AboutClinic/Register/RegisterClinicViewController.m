//
//  RegisterClinicViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "RegisterClinicViewController.h"
#import "NavView.h"
#import "BusinessLicenseViewController.h"

@interface RegisterClinicViewController ()<UITextViewDelegate>

@property (nonatomic,strong) NavView * navView;

@property (nonatomic,strong) UITextField *tfName;
@property (nonatomic,strong) UITextField *tfLeader;
@property (nonatomic,strong) UITextField *tfLink;
@property (nonatomic,strong) UITextView *tfAddress;
@property (nonatomic,strong) UILabel *tfAddressPlaceholder;

@end

@implementation RegisterClinicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self viewCrateUI];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"注册诊所";
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


- (void)viewCrateUI{
    //名称、法人、联系方式、地址
    //发票抬头、税号、开户银行
    //营业执照（必须）、GSP证、药品经营许可证、医疗器械经营许可证
    
    UIView * reg = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY+10, kScreenWidth, 250)];
    reg.backgroundColor = [UIColor whiteColor];
    
    UILabel * clinicNmae = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 68, 22)];
    clinicNmae.text = @"诊所名称";
    clinicNmae.font = [UIFont systemFontOfSize:15];
    [reg addSubview:clinicNmae];
    
    self.tfName = [[UITextField alloc] initWithFrame:CGRectMake(96, 16, reg.maxX-116, 30)];
    _tfName.font = [UIFont systemFontOfSize:15];
    _tfName.placeholder = @"请填写诊所名称";
    [reg addSubview:_tfName];
    
    UIView *fg_1 = [[UIView alloc] initWithFrame:CGRectMake(10, clinicNmae.maxY+10, kScreenWidth-20, 2)];
    fg_1.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [reg addSubview:fg_1];
    
    UILabel * clinicLeader = [[UILabel alloc] initWithFrame:CGRectMake(20, fg_1.maxY+10, 68, 22)];
    clinicLeader.text = @"法人姓名";
    clinicLeader.font = [UIFont systemFontOfSize:15];
    [reg addSubview:clinicLeader];
    
    self.tfLeader = [[UITextField alloc] initWithFrame:CGRectMake(96, fg_1.maxY+6, reg.maxX-116, 30)];
    _tfLeader.font = [UIFont systemFontOfSize:15];
    _tfLeader.placeholder = @"请填写法人姓名";
    [reg addSubview:_tfLeader];
    
    UIView *fg_2 = [[UIView alloc] initWithFrame:CGRectMake(10, clinicLeader.maxY+10, kScreenWidth-20, 2)];
    fg_2.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [reg addSubview:fg_2];
    
    UILabel * clinicLink = [[UILabel alloc] initWithFrame:CGRectMake(20, fg_2.maxY+10, 68, 22)];
    clinicLink.text = @"联系方式";
    clinicLink.font = [UIFont systemFontOfSize:15];
    [reg addSubview:clinicLink];
    
    self.tfLink = [[UITextField alloc] initWithFrame:CGRectMake(96, fg_2.maxY+6, reg.maxX-116, 30)];
    _tfLink.font = [UIFont systemFontOfSize:15];
    _tfLink.placeholder = @"请填写联系方式";
    [reg addSubview:_tfLink];
    
    UIView *fg_3 = [[UIView alloc] initWithFrame:CGRectMake(10, clinicLink.maxY+10, kScreenWidth-20, 2)];
    fg_3.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [reg addSubview:fg_3];
    
    UILabel * clinicAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, fg_3.maxY+10, 68, 22)];
    clinicAddress.text = @"诊所地址";
    clinicAddress.font = [UIFont systemFontOfSize:15];
    [reg addSubview:clinicAddress];
    
    self.tfAddress = [[UITextView alloc] initWithFrame:CGRectMake(93, fg_3.maxY+6, reg.maxX-116, 80)];
    _tfAddress.font = [UIFont systemFontOfSize:15];
    _tfAddress.text = @"请填写详细地址";
    _tfAddress.textColor = [UIColor colorFromHexCode:@"#c0c0c0"];
    _tfAddress.delegate = self;
    [reg addSubview:_tfAddress];
    
    [self.view addSubview:reg];
    [self toolView];
}
-(void)toolView{
    UIView *dView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    dView.backgroundColor = [UIColor whiteColor];
    dView.layer.shadowColor = [[UIColor blackColor] CGColor];
    dView.layer.shadowOpacity = 0.5f;
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(8, 4, kScreenWidth-16, 40);
    nextBtn.layer.borderWidth = 1;
    nextBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    nextBtn.layer.cornerRadius = 3;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:@"注册并上传证书" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
    [nextBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(jumpToPositAddress:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:nextBtn];
    
    [self.view addSubview:dView];
}
#pragma mark - uitextviewdelete
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请填写详细地址";
        textView.textColor = [UIColor colorFromHexCode:@"#c0c0c0"];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请填写详细地址"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}


// last / next button menthod
-(void)jumpToPositAddress:(UIButton*)sender{
    NSString *clinicname = _tfName.text;
    NSString *personname = _tfLeader.text;
    NSString *personphone = _tfLink.text;
    NSString *clinicAddress =_tfAddress.text;
    if ([AnimaDefaultUtil isNotNull:clinicname] && [AnimaDefaultUtil isNotNull:personname] && [AnimaDefaultUtil isNotNull:personphone] && [AnimaDefaultUtil isNotNull:clinicAddress]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:clinicname forKey:@"CORPNAME"];
        [pargrams setObject:personname forKey:@"LAWMAN"];
        [pargrams setObject:personphone forKey:@"LINK"];
        [pargrams setObject:clinicAddress forKey:@"ADDRESS"];
        [pargrams setObject:@"0" forKey:@"UserID"];
        [BaseApi getMenthodWithUrl:RegClinicURL block:^(NSDictionary *dict, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (dict) {
                    NSLog(@"诊所id %@",dict[@"data"][0][@"corpid"]);
                    BusinessLicenseViewController * pa = [[BusinessLicenseViewController alloc] init];
                    pa.corpid = dict[@"data"][0][@"corpid"];
                    [self.navigationController pushViewController:pa animated:YES];
                }else{
                    [HUDUtil Hud_message:error.domain view:self.view];
                }
            });
        } dic:pargrams noNetWork:nil];
    }else{
        [HUDUtil Hud_message:@"请完善信息后再提交" view:self.view];
    }
    
    
    
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
