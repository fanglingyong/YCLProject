//
//  MedicineDetailViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailViewController.h"
#import "NavView.h"
#import "StageChooseView.h"
#import "MerchandiseViewController.h"
#import "DetailedParameterViewController.h"
#import "PurchasingRecordsViewController.h"

@interface MedicineDetailViewController ()<StageChooseViewDelegate>
@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic,strong)MerchandiseViewController *merchandiseViewController;
@property(nonatomic,strong)DetailedParameterViewController *detailedParameterViewController;
@property(nonatomic,strong)PurchasingRecordsViewController *purchasingRecordsViewController;
@property(nonatomic,strong)NSMutableArray *controllersArr;

@end

@implementation MedicineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self navView];
    // Do any additional setup after loading the view.
    [self.stageChooseView setMinY:self.navView.maxY];
    
    self.controllersArr = [[NSMutableArray alloc] init];
    [self.controllersArr addObject:self.merchandiseViewController];
    [self.controllersArr addObject:self.detailedParameterViewController];
    [self.controllersArr addObject:self.purchasingRecordsViewController];

    
    [self selectStage:0];
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

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"药品详情页";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"商品", @"详细参数", @"采购记录"] numbers:nil delegate:self underLineIsWhole:YES normalColor:AllThreeColor highlightColor:NavColor height:HeightXiShu(40)];
        
        [_stageChooseView hideVerticalLine];
        [self.view addSubview:_stageChooseView];
    }
    return _stageChooseView;
}

- (MerchandiseViewController *)merchandiseViewController {
    
    if(!_merchandiseViewController){
        _merchandiseViewController = [[MerchandiseViewController alloc] init];
    }
    return _merchandiseViewController;
}

- (DetailedParameterViewController *)detailedParameterViewController {
    if(!_detailedParameterViewController){
        _detailedParameterViewController = [[DetailedParameterViewController alloc] init];
    }
    return _detailedParameterViewController;
}

- (PurchasingRecordsViewController *)purchasingRecordsViewController {
    if(!_purchasingRecordsViewController){
        _purchasingRecordsViewController = [[PurchasingRecordsViewController alloc] init];
    }
    return _purchasingRecordsViewController;
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectStage:(NSInteger)index{
    UIViewController *controller = self.controllersArr[index];
    controller.view.frame = CGRectMake(0, self.stageChooseView.maxY, kScreenWidth, kScreenHeight-self.stageChooseView.maxY);
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@",[controller class]] object:self userInfo:nil];
}

#pragma mark - StageChooseViewDelegate
- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber {
    [self selectStage:stageNumber];
}


@end

