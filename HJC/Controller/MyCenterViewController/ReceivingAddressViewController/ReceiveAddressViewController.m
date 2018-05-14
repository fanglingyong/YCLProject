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

@interface ReceiveAddressViewController()
<ReceiveAddressCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UIButton *addButton;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ReceiveAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self navView];
    [self addButton];
    [self.view addSubview:self.tableView];
    [self net_work];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  SafeAreaTopHeight, kScreenWidth, kScreenHeight-SafeAreaBottomHeight-SafeAreaTopHeight - HeightXiShu(50) - HeightXiShu(5)) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = AllBackLightGratColor;
    }
    return _tableView;
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
    }
    cell.delegate = self;
    cell.model = model;
    cell.row = indexPath;
    return cell;
}

- (void)cellMenthodClickToDoOnController:(NSInteger)type row:(NSIndexPath*)row{
    ReceiveAddressModel*model = [[ReceiveAddressModel alloc] init];
    model = self.modelArr[row.row];
    if (type==1) {
        //编辑
        NewAddressViewController * VC = [[NewAddressViewController alloc] init];
        VC.model=model;
        __block typeof(self) wself = self;
        VC.block = ^{
            [wself net_work];//--update this page ui
        };
        [self.navigationController pushViewController:VC animated:YES];
    }else if (type == 2){
        //删除
        [self deleteModel:model row:row.row];
    }
}
-(void)deleteModel:(ReceiveAddressModel*)model row:(NSInteger)row{
    NSMutableDictionary *pargams = [NSMutableDictionary dictionary];
    [pargams setObject:[UserModel getUserModel].P_LSM forKey:@"Userid"];
    [pargams setObject:model.ADDRESSID forKey:@"ADDRESSID"];
    [pargams setObject:[UserModel getUserModel].RID forKey:@"CORPID"];
    [pargams setObject:model.ADDRESS forKey:@"ADDRESS"];
    [pargams setObject:model.POSTCODE forKey:@"POSTCODE"];
    [pargams setObject:model.LINK forKey:@"LINK"];
    [pargams setObject:@"2" forKey:@"ISVALID"];//新增和修改填1，删除记录填2
    //    NSLog(@"%@", pargams);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BaseApi getMenthodWithUrl:UpdateCorpAddressURL block:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (dict) {
                [_modelArr removeObjectAtIndex:row];
                [self.tableView reloadData];
            }else{
                [HUDUtil Hud_message:error.domain view:self.view];
            }
        });
    } dic:pargams noNetWork:nil];
}

#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addButtonPress {
    NewAddressViewController * VC = [[NewAddressViewController alloc] init];
    VC.addressID = @"0";
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
