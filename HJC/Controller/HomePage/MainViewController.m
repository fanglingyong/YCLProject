//
//  MainViewController.m
//  JieBa
//
//  Created by zhifu360 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainViewController.h"
#import "NavView.h"
#import "StageChooseView.h"
#import "IntegralBreedViewController.h"
#import "AllBreedViewController.h"

@interface MainViewController ()<StageChooseViewDelegate>

@property(nonatomic,strong)NavView *navView;
@property(nonatomic,strong)StageChooseView *stageChooseView;
@property(nonatomic,strong)IntegralBreedViewController *integralBreedViewController;
@property(nonatomic,strong)AllBreedViewController *allBreedViewController;
@property(nonatomic,strong)NSMutableArray *controllersArr;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self.stageChooseView setMinY:self.navView.maxY];
    
    self.controllersArr = [[NSMutableArray alloc] init];
    [self.controllersArr addObject:self.integralBreedViewController];
    [self.controllersArr addObject:self.allBreedViewController];

    
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

-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"首页";
        navView.leftBtn.hidden = YES;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"MyCarInsurance_More@2x"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
//        [navView.rightBtn addTarget:self action:@selector(mycar_MoreClick) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (StageChooseView *)stageChooseView {
    if (!_stageChooseView) {
        _stageChooseView = [StageChooseView stageChooseViewWithStages:@[@"积分品种", @"所有品种"] numbers:nil delegate:self underLineIsWhole:YES normalColor:AllThreeColor highlightColor:NavColor height:HeightXiShu(40)];
        
        [_stageChooseView hideVerticalLine];
        [self.view addSubview:_stageChooseView];
    }
    return _stageChooseView;
}

- (IntegralBreedViewController *)integralBreedViewController {
    
    if(!_integralBreedViewController){
        _integralBreedViewController = [[IntegralBreedViewController alloc] init];
    }
    return _integralBreedViewController;
}

- (AllBreedViewController *)allBreedViewController {
    if(!_allBreedViewController){
        _allBreedViewController = [[AllBreedViewController alloc] init];
    }
    return _allBreedViewController;
}

#pragma mark - 事件


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
