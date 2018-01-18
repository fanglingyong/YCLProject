//
//  IntegralBreedViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/10/23.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "IntegralBreedViewController.h"
#import "MedicineBreedCell.h"
#import "MedicineBreesModel.h"
#import "MedicineDetailViewController.h"
@interface IntegralBreedViewController ()<MedicineBreedCellDelegate>

@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

@end

@implementation IntegralBreedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:[NSString stringWithFormat:@"%@",[self class]] object:nil];

    
    [self.tableView setMinY:0 maxY:kScreenHeight-HeightXiShu(110)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"IntegralBreedViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@",[self class]] object:nil];
}

#pragma mark - tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.modelArr.count;
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightXiShu(150);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicineBreesModel *model = self.modelArr[indexPath.row];
    static NSString* const identifier = @"MedicineBreedCell";
    MedicineBreedCell *medicineBreedCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!medicineBreedCell) {
        medicineBreedCell = [[MedicineBreedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        medicineBreedCell.selectionStyle = UITableViewCellSelectionStyleNone;
    } 
    
    medicineBreedCell.delegate = self;
    medicineBreedCell.indexPath = indexPath;
    medicineBreedCell.model = model;
    return medicineBreedCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MedicineDetailViewController *VC = [[MedicineDetailViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        
    }

}
#pragma mark - 事件
-(void)reloadData{
    NSLog(@"MyCarInsuranceAllViewController reloadData");
    [self netWorkWithType:BaseTableViewRefreshFirstLoad];
}

- (void)addShoppingCartClick:(NSInteger)index {
    
//    NSLog(@"%ld", (long)index);
    
}

#pragma mark - 接口
- (void)handleData {
    
    
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
