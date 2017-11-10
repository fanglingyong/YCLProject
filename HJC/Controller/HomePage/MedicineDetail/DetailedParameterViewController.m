//
//  DetailedParameterViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "DetailedParameterViewController.h"
#import "MerchandiseFooterButton.h"

@interface DetailedParameterViewController ()<MerchandiseFooterButtonDelegate>

@property (nonatomic, retain)NSMutableArray *dateArray;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;

@end


@implementation DetailedParameterViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.tableView setMinY:0 maxY:kScreenHeight - HeightXiShu(110) - HeightXiShu(55)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
    
    [self.dateArray addObject:@"倍他乐克 酒石酸美托洛尔片"];
    [self.dateArray addObject:@"阿斯利康制药有限公司"];
    [self.dateArray addObject:@"25mg * 20s"];
    [self.dateArray addObject:@"本品用于治疗高血压、心绞痛、心肌梗死、肥厚性心肌病、主动脉夹层、心律失常、甲状腺功能亢进、心脏神经官能症等。近年来尚用于心力衰竭的治疗，此时应在有经验的医师指导下使用。"];
    [self.dateArray addObject:@"酒石酸美托洛尔"];
    [self.dateArray addObject:@"治疗高血压100～200mg/次，一日2次，在血液动力学稳定后立即使用。急性心肌梗死主张在早期，即最初的几小时内使用，因为即刻使用在未能溶栓的患者中可减小梗死范围、降低短期(15天)死亡率(此作用在用药后24小时即出现)。在已经溶栓的患者中可降低再梗死率与再缺血率，若在2小时内用药还可以降低死亡率。一般用法：可先静脉注射美托洛尔2.5～5mg/次(2分钟内)，每5分钟一次，共3次10～15mg。之后15分钟开始口服25～50mg，每6～12小时一次，共24～48小时，然后口服50～100mg/次，一日2次"];
    [self.dateArray addObject:@"暂不明确"];
    [self footerView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 页面元素
- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(104) - HeightXiShu(55), kScreenWidth, HeightXiShu(55))];
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
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = self.dateArray[indexPath.row];
    CGRect redt = [self countHeight:string];
    return HeightXiShu(25) + HeightXiShu(redt.size.height) + HeightXiShu(10);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, kScreenWidth - WidthXiShu(20), HeightXiShu(25))];
    titleLabel.text = @[@"药品名称", @"厂家", @"规格 / 包装", @"功能主治", @"主要成分", @"用法用量", @"不良反应"][indexPath.row];
    titleLabel.textColor = BlackColor;
    titleLabel.font = HEITI(HeightXiShu(15));
    [cell.contentView addSubview:titleLabel];
    
    NSString *string = self.dateArray[indexPath.row];
    CGRect redt = [self countHeight:string];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(25), kScreenWidth - WidthXiShu(20), HeightXiShu(redt.size.height))];
    detailLabel.text = self.dateArray[indexPath.row];
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = BlackColor;
    detailLabel.font = HEITI(HeightXiShu(12));
    [cell.contentView addSubview:detailLabel];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, detailLabel.maxY + HeightXiShu(9), kScreenWidth - WidthXiShu(40), .5)];
    lineView.backgroundColor = AllLightGrayColor;
    [cell.contentView addSubview:lineView];
    
    return cell;
}
#pragma mark - 事件

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

- (CGRect)countHeight:(NSString *)text {
    CGSize size = CGSizeMake(kScreenWidth - WidthXiShu(20), CGFLOAT_MAX);
    UIFont *font = [UIFont systemFontOfSize:HeightXiShu(12)];
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect;
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
