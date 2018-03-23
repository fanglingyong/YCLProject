//
//  RDViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/3/23.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "RDViewController.h"
#import "NavView.h"


@interface RDViewController ()
@property (nonatomic,strong) NavView *navView;

@end

@implementation RDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self loadDelegateContent];
    // Do any additional setup after loading the view.
}
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"注册协议";
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
#pragma mark -
-(void)loadDelegateContent{
    NSError *error=nil;
    // 通过指定的路径读取文本内容
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"registerDetelageContent"ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
//    CGFloat heig = [AnimaDefaultUtil getAutoLayoutHeight:str Lsize:CGSizeMake(kScreenWidth, 9999999) font:[UIFont systemFontOfSize:15]].height;
//    NSLog(@"-------------->%f",heig);
    UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight)];
    CGFloat hei = 5000.;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrolView.width, hei)];
    lable.text = str;
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:15];
    [scrolView addSubview:lable];
    scrolView.contentSize = CGSizeMake(kScreenWidth, hei);
    [self.view addSubview:scrolView];
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
