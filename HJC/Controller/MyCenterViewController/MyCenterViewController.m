//
//  MyCenterViewController.m
//  JieBa
//
//  Created by zhifu360 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterHead.h"
#import "MyCenterButton.h"
#import "NavView.h"

@interface MyCenterViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MyCenterHeadDelegate, MyCenterButtonDelegate>
@property(nonatomic,strong)MyCenterHead *headView;

@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderRefresh:NO footerRefresh:NO];
    [self.tableView setMinY:0 maxY:kScreenHeight - 44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
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
        return 3;
    }else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return HeightXiShu(70);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return HeightXiShu(40);
        }
        return HeightXiShu(70);
    }
    return HeightXiShu(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 0;
    }
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
        
        UILabel *shopCountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, HeightXiShu(40))];
        shopCountLB.text = @"12";
        shopCountLB.textAlignment = NSTextAlignmentCenter;
        shopCountLB.font = HEITI(HeightXiShu(25));
        [cell.contentView addSubview:shopCountLB];
        
        UILabel *shopListLB = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth / 2, HeightXiShu(30))];
        shopListLB.text = @"常用采购清单";
        shopListLB.textAlignment = NSTextAlignmentCenter;
        shopListLB.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:shopListLB];
        
        UILabel *integralCountLB = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, HeightXiShu(40))];
        integralCountLB.text = @"199";
        integralCountLB.textAlignment = NSTextAlignmentCenter;
        integralCountLB.font = HEITI(HeightXiShu(25));
        [cell.contentView addSubview:integralCountLB];
        
        UILabel *integralBalanceLB = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2, HeightXiShu(40), kScreenWidth / 2, HeightXiShu(30))];
        integralBalanceLB.text = @"积分余额";
        integralBalanceLB.textAlignment = NSTextAlignmentCenter;
        integralBalanceLB.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:integralBalanceLB];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - .5, 0, 1, HeightXiShu(70))];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
        
    } else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(40))];
            titleLabel.text = @"我的订单";
            titleLabel.textColor = TitleColor;
            titleLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:titleLabel];
            
            UILabel *moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth -  WidthXiShu(180), 0, WidthXiShu(170), HeightXiShu(40))];
            moreLabel.text = @"查看更多订单>";
            moreLabel.textAlignment = NSTextAlignmentRight;
            moreLabel.textColor = TitleColor;
            moreLabel.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:moreLabel];
            
            UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth, HeightXiShu(.5))];
            cutLine.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:cutLine];
            
        } else {
            
            for (int i = 0; i < 5; i++) {
                MyCenterButton *button = [[MyCenterButton alloc] initWithFrame:CGRectMake(kScreenWidth / 5 * i, 0, kScreenWidth / 5, HeightXiShu(70))];
                button.labelTitle = @[@"待支付", @"待发货", @"待收货", @"已收货", @"退款/售后"][i];
                button.delegate = self;
                [cell.contentView addSubview:button];
                
                UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth / 5 * i) - .5, 0, 1, HeightXiShu(70))];
                cutLine.backgroundColor = AllLightGrayColor;
                [cell.contentView addSubview:cutLine];
                
            }

        }

    } else if (indexPath.section == 2){
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(40))];
        titleLabel.text = @[@"诊所信息", @"收货地址", @"付款银行卡"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16), HeightXiShu(13), WidthXiShu(8), HeightXiShu(13))];
        arrowImgView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth, HeightXiShu(.5))];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
        
    } else {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(40))];
        titleLabel.text = @[@"帮助与反馈", @"退出登录"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(16), HeightXiShu(13), WidthXiShu(8), HeightXiShu(13))];
        arrowImgView.image = [GetImagePath getImagePath:@"myCenter_arrow"];
        [cell.contentView addSubview:arrowImgView];
        
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(40), kScreenWidth, HeightXiShu(.5))];
        cutLine.backgroundColor = AllLightGrayColor;
        [cell.contentView addSubview:cutLine];
    }
    return cell;
}

#pragma mark - 页面元素
- (MyCenterHead *)headView{
    if(!_headView){
        MyCenterHead *headView = [[MyCenterHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(210))];
        headView.delegate = self;
        _headView = headView;
    }
    return _headView;
}

#pragma mark - head的delegate

- (void)changeHeadClick{
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

#pragma mark - 接口
-(void)gotoAddImage:(NSData *)imageData image:(UIImage *)image{

}

#pragma mark - 选照片
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

//打开本地相册
-(void)localPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //UIImageWriteToSavedPhotosAlbum(image, self,nil, nil);
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    //    imageData = UIImageJPEGRepresentation([GetImagePath getImagePath:@"001"], .3);
    
    //NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    [self gotoAddImage:imageData image:image];
    //[self.headImgView setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
