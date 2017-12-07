//
//  MedicineDetailViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailViewController.h"
#import "NavView.h"
#import "MedicineDetailCell.h"
#import "MedicineDetailModel.h"

#import "CycleScrollView.h"
#import "MerchandiseFooterButton.h"

@interface MedicineDetailViewController ()<MerchandiseFooterButtonDelegate>

@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;

@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
// banner
@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UILabel *pageLb;
@property(nonatomic, retain)NSMutableArray *bannerArray;
@end

@implementation MedicineDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.startIndex = 0;
        self.modelArr = [NSMutableArray array];
        self.bannerArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self navView];
    // Do any additional setup after loading the view.
    
    [self.tableView setMinY:64 maxY:kScreenHeight - HeightXiShu(50)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-d1131eb89323cd1e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/8390198-e0efc31aa87a32fb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-a4cc27b8469fbb8e.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    
    [self createAdScrollView];
    [self footerView];
    
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

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"药品详情页";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
        
        navView.rightBtn.hidden = NO;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"more"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _navView;
}

- (void)createAdScrollView {
    
    NSLog(@"%@", self.bannerArray);
    
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
    NSLog(@"创建banner");
    
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.adScrollView];
    self.pageLb = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(60), HeightXiShu(350) - HeightXiShu(40), WidthXiShu(40), HeightXiShu(20))];
    self.pageLb.textAlignment = NSTextAlignmentCenter;
    self.pageLb.layer.masksToBounds = YES;
    self.pageLb.layer.borderWidth = .5;
    self.pageLb.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
    
    if (self.bannerArray.count == 1) {
        self.pageLb.text = @"1/1";
    } else if (self.bannerArray.count > 1) {
        self.pageLb.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.bannerArray.count];
    }
    
    [self.adScrollView addSubview:self.pageLb];
    [self createBannerImages];
    
}

-(void)createBannerImages {
    
    if (self.bannerArray.count != 0) {
        
        NSLog(@"%@", self.bannerArray);
        NSLog(@"创建banner图片");
        
        __weak typeof(MedicineDetailViewController) *weakSelf = self;
        weakSelf.pageLb.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.bannerArray.count];
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350))];
            NSString *url = weakSelf.bannerArray[pageIndex];
            NSLog(@"%@", url);
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            return imageView;
        };
        
        self.adScrollView.totalPagesCount = ^NSInteger(){
            if (weakSelf.bannerArray.count != 0) {
                return weakSelf.bannerArray.count;
            }else{
                return 0;
            }
        };
        
        self.adScrollView.CurrentPageBlock = ^(NSInteger pageIndex){
            weakSelf.pageLb.text = [NSString stringWithFormat:@"%ld/%lu", (long)pageIndex, (unsigned long)weakSelf.bannerArray.count];

        };
        //跳转事件
        self.adScrollView.TapActionBlock = ^(NSInteger pageIndex){
            NSString *url = weakSelf.bannerArray[pageIndex];
            if (url.length > 0) {
                //                [weakSelf clickGoToNewVC:url WithName:@""];
            } else {
                return;
            }
        };
    } else {
        return;
    }
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350))];
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
    }
    return _headerView;
}

- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(50), kScreenWidth, HeightXiShu(50))];
        footerView.delegate = self;
        footerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
    
}



#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(1);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(1))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicineDetailModel *model = [[MedicineDetailModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"MedicineDetailCell";
    MedicineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MedicineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    return cell;
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moreClick {
    
}
#pragma mark - 事件
- (void)didOftenBuyListButton:(UIButton *)button {
    NSLog(@"加常购清单");
    
    
}

- (void)didCustomerServiceButton:(UIButton *)button {
    NSLog(@"联系客服");
    
    
}

- (void)didShoppingCartButton:(UIButton *)button {
    NSLog(@"购物车");
    
    
}

- (void)didAddShoppingCartButton:(UIButton *)button {
    NSLog(@"加购物车");
    
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

