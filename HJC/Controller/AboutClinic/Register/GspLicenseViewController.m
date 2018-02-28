//
//  GspLicenseViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/13.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "GspLicenseViewController.h"
#import "NavView.h"
#import "ToolButtonView.h"
#import "PtLicenseViewController.h"

@interface GspLicenseViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UIImageView *businessLicense;
@property (nonatomic,strong) UIButton *imageBtn;

@end

@implementation GspLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self loadBL_UI];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"GSP证书上传";
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
#pragma mark - loading UI
-(void)loadBL_UI{
    CGFloat imgSize = kScreenWidth-30;
    self.businessLicense = [[UIImageView alloc]initWithFrame:CGRectMake(15, _navView.maxY+40, imgSize, imgSize)];
    _businessLicense.contentMode = UIViewContentModeScaleAspectFit;
    _businessLicense.layer.borderWidth = 1;
    _businessLicense.layer.borderColor = [[UIColor colorFromHexCode:@"#666666"] CGColor];
    [self.view addSubview:_businessLicense];
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _imageBtn.frame = CGRectMake(kScreenWidth/2-50, _businessLicense.maxY+10, 100, 35);
    [_imageBtn setTitle:@"点击上传" forState:UIControlStateNormal];
    _imageBtn.layer.borderWidth = 1;
    _imageBtn.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
    _imageBtn.layer.cornerRadius = 3;
    _imageBtn.clipsToBounds = YES;
    [_imageBtn addTarget:self action:@selector(uploadInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageBtn];
    
    ToolButtonView * toolBtn = [[ToolButtonView alloc] initWithFrame:CGRectMake(0, kScreenHeight-SafeAreaBottomHeight-49, kScreenWidth, 49) button:@"下一步"];
    [toolBtn addToolTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];
}
//更新文案
-(void)updateImageBtnTitle{
    if (_businessLicense) {
        [_imageBtn setTitle:@"重新上传" forState:UIControlStateNormal];
    }else{
        [_imageBtn setTitle:@"点击上传" forState:UIControlStateNormal];
    }
}

-(void)uploadInfo{
    [self loadAlertController];
}

-(void)toolButtonAction:(UIButton*)sender{
    sender.userInteractionEnabled = NO;
    if (!_businessLicense.image) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还没有上传图片,确定跳过吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"考虑一下" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"直接跳过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            PtLicenseViewController *ptL = [[PtLicenseViewController alloc] init];
            [self.navigationController pushViewController:ptL animated:YES];
        }];
        [ac addAction:cancel];
        [ac addAction:sure];
        [self presentViewController:ac animated:YES completion:^{
            sender.userInteractionEnabled = YES;
        }];
        return;
    }
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [BaseApi postMenthodWirhUrlString:[NSString stringWithFormat:@"%@%@?Corpid=%@&P_type=%@",HostPath,UploadClinicImages,self.corpid,@"2"] paramDic:pargrams image:self.businessLicense.image progress:^(NSProgress * upload) {
        
    } block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            
            PtLicenseViewController *ptL = [[PtLicenseViewController alloc] init];
            ptL.corpid = _corpid;
            [self.navigationController pushViewController:ptL animated:YES];
        }else{
            
            [HUDUtil Hud_message:error.domain view:self.view];
        }
    }];
    sender.userInteractionEnabled = YES;
}

#pragma mark - photo
- (void)loadAlertController{
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
//打开本地相册
-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
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
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - UIImagePickerDelegate
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [self.businessLicense setImage:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self updateImageBtnTitle];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
