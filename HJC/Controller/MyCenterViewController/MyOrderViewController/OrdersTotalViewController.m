//
//  OrdersTotalViewController.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrdersTotalViewController.h"
#import "NavView.h"
#import "OrderStatus.h"
#import "HDDropdownButton.h"
#import "DropdownSimpleView.h"
#import "OrderTotalModel.h"
#import "OrderTotalCell.h"
#import "MyOrderViewController.h"
#import "DatePickeView.h"

@interface OrdersTotalViewController ()<UITableViewDelegate,UITableViewDataSource, DropdownViewDelegate, HDDropdownButtonDelegate, DatePickeViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NavView *navView;
@property (nonatomic, retain)UIView *contentView;;

@property (nonatomic, retain)OrderStatus *orderStatus;
@property (nonatomic, retain)DropdownSimpleView *dropView;
@property (nonatomic, retain)HDDropdownButton *orderStatusButton;
@property (nonatomic, strong)DatePickeView *picker;
@property (nonatomic, retain)UIView *noDateView;
@property (nonatomic, assign)NSInteger dateType;

@property (nonatomic, retain)UILabel *orderTimeLB;
@property (nonatomic, retain)UIButton *orderBegTimeBtn;
@property (nonatomic, retain)UIImageView *orderLineView;
@property (nonatomic, retain)UIButton *orderEndTimeBtn;
@property (nonatomic, retain)UIButton *orderSearchBtn;
@property (nonatomic, retain)NSMutableArray *orderStatusArray;

@property (nonatomic,strong) NSMutableArray *ordersArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation OrdersTotalViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderStatusArray = [NSMutableArray array];
        self.ordersArr = [NSMutableArray array];
        self.orderStatus = [[OrderStatus alloc] init];
        self.page = 1;
        self.dateType = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    self.view.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];

    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.dropView];
    [self.view addSubview:self.noDateView];

    [self networkGetOrders];
    // Do any additional setup after loading the view.

    [self.orderStatusArray addObject:@"订单状态0"];
    [self.orderStatusArray addObject:@"订单状态1"];
    [self.orderStatusArray addObject:@"订单状态2"];
    NSArray *array = [NSArray arrayWithObject:self.orderStatusArray];
    [self.orderStatus setupBasicArray:array];
}

#pragma mark - 事件

#pragma mark - net
-(void)networkGetOrders{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:[NSString stringWithFormat:@"%@ 00:00:00,%@ 00:00:00", self.orderBegTimeBtn.currentTitle, self.orderEndTimeBtn.currentTitle] forKey:@"Parastr"];

