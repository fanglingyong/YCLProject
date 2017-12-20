//
//  NewAddressViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "NewAddressViewController.h"
#import "NavView.h"

@interface NewAddressViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIButton *sureButton;

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *phone;
@property (nonatomic, retain)NSString *address;
@property (nonatomic, assign)BOOL isAcquiescence;


@end

@implementation NewAddressViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.phone = @"";
        self.address = @"";
        self.isAcquiescence = NO;

    }
    return self;
}
-(void)setModel:(ReceiveAddressModel *)model{
    _name = model.POSTCODE;
    _phone = model.LINK;
    _address = model.ADDRESS;
    
    _isAcquiescence = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self sureButton];
    
    [self.tableView setMinY:64 maxY:kScreenHeight - HeightXiShu(50) - HeightXiShu(5)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 页面元素
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"收货地址管理";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(0, kScreenHeight - HeightXiShu(50), kScreenWidth, HeightXiShu(50));
        sureButton.backgroundColor = [UIColor colorFromHexCode:@"#4172e4"];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font = HEITI(HeightXiShu(18));
        [sureButton addTarget:self action:@selector(sureChangeOrAddbuttonMenthod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureButton];
        _sureButton = sureButton;
    }
    return _sureButton;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
    view.backgroundColor = AllBackLightGratColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return HeightXiShu(55);
        } else if (indexPath.row == 1) {
            return HeightXiShu(50);
        }
        return HeightXiShu(120);
    }
    return HeightXiShu(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* const identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(indexPath.section == 0){
        
        if (indexPath.row == 0) {
            UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, WidthXiShu(60), HeightXiShu(55))];
            nameLb.text = @"收货人";
            nameLb.textColor = BlackColor;
            nameLb.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:nameLb];
            
            UITextField *nameTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(80), 0, kScreenWidth - WidthXiShu(80), HeightXiShu(55))];
            nameTF.text = self.name;
            nameTF.delegate = self;
            nameTF.tag = 100;
            nameTF.textColor = BlackColor;
            nameTF.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:nameTF];
            
            UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(54), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
            cutLine.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:cutLine];
        } else if (indexPath.row == 1) {
            UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, WidthXiShu(60), HeightXiShu(50))];
            phoneLb.text = @"手机号";
            phoneLb.textColor = BlackColor;
            phoneLb.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:phoneLb];
            
            UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(80), 0, kScreenWidth - WidthXiShu(80), HeightXiShu(50))];
            phoneTF.text = self.phone;
            phoneTF.delegate = self;
            phoneTF.tag = 101;
            phoneTF.textColor = BlackColor;
            phoneTF.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:phoneTF];
            
            UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(49), kScreenWidth - WidthXiShu(20), HeightXiShu(1))];
            cutLine.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:cutLine];
        } else {
            UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, WidthXiShu(60), HeightXiShu(55))];
            addressLb.text = @"地址";
            addressLb.textColor = BlackColor;
            addressLb.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:addressLb];
            
            UITextView *addressTV = [[UITextView alloc] initWithFrame:CGRectMake(WidthXiShu(80), HeightXiShu(10), kScreenWidth - WidthXiShu(80) - WidthXiShu(10), HeightXiShu(110))];
            addressTV.textColor = BlackColor;
            addressTV.delegate = self;
            addressTV.text = self.address;
            addressTV.font = HEITI(HeightXiShu(15));
            [cell.contentView addSubview:addressTV];
        }
    } else {
        
        UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, WidthXiShu(110), HeightXiShu(55))];
        phoneLb.text = @"设为默认地址";
        phoneLb.textColor = BlackColor;
        phoneLb.font = HEITI(HeightXiShu(15));
        [cell.contentView addSubview:phoneLb];
        
        UISwitch *acquieSW = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(75), HeightXiShu(10), WidthXiShu(50), HeightXiShu(30))];
        [acquieSW setOn:self.isAcquiescence];;
        [cell.contentView addSubview:acquieSW];
    }
    return cell;
}


#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureChangeOrAddbuttonMenthod{
    if (_model) {
        NSLog(@"修改");
    }else{
        NSLog(@"新增");
        [self network_corpAddress];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        self.name = textField.text;
    } else if (textField.tag == 101) {
        self.phone = textField.text;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.address = textView.text;
}

/**
 修改新增 收货地址
 */
-(void)network_corpAddress{
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];
    [pargams setObject:_model.ADDRESSID forKey:@"ADDRESSID"];
    [pargams setObject:_model.CORPID forKey:@"CORPID"];
    [pargams setObject:self.address forKey:@"ADDRESS"];
    [pargams setObject:self.name forKey:@"POSTCODE"];
    [pargams setObject:self.phone forKey:@"LINK"];
    [pargams setObject:@"1" forKey:@"ISVALID"];//新增和修改填1，删除记录填2
    [BaseApi getMenthodWithUrl:UpdateCorpAddressURL block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            if ([dict[@"status"] isEqualToString:@"1"]) {
                
            }else{
                
            }
        }
    } dic:pargams noNetWork:nil];
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

