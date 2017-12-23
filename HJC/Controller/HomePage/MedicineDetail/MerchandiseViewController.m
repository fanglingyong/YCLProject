//
//  MerchandiseViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MerchandiseViewController.h"
#import "MedicineDetailCell.h"
#import "MedicineDetailModel.h"
#import "CycleScrollView.h"
#import "MerchandiseFooterButton.h"
@interface MerchandiseViewController ()<MerchandiseFooterButtonDelegate>
@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)MerchandiseFooterButton *footerView;

@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;

// banner
@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *bannerArray;

@end

@implementation MerchandiseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.startIndex = 0;
        self.modelArr = [NSMutableArray array];
        self.bannerArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.tableView setMinY:0 maxY:kScreenHeight - HeightXiShu(110) - HeightXiShu(55)];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = AllBackLightGratColor;
   
    [self createAdScrollView];
    [self.view addSubview:self.footerView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)createAdScrollView {
    
    NSLog(@"%@", self.bannerArray);
    
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(170)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(170)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
    NSLog(@"创建banner");
    
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.adScrollView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - WidthXiShu(80), HeightXiShu(170) - HeightXiShu(30), WidthXiShu(160), HeightXiShu(20))];
    
    if (self.bannerArray.count == 1) {
        self.pageControl.pageIndicatorTintColor = [UIColor clearColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    } else if (self.bannerArray.count > 1) {
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    
    [self.adScrollView addSubview:self.pageControl];
    [self createBannerImages];
    
}

-(void)createBannerImages {
    
    if (self.bannerArray.count != 0) {
        
        NSLog(@"%@", self.bannerArray);
        NSLog(@"创建banner图片");
        
        __weak typeof(MerchandiseViewController) *weakSelf = self;
        self.pageControl.numberOfPages = self.bannerArray.count;
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(170))];
            NSString *url = weakSelf.bannerArray[pageIndex];
            NSLog(@"%@", url);
            [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            return imageView;
        };
        
        self.adScrollView.totalPagesCount = ^NSInteger(){
            if (weakSelf.bannerArray.count != 0) {
                return weakSelf.bannerArray.count;
            }else{
                return 0;
            }
        };
        
        self.adScrollView.CurrentPageBlock = ^(NSInteger pageIndex){
            weakSelf.pageControl.currentPage = pageIndex;
        };
        //跳转事件
        self.adScrollView.TapActionBlock = ^(NSInteger pageIndex){
            NSString *url = weakSelf.bannerArray[pageIndex];
            if (url.length > 0) {
//                [weakSelf clickGoToNewVC:url WithName:@""];
            } else {
                return;
            }
        };
    } else {
        return;
    }
}


#pragma mark - 页面元素

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(170))];
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
    }
    return _headerView;
}

- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(104) - HeightXiShu(55), kScreenWidth, HeightXiShu(55))];
        footerView.delegate = self;
        footerView.backgroundColor = [UIColor whiteColor];
        _footerView = footerView;
    }
    return _footerView;
    
}



