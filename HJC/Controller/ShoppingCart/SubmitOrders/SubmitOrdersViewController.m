//
//  SubmitOrdersViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "SubmitOrdersViewController.h"
#import "NavView.h"
#import "SubmitOrdersCell.h"
#import "SubmitAddressModel.h"
#import "SubmitAddressCell.h"

@interface SubmitOrdersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NavView *navView;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *addressArr;

@property (nonatomic,strong) UIView *header0View;
@property (nonatomic,strong) UILabel *titLable;
@property (nonatomic,strong) UILabel *namePhoneLable;
@property (nonatomic,strong) UILabel *addressLable;
@property (nonatomic,strong) UILabel *remarksLable;
@property (nonatomic,strong) UITextField *remarksTF;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UILabel *totalLable;

@property (nonatomic,strong) NSString *addressID;

@end

@implementation SubmitOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    [self net_work];
    [self updatePrince];
    // Do any additional setup after loading the view.
}
#pragma mark - 页面元素
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}
-(UIView*)header0View{
    if (!_header0View) {
        _header0View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80+45)];
        _header0View.backgroundColor = [UIColor whiteColor];
        [_header0View addSubview:self.titLable];
        [_header0View addSubview:self.namePhoneLable];
        [_header0View addSubview:self.addressLable];
        [_header0View addSubview:self.remarksLable];
        [_header0View addSubview:self.remarksTF];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 124, kScreenWidth, 1)];
        view.backgroundColor = AllLightGrayColor;
        [_header0View addSubview:view];
    }
    return _header0View;
}
-(UILabel*)titLable{
    if (!_titLable) {
        _titLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 80, 60)];
        _titLable.text = @"收货地址";
        _titLable.font = [UIFont systemFontOfSize:18 weight:500];
    }
    return _titLable;
}
-(UILabel*)addressLable{
    if (!_addressLable) {
        _addressLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 36, kScreenWidth-108, 36)];
        _addressLable.text = @"浙江省杭州市上城区清泰街金鸡岭路1号北五楼信息中心";
        _addressLable.numberOfLines = 0;
        _addressLable.font = [UIFont systemFontOfSize:14];
    }
    return _addressLable;
}
-(UILabel*)namePhoneLable{
    if (!_namePhoneLable) {
        _namePhoneLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, kScreenWidth-108, 20)];
        _namePhoneLable.text = @"诸葛明懿 18813147418";
        _namePhoneLable.font = [UIFont systemFontOfSize:14];
    }
    return _namePhoneLable;
}
-(UILabel*)remarksLable{
    if (!_remarksLable) {
        _remarksLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 87, 80, 30)];
        _remarksLable.text = @"备注";
        _remarksLable.font = [UIFont systemFontOfSize:18 weight:500];
    }
    return _remarksLable;
}
-(UITextField*)remarksTF{
    if (!_remarksTF) {
        _remarksTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 87, kScreenWidth-108, 30)];
        _remarksTF.placeholder = @"请填写备注";
        _remarksTF.font = [UIFont systemFontOfSize:15];
    }
    return _remarksTF;
}
-(UIView*)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        self.totalLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-128, 29)];
        _totalLable.text = @"合计金额:￥0.00";
        _totalLable.textAlignment = NSTextAlignmentRight;
        _totalLable.font = [UIFont systemFontOfSize:15];
        [_footView addSubview:_totalLable];
        
        UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
        submit.frame = CGRectMake(kScreenWidth-100, 0, 100, 49);
        [submit setTitle:@"提交订单" forState:UIControlStateNormal];
        submit.backgroundColor = [UIColor colorFromHexCode:@"#2E58FF"];
        submit.titleLabel.font = [UIFont systemFontOfSize:14 weight:500];
        [submit addTarget:self action:@selector(submitOrders:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:submit];
    }
    return _footView;
}
#pragma mark - delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return _modelArr.count;
    }
    return _addressArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 125;
    }
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return [self header0View];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = AllBackLightGratColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 100.f;
    }
    return 44.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        SubmitOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"submitOrdersCell"];
        if (!cell) {
            cell = [[SubmitOrdersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"submitOrdersCell"];
        }
        cell.model = _modelArr[indexPath.row];
        return cell;
    }
    SubmitAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"submitAddressCell"];
    if (!cell) {
        cell = [[SubmitAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"submitAddressCell"];
    }
    cell.model = _addressArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        //点击选择此地址
        for (NSInteger i = 0; i<_addressArr.count; i++) {
            SubmitAddressModel*model = [[SubmitAddressModel alloc] init];
            model = _addressArr[i];
            if (i == indexPath.row) {
                [self setAddressInfo:model];
            }else{
                model.selThis = NO;
            }
        }
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark - 事件
-(void)submitOrders:(UIButton*)sender{
    if ([AnimaDefaultUtil isNotNull:_addressID]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
        [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
        [pargrams setObject:_orderNo forKey:@"ORDERNO"];
        [pargrams setObject:_orderIDs forKey:@"ORDERID"];
        [pargrams setObject:_addressID forKey:@"AddressID"];
        [pargrams setObject:_remarksTF.text forKey:@"Smemo"];
        NSLog(@"提交订单:%@",pargrams);
        [BaseApi getMenthodWithUrl:ProOrderURL block:^(NSDictionary *dict, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                NSLog(@"success------%@",dict);
            }else{
                NSLog(@"error------%@",error);
            }
        } dic:pargrams noNetWork:nil];
    }else{
        [HUDUtil Hud_message:@"收货地址为空" view:self.view];
    }
}
-(void)updatePrince{
    NSString*totalStr = [NSString stringWithFormat:@"合计金额:￥%.2f",self.totalMoeny];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(5,1)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,5)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,5)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#2E58FF"] range:NSMakeRange(5,totalStr.length-5)];
    _totalLable.attributedText = attStr;
}
-(void)setAddressInfo:(SubmitAddressModel*)model{
    _namePhoneLable.text = [NSString stringWithFormat:@"%@ %@",model.POSTCODE,model.LINK];
    _addressLable.text = model.ADDRESS;
    _addressID = model.ADDRESSID;
    [model setSelThis:YES];
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"提交订单";
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
#pragma mark - net
-(void)net_work{
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [BaseApi getMenthodWithUrl:GetCorpAddressURL block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            _addressArr = [NSMutableArray array];
            for (NSDictionary*modelDic in dict[@"data"]) {
                SubmitAddressModel*model = [[SubmitAddressModel alloc]init];
                [model setValuesForKeysWithDictionary:modelDic];
                [_addressArr addObject:model];
            }
            if (_addressArr.count>0) {
                [self setAddressInfo:_addressArr[0]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtil Hud_message:error.domain view:self.view];
            });
        }
    } dic:pargams noNetWork:nil];
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
