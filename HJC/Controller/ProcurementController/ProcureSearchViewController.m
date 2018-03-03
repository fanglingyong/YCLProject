//
//  ProcureSearchViewController.m
//  HJC
//
//  Created by zhifu360 on 2018/1/8.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ProcureSearchViewController.h"
#import "NavView.h"
#import "ProcurementModel.h"
#import "ProcurementCell.h"

@interface ProcureSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIView *searchBGView;
@property (nonatomic, retain)UIImageView *searchImg;
@property (nonatomic, retain)UITextField *searchTF;
@property (nonatomic, retain)UILabel *placeLabel;
@property (nonatomic, retain)UIButton *searchBtn;

@property (nonatomic, retain)NSMutableArray *allHistoryArr;
@property (nonatomic, retain)NSMutableArray *historyArr;
@property (nonatomic, retain)NSMutableArray *hotArr;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, assign)BOOL isDataTableView;
@end

@implementation ProcureSearchViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allHistoryArr = [NSMutableArray array];
        self.historyArr = [NSMutableArray array];
        self.hotArr = [NSMutableArray array];
        self.dataArray = [NSMutableArray array];
        self.isDataTableView = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self statusBar];
    [self navView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
//    self.historyArr = [NSMutableArray arrayWithObject:@"泮立苏"];
    self.hotArr = [NSMutableArray arrayWithObjects:@"六味地黄胶囊", @"上清胶囊", @"乳果糖口服液", nil];
    [self.searchTF becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)reloadData {
    NSLog(@"%@", self.allHistoryArr);
    if (self.historyArr.count > 0) {
        [self.historyArr removeAllObjects];
    }
    if (self.allHistoryArr.count >= 10) {
        [self.historyArr addObjectsFromArray:[self.allHistoryArr subarrayWithRange:NSMakeRange(0, 10)]];
    } else {
        [self.historyArr addObjectsFromArray:self.allHistoryArr];
    }
    [self.tableView reloadData];
}


#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isDataTableView) {
        return 1;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isDataTableView) {
        return HeightXiShu(10);
    }
    return HeightXiShu(25);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isDataTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
        view.backgroundColor = AllLightGrayColor;
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(25))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(10), WidthXiShu(150), HeightXiShu(15))];
    if (section == 0) {
        label.text = @"最近搜索";
    } else {
        label.text = @"热门搜索";
    }
    label.font = HEITI(HeightXiShu(14));
    label.textColor = TitleColor;
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isDataTableView) {
        return HeightXiShu(135);
    } else {
        if (indexPath.section == 0) {
            NSInteger row = self.historyArr.count / 4;
            if (self.historyArr.count == 0) {
                return 0;
            }
            return HeightXiShu(45) * (row + 1);
        }
        NSInteger row = self.hotArr.count / 4;
        return HeightXiShu(45) * (row + 1);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isDataTableView) {
        return self.dataArray.count;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isDataTableView) {
        ProcurementModel *model = [[ProcurementModel alloc] init];
        if (self.dataArray.count > 0) {
            model = self.dataArray[indexPath.row];
        }
        static NSString *identifier = @"ProcurementSearchCell";
        ProcurementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ProcurementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        cell.indexPath = indexPath;
        return cell;
    } else {
        static NSString *identifier = @"ProcurementCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CGFloat width = (kScreenWidth - WidthXiShu(30) - WidthXiShu(25)) / 4;
        CGFloat height = HeightXiShu(25);
        
        if (indexPath.section == 0) {
            for (int i = 0; i < self.historyArr.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i;
                button.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
                [button setTitle:[NSString stringWithFormat:@"%@", self.historyArr[i]] forState:UIControlStateNormal];
                button.titleLabel.font = HEITI(HeightXiShu(12));
                [button setTitleColor:TitleColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(historyButtonAction:) forControlEvents:UIControlEventTouchDown];
                button.frame = CGRectMake(WidthXiShu(15) + (width + WidthXiShu(5)) * (i % 4), HeightXiShu(10) + (HeightXiShu(25) + HeightXiShu(5)) * (i / 4), width, height);
                [cell.contentView addSubview:button];
            }
        } else {
            for (int i = 0; i < self.hotArr.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i;
                button.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
                [button setTitle:[NSString stringWithFormat:@"%@", self.hotArr[i]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(hotButtonAction:) forControlEvents:UIControlEventTouchDown];
                button.titleLabel.font = HEITI(HeightXiShu(12));
                [button setTitleColor:TitleColor forState:UIControlStateNormal];
                button.frame = CGRectMake(WidthXiShu(15) + (width + WidthXiShu(5)) * (i % 4), HeightXiShu(10) + (HeightXiShu(25) + HeightXiShu(5)) * (i / 4), width, height);
                [cell.contentView addSubview:button];
            }
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isDataTableView) {
        
    }
}

#pragma mark - 页面元素

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = NavColor;
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

        self.searchBGView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(35), HeightXiShu(7), WidthXiShu(290), HeightXiShu(30))];
        self.searchBGView.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
        self.searchBGView.layer.masksToBounds = YES;
        self.searchBGView.layer.cornerRadius = HeightXiShu(10);
        [navView addSubview:self.searchBGView];
        
        self.searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(45), HeightXiShu(14), WidthXiShu(16), HeightXiShu(16))];
        self.searchImg.image = [GetImagePath getImagePath:@"search"];
        [navView addSubview:self.searchImg];
        
        self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(70), HeightXiShu(11), WidthXiShu(150), HeightXiShu(22))];
        self.searchTF.delegate = self;
        self.searchTF.textColor = TitleColor;
        self.searchTF.font = HEITI(HeightXiShu(13));
        self.searchTF.returnKeyType = UIReturnKeySearch;
        self.searchTF.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
        [navView addSubview:self.searchTF];

        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(70), HeightXiShu(12), WidthXiShu(150), HeightXiShu(20))];