#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    } else if (section == 1 || section == 2) {
        return 1;
    } else if (section == 3) {
        return 2;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return HeightXiShu(5);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(5))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return HeightXiShu(40);
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        return HeightXiShu(40);
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return HeightXiShu(35);
        }
        return HeightXiShu(110);
    } else {
        if (indexPath.row == 0) {
            return HeightXiShu(35);
        }
        return HeightXiShu(110);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth - WidthXiShu(15), HeightXiShu(40))];
            titleLabel.text = @"[积分专供]三九999感冒灵颗粒 10g*9袋";
            titleLabel.textColor = BlackColor;
            titleLabel.font = HEITI(HeightXiShu(13));
            [cell.contentView addSubview:titleLabel];
            
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(39), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
            
        } else if (indexPath.row == 1) {
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, kScreenWidth - WidthXiShu(10), HeightXiShu(40))];
            NSString *priceText = @"采购价 6.00 元/盒";
            priceLabel.textColor = TitleColor;
            priceLabel.font = HEITI(HeightXiShu(13));

            NSMutableAttributedString *priceAttStr = [[NSMutableAttributedString alloc] initWithString:priceText];
            [priceAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HeightXiShu(18)] range:NSMakeRange(3, priceText.length - 7)];
            [priceAttStr addAttribute:NSForegroundColorAttributeName value:AllRedColor range:NSMakeRange(3, priceText.length - 7)];
            priceLabel.attributedText = priceAttStr;
            [cell.contentView addSubview:priceLabel];
            
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth -  WidthXiShu(105), 0, WidthXiShu(100), HeightXiShu(40))];
            countLabel.textAlignment = NSTextAlignmentRight;
            NSString *countText = @"5盒起购";
            countLabel.textColor = TitleColor;
            countLabel.font = HEITI(HeightXiShu(13));
            NSMutableAttributedString *countAttStr = [[NSMutableAttributedString alloc] initWithString:countText];
            [countAttStr addAttribute:NSForegroundColorAttributeName value:AllRedColor range:NSMakeRange(0, countText.length - 3)];
            countLabel.attributedText = countAttStr;
            [cell.contentView addSubview:countLabel];
            
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(39), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
        } else {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth - WidthXiShu(15), HeightXiShu(40))];
            titleLabel.text = @"[采购说明区] 特价秒杀 过期不候 单人限购10盒子";
            titleLabel.textColor = TitleColor;
            titleLabel.font = HEITI(HeightXiShu(13));
            [cell.contentView addSubview:titleLabel];
            
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(39), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
        }
    } else if (indexPath.section == 1) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(65), HeightXiShu(40))];
        titleLabel.text = @"积分奖励";
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(13));
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(75), HeightXiShu(10), WidthXiShu(60), HeightXiShu(20))];
        detailLabel.text = @"积6分/盒";
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.backgroundColor = [UIColor orangeColor];
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.font = HEITI(HeightXiShu(11));
        [cell.contentView addSubview:detailLabel];
        
    } else if (indexPath.section == 2) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(65), HeightXiShu(40))];
        titleLabel.text = @"全场优惠";
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(13));
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(75), 0, kScreenWidth - WidthXiShu(75), HeightXiShu(40))];
        detailLabel.text = @"充值1000元送iPad, 仅供前1000人, 先到先得.";
        detailLabel.numberOfLines = 0;
        detailLabel.textColor = BlackColor;
        detailLabel.font = HEITI(HeightXiShu(13));
        [cell.contentView addSubview:detailLabel];
        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(8), WidthXiShu(4), HeightXiShu(19))];
            leftView.backgroundColor = [UIColor orangeColor];
            [cell.contentView addSubview:leftView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(35))];
            titleLabel.text = @"商品信息";
            titleLabel.textColor = [UIColor orangeColor];
            titleLabel.font = HEITI(HeightXiShu(13));
            [cell.contentView addSubview:titleLabel];
            
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth -  WidthXiShu(105), 0, WidthXiShu(100), HeightXiShu(35))];
            detailLabel.textAlignment = NSTextAlignmentRight;
            detailLabel.text = @"详细说明 >";
            detailLabel.textColor = TitleColor;
            detailLabel.font = HEITI(HeightXiShu(13));
            [cell.contentView addSubview:detailLabel];
            
            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(34), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
            
        } else {
            MedicineDetailModel *model = [[MedicineDetailModel alloc] init];
            if (self.modelArr.count > 0) {
                model = self.modelArr[indexPath.row];
            }
            static NSString* const identifier = @"MedicineDetailCell";
            MedicineDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!detailCell) {
                detailCell = [[MedicineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            detailCell.model = model;
            return detailCell;
        }
    } else {
        if (indexPath.row == 0) {
            UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(8), WidthXiShu(4), HeightXiShu(19))];
            leftView.backgroundColor = [UIColor orangeColor];
            [cell.contentView addSubview:leftView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(35))];
            titleLabel.text = @"为你推荐";
            titleLabel.textColor = [UIColor orangeColor];
            titleLabel.font = HEITI(HeightXiShu(13));
            [cell.contentView addSubview:titleLabel];

            UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(34), kScreenWidth, .5)];
            lineView.backgroundColor = AllLightGrayColor;
            [cell.contentView addSubview:lineView];
            
        } else {
            MedicineDetailModel *model = [[MedicineDetailModel alloc] init];
            if (self.modelArr.count > 0) {
                model = self.modelArr[indexPath.row];
            }
            static NSString* const identifier = @"MedicineDetailCell";
            MedicineDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!detailCell) {
                detailCell = [[MedicineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            detailCell.model = model;
            return detailCell;
        }
        
    }
    return cell;
}
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
