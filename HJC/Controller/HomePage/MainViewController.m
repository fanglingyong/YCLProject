//
//  MainViewController.m
//  JieBa
//
//  Created by zhifu360 on 16/10/14.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MainViewController.h"
#import "MainButtonCell.h"
#import "CycleScrollView.h"
#import "MainTableViewCell.h"
#import "MedicineDetailViewController.h"
#import "SCWebViewController.h"
#import "ProcurementNoTabViewController.h"
#import "PromotionViewController.h"
#import "IntegralDetailViewController.h"
#import "AdPageControl.h"
@interface MainViewController ()<MainButtonCellDelegate, ActivityZoneCellDelegate, RecommendVarietiesCellDelegate, UITextFieldDelegate >

@property(nonatomic,strong)NSMutableArray *controllersArr;

@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)UITextField *textField;

@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *bannerArray;
@property(nonatomic, retain)NSMutableArray *activeArray;
@property(nonatomic, retain)NSMutableArray *recommendArray;

@property(nonatomic, assign)BOOL isCreate;
@property (nonatomic, retain)UIView *searchView;

@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    [self homeFirstToDo];// ad page

    self.bannerArray = [NSMutableArray array];
    self.activeArray = [NSMutableArray array];
    self.recommendArray = [NSMutableArray array];
    self.isCreate = NO;
    [self.tableView setMinY:0 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self creatSearchBar];
}
-(void)homeFirstToDo{
    AdPageControl *ad = [[AdPageControl alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:ad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self handleDate];
}
#pragma mark - 页面元素

- (void)creatSearchBar {
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(13), HeightXiShu(10), WidthXiShu(315), HeightXiShu(22))];
    _searchView.layer.cornerRadius = WidthXiShu(10);
    _searchView.backgroundColor = [UIColor colorFromHexCode:@"#f4f4f4"];
    [self.headerView addSubview:_searchView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(13), HeightXiShu(4), WidthXiShu(15), HeightXiShu(15))];
    imageView.image = [GetImagePath getImagePath:@"search"];
    [_searchView addSubview:imageView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(WidthXiShu(35), HeightXiShu(0), WidthXiShu(200), HeightXiShu(22))];
    self.textField.delegate = self;
    self.textField.font = HEITI(HeightXiShu(13));
    self.textField.placeholder = @"泮立苏";
    [_searchView addSubview:self.textField];
    
}

- (void)createAdScrollView {
//    NSLog(@"%@", self.bannerArray);
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView insertSubview:self.adScrollView belowSubview:_searchView];
    if (self.bannerArray.count != 0) {
        __weak typeof(MainViewController) *weakSelf = self;
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175))];
            NSString *url = [[NSString stringWithFormat:@"%@%@", HomePic, weakSelf.bannerArray[pageIndex]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"%@", url);
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ruiwen"]];
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

            } else {
                return;
            }
        };
    } else {
        return;
    }
}

#pragma mark-- 跳web端
- (void)clickGoToNewVC:(NSString*)url WithName:(NSString*)title {
    
    SCWebViewController *webVc = [[SCWebViewController alloc]init];
//    NSLog(@"%@",url);
    webVc.urlString = url;
    webVc.titleString = title;
    webVc.IsNav = NO;
    webVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVc animated:true];
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175))];
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
    }
    return _headerView;
}