//        self.placeLabel.text = @"泮立苏";
        self.placeLabel.textColor = TitleColor;
        self.placeLabel.numberOfLines = 0;
        self.placeLabel.font = HEITI(HeightXiShu(13));
        self.placeLabel.textAlignment = NSTextAlignmentLeft;
        self.placeLabel.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
        [navView addSubview:self.placeLabel];
        
        navView.rightBtn.hidden = NO;
        [navView.rightBtn setImage:[GetImagePath getImagePath:@"search"] forState:UIControlStateNormal];
        navView.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, WidthXiShu(30), 0, 0);
        [navView.rightBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}


#pragma mark - 事件
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)historyButtonAction:(UIButton *)sender {
    NSLog(@"%ld", (long)sender.tag);
    self.searchTF.text = @"";
    [self searchWillToDo];
    [self network_procurementList:self.historyArr[sender.tag]];
    
}
- (void)hotButtonAction:(UIButton *)sender {
    NSLog(@"%ld", (long)sender.tag);
    self.searchTF.text = @"";
    [self searchWillToDo];
    [self network_procurementList:self.hotArr[sender.tag]];
}
- (void)searchClick {
    if (![AnimaDefaultUtil isNotNull:self.searchTF.text] ) {
        return;
    }
    [self searchWillToDo];
    [self network_procurementList:self.searchTF.text];
}
-(void)searchWillToDo{
    if ([self.searchTF canResignFirstResponder]) {
        [self.searchTF resignFirstResponder];
    }
    if (self.dataArray.count > 0) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
    }
    [self arrayWithMemberIsOnly:self.allHistoryArr name:self.searchTF.text];
    [self saveHistoryArray];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.isDataTableView = NO;
    [self getHistoryArray];
    [self reloadData];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchClick];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.placeLabel.alpha = 0;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.placeLabel.alpha =! textField.text.length;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTF resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
}

#pragma mark - 接口
-(void)network_procurementList:(NSString*)searchContent{
    
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:@",10,1" forKey:@"WebPara"];
    
    [pargrams setObject:[NSString stringWithFormat:@"0,0,%@",searchContent] forKey:@"Parastr"];// 分类DataID,供应商id,药品名称 [药品名称，不要传促销，促销会单独跳转。而不是放到参数里面请求]
    [pargrams setObject:[AnimaDefaultUtil getUserID] forKey:@"UserID"];//暂时设置为0因为只有0才有结果
    NSLog(@"这是采购页面pargrams :%@", pargrams);
    [BaseApi getMenthodWithUrl:GetGoodsListURL block:^(NSDictionary *dict, NSError *error) {
        if(!error){
            NSLog(@"请求成功了~~~~~~~~");
            NSArray *goodsArr = [NSArray arrayWithArray:dict[@"data"]];
            
            for (NSDictionary *dic in goodsArr) {
                ProcurementModel *model = [[ProcurementModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            self.isDataTableView = YES;
            [self.tableView reloadData];
        }else{
            [HUDUtil Hud_message:error.domain view:self.view];
        }
    } dic:pargrams noNetWork:nil];
    
}


- (void)getHistoryArray {
    
    if ([NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historyArray"]) {
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historyArray"];
        id array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        self.allHistoryArr = [NSMutableArray arrayWithArray:array];
    }
    NSLog(@"allHistoryArr%@", self.allHistoryArr);
}

- (void)saveHistoryArray {
    //归档
    NSArray *array = [NSArray arrayWithArray:self.allHistoryArr];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historyArray"];
    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    if(success){
        NSLog(@"保存成功");
    }
}
//  将数组重复的对象去除，只保留一个
- (void)arrayWithMemberIsOnly:(NSMutableArray *)historyArray name:(NSString *)name
{
    NSLog(@"%@",self.allHistoryArr);
    BOOL  bfound = NO;
    for (NSString *string in historyArray) {
        if (string && [string isEqualToString: name]) {
            [self.allHistoryArr removeObject:string];
            NSLog(@"cityHistoryArray%@", self.allHistoryArr);
            [self.allHistoryArr insertObject:name atIndex:0];
            NSLog(@"cityHistoryArray%@", self.allHistoryArr);
            return;
        }
    }
    if(!bfound) {
        [self.allHistoryArr insertObject:name atIndex:0];
    }
    NSLog(@"cityHistoryArray%@", self.allHistoryArr);
    
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
