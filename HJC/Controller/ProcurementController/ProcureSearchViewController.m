//
//  ProcureSearchViewController.m
//  HJC
//
//  Created by zhifu360 on 2018/1/8.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "ProcureSearchViewController.h"
#import "NavView.h"

@interface ProcureSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic,strong)NavView *navView;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIView *searchBGView;
@property (nonatomic, retain)UIImageView *searchImg;
@property (nonatomic, retain)UITextField *searchTF;
@property (nonatomic, retain)UILabel *placeLabel;
@property (nonatomic, retain)UIButton *searchBtn;

@property (nonatomic, retain)NSMutableArray *searchArr;
@property (nonatomic, retain)NSMutableArray *hotArr;

@end

@implementation ProcureSearchViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchArr = [NSMutableArray array];
        self.hotArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self statusBar];
    [self navView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.searchArr = [NSMutableArray arrayWithObject:@"泮立苏"];
    self.hotArr = [NSMutableArray arrayWithObjects:@"泮立苏", @"优甲乐", @"亮甲", nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark - tableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightXiShu(25);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
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
    if (indexPath.section == 0) {
        NSInteger row = self.searchArr.count / 6;
        return HeightXiShu(45) * (row + 1);
    }
    NSInteger row = self.hotArr.count / 6;
    return HeightXiShu(45) * (row + 1);

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"ProcurementCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CGFloat width = (kScreenWidth - WidthXiShu(30) - WidthXiShu(25)) / 6;
    CGFloat height = HeightXiShu(25);
    
    if (indexPath.section == 0) {
        for (int i = 0; i < self.searchArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
            [button setTitle:[NSString stringWithFormat:@"%@", self.searchArr[i]] forState:UIControlStateNormal];
            button.titleLabel.font = HEITI(HeightXiShu(12));
            [button setTitleColor:TitleColor forState:UIControlStateNormal];
            button.frame = CGRectMake(WidthXiShu(15) + (width + WidthXiShu(5)) * (i % 6), HeightXiShu(10) + (HeightXiShu(25) + HeightXiShu(5)) * (i / 6), width, height);
            [cell.contentView addSubview:button];
        }
    } else {
        for (int i = 0; i < self.hotArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
            [button setTitle:[NSString stringWithFormat:@"%@", self.hotArr[i]] forState:UIControlStateNormal];
            button.titleLabel.font = HEITI(HeightXiShu(12));
            [button setTitleColor:TitleColor forState:UIControlStateNormal];
            button.frame = CGRectMake(WidthXiShu(15) + (width + WidthXiShu(5)) * (i % 6), HeightXiShu(10) + (HeightXiShu(25) + HeightXiShu(5)) * (i / 6), width, height);
            [cell.contentView addSubview:button];
        }
    }
    return cell;
}


#pragma mark - 页面元素

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = NavColor;
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

        self.searchBGView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(35), HeightXiShu(12), WidthXiShu(290), HeightXiShu(20))];
        self.searchBGView.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
        self.searchBGView.layer.masksToBounds = YES;
        self.searchBGView.layer.cornerRadius = HeightXiShu(10);
        [navView addSubview:self.searchBGView];
        
        self.searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(45), HeightXiShu(14), WidthXiShu(16), HeightXiShu(16))];
        self.searchImg.image = [GetImagePath getImagePath:@"search"];
        [navView addSubview:self.searchImg];
        
        self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(70), HeightXiShu(12), WidthXiShu(150), HeightXiShu(20))];
        self.searchTF.delegate = self;
        self.searchTF.textColor = TitleColor;
        self.searchTF.font = HEITI(HeightXiShu(13));
        self.searchTF.backgroundColor = [UIColor colorFromHexCode:@"#f0f1f2"];
        [navView addSubview:self.searchTF];

        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(70), HeightXiShu(12), WidthXiShu(150), HeightXiShu(20))];
        self.placeLabel.text = @"泮立苏";
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
- (void)searchClick {
    
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