#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return HeightXiShu(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(10))];
    view.backgroundColor = AllLightGrayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return HeightXiShu(100);
    } else if (indexPath.section == 1) {
        return HeightXiShu(40);
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return HeightXiShu(30);
        }
        return HeightXiShu(150);
    } else {
        if (indexPath.row == 0) {
            return HeightXiShu(30);
        }
    }
    long row = self.recommendArray.count / 2;
    if (self.recommendArray.count % 2 > 0) {
        row += 1;
    }
    return HeightXiShu(210) * row;
    
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
       
        MainButtonCell *mainButtonView = [[MainButtonCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(100))];
        mainButtonView.delegate = self;
        [cell.contentView addSubview:mainButtonView];
        
    } else if (indexPath.section == 1) {
       
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(35), HeightXiShu(20))];
        dateLabel.text = @"公告";
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = [UIColor colorFromHexCode:@"#4172e4"];
        dateLabel.font = HEITI(HeightXiShu(11));
        [cell.contentView addSubview:dateLabel];
        
        
        UILabel *rearkLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(54), HeightXiShu(10), WidthXiShu(235), HeightXiShu(20))];
        rearkLabel.text = @"积分换购商品活动开始啦！";
        rearkLabel.textColor = [UIColor colorFromHexCode:@"#447de6"];
        rearkLabel.font = HEITI(HeightXiShu(11));
        [cell.contentView addSubview:rearkLabel];
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(150), HeightXiShu(30))];
            dateLabel.text = @"限时折扣";
            dateLabel.textColor = [UIColor colorFromHexCode:@"#447de6"];
            dateLabel.font = HEITI(HeightXiShu(11));
            [cell.contentView addSubview:dateLabel];
        } else {
            
            static NSString *identifier = @"ActivityZoneCell";
            ActivityZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[ActivityZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

            cell.delegate = self;
            if (self.activeArray.count > 0) {
                [cell setDate:self.activeArray];
            }
            return cell;
        }

    } else {
        if (indexPath.row == 0) {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(5), WidthXiShu(150), HeightXiShu(25))];
            dateLabel.text = @"新品推荐";
            dateLabel.textColor = [UIColor colorFromHexCode:@"#447de6"];
            dateLabel.font = HEITI(HeightXiShu(11));
            [cell.contentView addSubview:dateLabel];
        } else {
            static NSString *identifier = @"RecommendVarietiesCell";
            RecommendVarietiesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[RecommendVarietiesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            cell.delegate = self;
            if (self.recommendArray.count > 0) {
                [cell setDate:self.recommendArray];
            }
            return cell;
        }
    }
    return cell;
}

#pragma mark - 事件

#pragma - mark delegate
-(void)mainButtonClick:(NSInteger)index{
    switch (index) {
        case 0:
        {
            NSLog(@"诊特惠");
            ProcurementNoTabViewController *pnt = [[ProcurementNoTabViewController alloc]init];
            pnt.classType = 1;
            pnt.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pnt animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"药世界");
            ProcurementNoTabViewController *pnt = [[ProcurementNoTabViewController alloc]init];
            pnt.classType = 2;
            pnt.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pnt animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"换积分");
            ProcurementNoTabViewController *pnt = [[ProcurementNoTabViewController alloc]init];
            pnt.classType = 3;
            pnt.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pnt animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"云药房"); //跳转到积分页面
            IntegralDetailViewController *idv = [[IntegralDetailViewController alloc] init];
            idv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:idv animated:YES];
        }
            break;
        case 4:
        {
            NSLog(@"药资讯"); //跳转到促销页面
            PromotionViewController *promotion = [[PromotionViewController alloc]init];
            promotion.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:promotion animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"搜搜");
    
}

#pragma mark - 活动专区模块点击

- (void)activityButtonClick:(NSInteger)index {
    MedicineDetailViewController *VC = [[MedicineDetailViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    NSDictionary *model = self.activeArray[index];
    VC.goodsID = model[@"GoodsID"];
    VC.provider = model[@"provider"];
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark - 推荐品种模块点击

- (void)recommendButtonClick:(NSInteger)index {
    MedicineDetailViewController *VC = [[MedicineDetailViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    NSDictionary *model = self.recommendArray[index];
    VC.goodsID = model[@"GoodsID"];
    VC.provider = model[@"provider"];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 接口
- (void)handleDate {
    
    /**
     参数说明
     param UserID 用户id 首页没登录传0
     param Opcode 内容(1. 头部三张大图, 2, 活动专区, 3, 推荐内容)
     */
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];
    if ([AnimaDefaultUtil isNotNull:model.P_LSM]) {
            [pargrams setObject:model.P_LSM forKey:@"UserID"];
    } else {
            [pargrams setObject:@"0" forKey:@"UserID"];
    }
    NSLog(@"参数-- pargrams:%@",pargrams);
    [BaseApi getMenthodWithUrl:GetHomeInfo block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            if (self.bannerArray.count == 0) {
                for (NSDictionary *tempDic in [NSMutableArray arrayWithArray:dict[@"data"][@"1"]]) {
                    [self.bannerArray addObject:[tempDic objectForKey:@"goodspic"]];
                }
            }
            if (self.activeArray.count == 0) {
                self.activeArray = [NSMutableArray arrayWithArray:dict[@"data"][@"2"]];
            }
            if (self.recommendArray.count == 0) {
                self.recommendArray = [NSMutableArray arrayWithArray:dict[@"data"][@"3"]];
            }
        }else{
            NSLog(@"error:%@",error);
        }
        [self updateData];
    } dic:pargrams noNetWork:nil];
}
-(void)updateData{
    [self.tableView reloadData];
    if (self.isCreate) {
        
    }else{
        self.isCreate = YES;
        [self createAdScrollView];
    }
}



@end