//    [pargrams setObject:@"2017-12-01 17:20:26,2017-12-25 17:20:44" forKey:@"Parastr"];
    [pargrams setObject:[NSString stringWithFormat:@",10,%ld",_page] forKey:@"WebPara"];
    NSLog(@"%@", pargrams)
    [BaseApi getMenthodWithUrl:GetOdersNo block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"%@",dict);
            if (self.noDateView) {
                self.noDateView.hidden = YES;
            }
            if (_page == 1) {
                self.ordersArr = [NSMutableArray array];
            }
            for (NSDictionary *orderDic in dict[@"data"]) {
                OrderTotalModel *orderModel = [[OrderTotalModel alloc] init];
                [orderModel setValuesForKeysWithDictionary:orderDic];
                [_ordersArr addObject:orderModel];
            }
        }else{
            if (self.ordersArr.count > 0) {
                [self.ordersArr removeAllObjects];
            }
            if (self.noDateView) {
                self.noDateView.hidden = NO;
            }
        }
        [_tableView reloadData];
    } dic:pargrams noNetWork:nil];
}
#pragma mark - 页面元素
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"我的订单";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastController_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
#pragma mark - headerView
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, HeightXiShu(44))];
        headerView.backgroundColor = [UIColor whiteColor];
        
        // 全部分类
        self.orderStatusButton = [[HDDropdownButton alloc] initWithFrame:CGRectMake(0, 0, WidthXiShu(120), HeightXiShu(44))];
        self.orderStatusButton.delegate = self;
        self.orderStatusButton.backgroundColor = [UIColor whiteColor];
        self.orderStatusButton.frontColor = TitleColor;
        self.orderStatusButton.title = self.orderStatus.orderStatusTitle;
        [headerView addSubview:self.orderStatusButton];
        
        self.orderTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(120), 0, WidthXiShu(70), HeightXiShu(44))];
        self.orderTimeLB.text = @"订单时间";
        self.orderTimeLB.backgroundColor = [UIColor whiteColor];
        self.orderTimeLB.textColor = TitleColor;
        self.orderTimeLB.font = HEITI(HeightXiShu(14));
        [headerView addSubview:self.orderTimeLB];
        
        self.orderBegTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderBegTimeBtn.frame = CGRectMake(WidthXiShu(190), HeightXiShu(12), WidthXiShu(70), HeightXiShu(20));
        self.orderBegTimeBtn.titleLabel.font = HEITI(HeightXiShu(12));
        [self.orderBegTimeBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.orderBegTimeBtn setTitle:@"2017-12-01" forState:UIControlStateNormal];
        [self.orderBegTimeBtn addTarget:self action:@selector(orderBegTimeBtnPress) forControlEvents:UIControlEventTouchDown];
        self.orderBegTimeBtn.backgroundColor = AllBackLightGratColor;
        [headerView addSubview:self.orderBegTimeBtn];
        
        self.orderLineView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(263), HeightXiShu(22), WidthXiShu(8), .5)];
        self.orderLineView.backgroundColor = TitleColor;
        [headerView addSubview:self.orderLineView];
        
        self.orderEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderEndTimeBtn.frame = CGRectMake(WidthXiShu(275),  HeightXiShu(12), WidthXiShu(70), HeightXiShu(20));
        self.orderEndTimeBtn.titleLabel.font = HEITI(HeightXiShu(12));
        [self.orderEndTimeBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.orderEndTimeBtn setTitle:@"2017-12-25" forState:UIControlStateNormal];
        [self.orderEndTimeBtn addTarget:self action:@selector(orderEndTimeBtnPress) forControlEvents:UIControlEventTouchDown];
        self.orderEndTimeBtn.backgroundColor = AllBackLightGratColor;
        [headerView addSubview:self.orderEndTimeBtn];
        
        self.orderSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderSearchBtn.frame = CGRectMake(WidthXiShu(345), HeightXiShu(12), WidthXiShu(20), HeightXiShu(20));
        [self.orderSearchBtn setImage:[GetImagePath getImagePath:@"search"] forState:UIControlStateNormal];
        [self.orderSearchBtn addTarget:self action:@selector(orderSearchBtnPress) forControlEvents:UIControlEventTouchDown];
        [headerView addSubview:self.orderSearchBtn];
        _headerView = headerView;
    }
    return _headerView;
}
- (DropdownSimpleView *)dropView {
    if (!_dropView) {
       DropdownSimpleView *dropView = [[DropdownSimpleView alloc] initWithFrame:CGRectMake(0, 64 + HeightXiShu(44), kScreenWidth, kScreenHeight - HeightXiShu(44))];
        dropView.delegate = self;
        dropView.hidden = YES;
        _dropView = dropView;
    }
    return _dropView;
}
- (UIView *)noDateView {
    if (!_noDateView) {
        UIView *noDateView = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.maxY + HeightXiShu(44), kScreenWidth, kScreenHeight-_navView.maxY - HeightXiShu(44))];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightXiShu(160), kScreenWidth, HeightXiShu(20))];
        label.text = @"暂无此类订单!";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = HEITI(HeightXiShu(15));
        label.textColor = BlackColor;
        [noDateView addSubview:label];
        
        noDateView.hidden = YES;
        _noDateView = noDateView;
    }
    return _noDateView;
}

