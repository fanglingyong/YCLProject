//
//  OrderCenterViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderCenterViewController.h"
#import "NavView.h"
#import "StageChooseView.h"

#import "AllOrderViewController.h"  //全部
#import "WaitPayViewController.h"   //待付款
#import "WaitGoodsViewController.h" //待收货
#import "WaitShipViewController.h"  //待发货
#import "HaveGoodsViewController.h" //已收货
#import "AfterSalesViewController.h"//已完成

@interface OrderCenterViewController ()<StageChooseViewDelegate>

@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic,strong)AllOrderViewController *allOrderViewController;
@property(nonatomic,strong)WaitPayViewController *waitPayViewController;
@property(nonatomic,strong)WaitGoodsViewController *waitGoodsViewController;
@property(nonatomic,strong)WaitShipViewController *waitShipViewController;
@property(nonatomic,strong)HaveGoodsViewController *haveGoodsViewController;
@property(nonatomic,strong)AfterSalesViewController *afterSalesViewController;

@property(nonatomic,strong)NSMutableArray *controllersArr;


@end

@implementation OrderCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.stageChooseView setMinY:self.navView.maxY];
    
    self.controllersArr = [[NSMutableArray alloc] init];
    
    [self.controllersArr addObject:self.allOrderViewController];
    [self.controllersArr addObject:self.waitPayViewController];
    [self.controllersArr addObject:self.waitGoodsViewController];
    [self.controllersArr addObject:self.waitShipViewController];
    [self.controllersArr addObject:self.haveGoodsViewController];
    [self.controllersArr addObject:self.afterSalesViewController];
    NSLog(@"%ld", (long)self.selectType);
    [self selectStage:self.selectType];
    [self.stageChooseView stageLabelClickedWithSequence:self.selectType];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - 页面元素

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"全部", @"待支付", @"待发货", @"待收货", @"已收货", @"已完成"] numbers:nil delegate:self underLineIsWhole:YES normalColor:AllThreeColor highlightColor:NavColor height:HeightXiShu(44)];
        [_stageChooseView hideVerticalLine];
        [self.view addSubview:_stageChooseView];
    }
    return _stageChooseView;
}

- (AllOrderViewController *)allOrderViewController {
    if(!_allOrderViewController){
        _allOrderViewController = [[AllOrderViewController alloc] init];
    }
    return _allOrderViewController;
}

- (WaitPayViewController *)waitPayViewController {
    
    if(!_waitPayViewController){
        _waitPayViewController = [[WaitPayViewController alloc] init];
    }
    return _waitPayViewController;
}


- (WaitGoodsViewController *)waitGoodsViewController {
    if(!_waitGoodsViewController){
        _waitGoodsViewController = [[WaitGoodsViewController alloc] init];
    }
    return _waitGoodsViewController;
}

- (WaitShipViewController *)waitShipViewController {
    if(!_waitShipViewController){
        _waitShipViewController = [[WaitShipViewController alloc] init];
    }
    return _waitShipViewController;
}
- (HaveGoodsViewController *)haveGoodsViewController {
    if(!_haveGoodsViewController){
        _haveGoodsViewController = [[HaveGoodsViewController alloc] init];
    }
    return _haveGoodsViewController;
}
- (AfterSalesViewController *)afterSalesViewController {
    if(!_afterSalesViewController){
        _afterSalesViewController = [[AfterSalesViewController alloc] init];
    }
    return _afterSalesViewController;
}

#pragma mark - 事件
-(void)selectStage:(NSInteger)index{
    UIViewController *controller = self.controllersArr[index];
    controller.view.frame = CGRectMake(0, self.stageChooseView.maxY, kScreenWidth, kScreenHeight - self.stageChooseView.maxY);
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@",[controller class]] object:self userInfo:nil];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - StageChooseViewDelegate
- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber {
    [self selectStage:stageNumber];
}


@end
