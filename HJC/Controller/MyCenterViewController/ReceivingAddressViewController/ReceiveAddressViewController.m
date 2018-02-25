//
//  ReceiveAddressViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ReceiveAddressViewController.h"
#import "NavView.h"
#import "ReceiveAddressCell.h"
#import "ReceiveAddressModel.h"
#import "NewAddressViewController.h"

@interface ReceiveAddressViewController ()
@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIButton *addButton;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation ReceiveAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self addButton];
    [self.tableView setMinY:SafeAreaTopHeight maxY:kScreenHeight-SafeAreaBottomHeight - HeightXiShu(50) - HeightXiShu(5)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self net_work];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        navView.titleLabel.text = @"收货地址管理";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}
- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(0, kScreenHeight-SafeAreaBottomHeight- HeightXiShu(50), kScreenWidth, HeightXiShu(50));
        addButton.backgroundColor = [UIColor colorFromHexCode:@"#4172e4"];
        [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonPress) forControlEvents:UIControlEventTouchDown];
        addButton.titleLabel.font = HEITI(HeightXiShu(18));
        [self.view addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(145);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReceiveAddressModel *model = [[ReceiveAddressModel alloc] init];
    if (self.modelArr.count > 0) {
        model = self.modelArr[indexPath.row];
    }
    static NSString* const identifier = @"ReceiveAddressCell";
    ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ReceiveAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = AllBackLightGratColor;
    }
    cell.model = model;
    return cell;
}


#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addButtonPress {
    NewAddressViewController * VC = [[NewAddressViewController alloc] init];
    __block typeof(self) wself = self;
    VC.block = ^{
        [wself net_work];//--update this page ui
    };
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - requet
-(void)net_work{
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [BaseApi getMenthodWithUrl:GetCorpAddressURL block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            _modelArr = [NSMutableArray array];
            for (NSDictionary*modelDic in dict[@"data"]) {
                ReceiveAddressModel*model = [[ReceiveAddressModel alloc]init];
                [model setValuesForKeysWithDictionary:modelDic];
                [_modelArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HUDUtil Hud_message:error.domain view:self.view];
            });
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