#pragma mark - tableView
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _navView.maxY + HeightXiShu(44), kScreenWidth, kScreenHeight-_navView.maxY - HeightXiShu(44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ordersArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTotalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderTotalCell"];
    if (!cell) {
        cell = [[OrderTotalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderTotalCell"];
    }
    cell.model = _ordersArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderViewController *myorder = [[MyOrderViewController alloc] init];
    OrderTotalModel * model = [[OrderTotalModel alloc] init];
    model = _ordersArr[indexPath.row];
    myorder.orderNO = model.ORDERNO;
    [self.navigationController pushViewController:myorder animated:YES];
}


#pragma mark - 事件
-(void)backLastController_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)orderBegTimeBtnPress {
    self.dateType = 1;
    _picker = [[DatePickeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, HeightXiShu(190))];
    _picker.delegate = self;
    _picker.userInteractionEnabled = true;
    _picker.backgroundColor = [UIColor whiteColor];
    
    //1.创建NSCalendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //2.改变NSDateComponents
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    //3.获取NSDate
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    [_picker.datePicker setDate:newdate animated:YES];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:_picker];
    [UIView animateWithDuration:0.25 animations:^{
        _picker.transform = CGAffineTransformMakeTranslation(0, -HeightXiShu(190));
        self.tableView.scrollEnabled = NO;
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.35];
    }];
    
}
- (void)orderEndTimeBtnPress {
    self.dateType = 2;
    _picker = [[DatePickeView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, HeightXiShu(190))];
    _picker.delegate = self;
    _picker.userInteractionEnabled = true;
    _picker.backgroundColor = [UIColor whiteColor];
    
    //1.创建NSCalendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //2.改变NSDateComponents
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    //3.获取NSDate
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    [_picker.datePicker setDate:newdate animated:YES];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:_picker];
    [UIView animateWithDuration:0.25 animations:^{
        _picker.transform = CGAffineTransformMakeTranslation(0, -HeightXiShu(190));
        self.tableView.scrollEnabled = NO;
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.35];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orderSearchBtnPress {
    [self networkGetOrders];
}


#pragma mark--datepicker  取消协议点击事件
-(void)cancleButtonClickDelegate{
    NSLog(@"取消协议点击事件");
    [UIView animateWithDuration:0.3 animations:^{
        _picker.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_picker removeFromSuperview];
    }];
    self.tableView.scrollEnabled = YES;
    [self.contentView removeFromSuperview];
}
//
#pragma mark--datepicker  确认协议点击事件
-(void)sureButtonClickDelegate{
    NSLog(@"确认协议点击事件");
    NSLog(@"%@",_picker.time);
    if(_picker.time.length > 0){
        if (self.dateType == 1) {
            [self.orderBegTimeBtn setTitle:_picker.time forState:UIControlStateNormal];
        } else {
            [self.orderEndTimeBtn setTitle:_picker.time forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _picker.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
        [_picker removeFromSuperview];
    }];
    self.tableView.scrollEnabled = YES;
    [self.contentView removeFromSuperview];
    
}

#pragma mark - 支持下拉的Button的协议
- (void)deselectButtons {
    self.orderStatusButton.selected = NO;
    self.dropView.hidden = YES;
}
- (void)dropdownButton:(HDDropdownButton *)titleView didTapButton:(UIButton *)sender {
    
    if (titleView.selected == YES) {
        [self deselectButtons];
        
    } else {
        [self deselectButtons];
        if ([titleView isEqual:self.orderStatusButton]) {
            self.orderStatusButton.selected = YES;
            self.dropView.dataArray = self.orderStatus.orderStatusArray;
            self.dropView.tag = 1001;
            self.dropView.selectedIndex = self.orderStatus.orderStatus;
            [self.dropView resetContentFrame];
            self.dropView.hidden = NO;
            
            NSLog(@"dropView%lu", (unsigned long)self.dropView.selectedIndex);
            
            NSLog(@"全部分类");
        }
    }
}

- (void)didSelectRowOfFilterView:(DropdownView *)filterView {
    
    if (filterView.tag == 1001) {
        
        self.orderStatus.orderStatus = ((DropdownSimpleView *)filterView).selectedIndex;
        self.orderStatusButton.title = self.orderStatus.orderStatusTitle;
        
    }
    
    [self deselectButtons];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didHideFilterView:(DropdownView *)filterView {
    
    [self deselectButtons];
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
