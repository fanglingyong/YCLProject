//
//  PromotionViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/2/28.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "PromotionViewController.h"
#import "NavView.h"

@interface PromotionViewController ()

@property(nonatomic,strong) NavView *navView;
@property(nonatomic,strong) NSMutableDictionary* pargrams;
@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,strong) UIView*noDataView;
@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.noDataView];
    [self network_procurementList];
    // Do any additional setup after loading the view.
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"促销";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
/****
 * need false View for nodata
 **/
-(UIView*)noDataView{
    if (!_noDataView) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-122, _navView.maxY+60, 244, 166)];
        _noDataView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodata.jpg"]];
    }
    return _noDataView;
}

-(void)network_procurementList{
    if (_pageIndex == 1) {
        self.pargrams = [NSMutableDictionary dictionary];
    }
    [_pargrams setObject:[NSString stringWithFormat:@",10,%ld",self.pageIndex] forKey:@"WebPara"];
    NSString *dataID = @"0";
    NSString *gysID = @"0";
    [_pargrams setObject:[NSString stringWithFormat:@"%@,%@,%@",dataID,gysID,@""] forKey:@"Parastr"];// 分类DataID,供应商id,药品名称 
    [_pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"UserID"];//暂时设置为0因为只有0才有结果
    NSLog(@"这是促销页面pargrams :%@", _pargrams);
    [BaseApi getMenthodWithUrl:GetSalesPromotion block:^(NSDictionary *dict, NSError *error) {
        if(!error){
            NSLog(@"请求成功了~~~~~~~~");
            self.noDataView.hidden = YES;
        }else{
            self.noDataView.hidden = NO;
            [HUDUtil Hud_message:@"暂无数据" view:self.view];
        }
    } dic:_pargrams noNetWork:nil];
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
