//
//  PositionAddressViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "PositionAddressViewController.h"
#import "NavView.h"
#import "CompletionInfoViewController.h"
#import "AssoSuccessViewController.h"

@interface PositionAddressViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UIImageView *businessLicense;
@property (nonatomic,strong) UIImageView *gspLicense;
@property (nonatomic,strong) UIImageView *ptLicense;//Pharmaceutical trading license
@property (nonatomic,strong) UIImageView *mebLicense;//Medical equipment business licenses

@end

@implementation PositionAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self addressPosotionView];
    
    // Do any additional setup after loading the view.
}
#pragma mark - 信息上传
-(void)addressPosotionView{
    [self loadUI];
    [self tabbarView];
}
#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"诊所信息上传";
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

-(void)loadUI{
    //营业执照（必须）、GSP证、药品经营许可证、医疗器械经营许可证
    CGFloat imgSize = kScreenWidth/2-30;
    self.businessLicense = [[UIImageView alloc]initWithFrame:CGRectMake(20, _navView.maxY+20, imgSize, imgSize)];
    _businessLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_businessLicense];
    
    UIButton * blBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blBtn.frame = CGRectMake(8, _businessLicense.maxY+8, imgSize, 44);
    [blBtn setTitle:@"营业执照(必需)\n点击上传图片" forState:UIControlStateNormal];
    [blBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    blBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    blBtn.titleLabel.numberOfLines = 2;
    [blBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blBtn];
    //GSP证书
    self.gspLicense = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, _navView.maxY+20, imgSize, imgSize)];
    _gspLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_gspLicense];
    
    UIButton * gspBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gspBtn.frame = CGRectMake(kScreenWidth/2+8, _gspLicense.maxY+8, imgSize, 44);
    [gspBtn setTitle:@"GSP证\n点击上传图片" forState:UIControlStateNormal];
    [gspBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gspBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    gspBtn.titleLabel.numberOfLines = 2;
    [gspBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gspBtn];
    //药品经营许可证
    self.ptLicense = [[UIImageView alloc]initWithFrame:CGRectMake(20, blBtn.maxY+20, imgSize, imgSize)];
    _ptLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_ptLicense];
    
    UIButton * ptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ptBtn.frame = CGRectMake(8, _ptLicense.maxY+8, imgSize, 44);
    [ptBtn setTitle:@"药品经营许可证\n点击上传图片" forState:UIControlStateNormal];
    [ptBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ptBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    ptBtn.titleLabel.numberOfLines = 2;
    ptBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [ptBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ptBtn];
    //医疗器械经营许可证
    self.mebLicense = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, gspBtn.maxY+20, imgSize, imgSize)];
    _mebLicense.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_mebLicense];
    
    UIButton * mebBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mebBtn.frame = CGRectMake(kScreenWidth/2+8, _mebLicense.maxY+8, imgSize, 44);
    [mebBtn setTitle:@"医疗器械经营许可证\n点击上传图片" forState:UIControlStateNormal];
    [mebBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mebBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    mebBtn.titleLabel.numberOfLines = 2;
    mebBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [mebBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mebBtn];
    //假数据
    UIImage *img = [UIImage imageNamed:@"sysIcon1.jpg"];
    _businessLicense.image = img;
    _gspLicense.image = [UIImage imageNamed:@"sysIcon2.jpg"];
    _ptLicense.image = [UIImage imageNamed:@"sysIcon3.jpg"];
    _mebLicense.image = [UIImage imageNamed:@"sysIcon1.jpg"];
}
- (void)uploadImage:(UIButton *)sender{
    NSLog(@"请别点击了");
    __block typeof(self)wSelf = self;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *loaclAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf localPhoto];
    }];
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf takePhoto];
    }];
    [alertControl addAction:cancelAction];
    [alertControl addAction:loaclAction];
    [alertControl addAction:takeAction];
    [self presentViewController:alertControl animated:YES completion:nil];
    
}
-(void)tabbarView{
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
// last / next button menthod
-(void)jumpToAssoSuccess:(UIButton*)sender{
    CompletionInfoViewController * comInfo = [[CompletionInfoViewController alloc] init];
    [self.navigationController pushViewController:comInfo animated:YES];
}
#pragma mark - 选照片
#pragma mark - head的delegate


#pragma mark - 选照片
//打开本地相册
-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
}

//开始拍照
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


#pragma mark - UIImagePickerDelegate

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"%@", imageData);
    
    [self.businessLicense setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
