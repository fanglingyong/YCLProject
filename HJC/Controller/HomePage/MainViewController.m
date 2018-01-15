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
@interface MainViewController ()<MainButtonCellDelegate>

@property(nonatomic,strong)NSMutableArray *controllersArr;

@property (nonatomic, retain)UIView *headerView;
@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *bannerArray;
@property(nonatomic, retain)NSMutableArray *activeArray;
@property(nonatomic, retain)NSMutableArray *recommendArray;

@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bannerArray = [NSMutableArray array];
        self.activeArray = [NSMutableArray array];
        self.recommendArray = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    
    [self.tableView setMinY:0 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self handleDate];
}
#pragma mark - 页面元素

- (void)createAdScrollView {
    
//    NSLog(@"%@", self.bannerArray);
    
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
//    NSLog(@"创建banner");
    
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.adScrollView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(175) - HeightXiShu(15), WidthXiShu(25), HeightXiShu(15))];
    self.pageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    
    if (self.bannerArray.count == 1) {
        self.pageControl.pageIndicatorTintColor = [UIColor clearColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    } else if (self.bannerArray.count > 1) {
        self.pageControl.pageIndicatorTintColor = [UIColor brownColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    
    [self.adScrollView addSubview:self.pageControl];
    [self createBannerImages];
    
}

-(void)createBannerImages {
    
    if (self.bannerArray.count != 0) {
        
        NSLog(@"%@", self.bannerArray);
//        NSLog(@"创建banner图片");
        
        __weak typeof(MainViewController) *weakSelf = self;
        self.pageControl.numberOfPages = self.bannerArray.count;
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(175))];
            NSString *url = weakSelf.bannerArray[pageIndex];
//            NSLog(@"%@", url);
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", HomePic, url]]];
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
            dateLabel.text = @"活动专区";
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

            if (self.activeArray.count > 0) {
                [cell setDate:self.activeArray];
            }
            return cell;
        }

    } else {
        if (indexPath.row == 0) {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(5), WidthXiShu(150), HeightXiShu(25))];
            dateLabel.text = @"推荐品种";
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
            NSLog(@"化学药");
        }
            break;
        case 1:
        {
            NSLog(@"中成药");
        }
            break;
        case 2:
        {
            NSLog(@"保健品");
        }
            break;
        case 3:
        {
            NSLog(@"积分");
        }
            break;
        case 4:
        {
            NSLog(@"促销");
        }
            break;
        default:
            break;
    }
}
#pragma mark - 接口
- (void)handleDate {
    
    /**
     参数说明
     
     @param UserID 用户id 首页没登录传0
     @param Opcode 内容(1. 头部三张大图, 2, 活动专区, 3, 推荐内容)
     */
    NSMutableDictionary * pargrams = [NSMutableDictionary dictionary];
//    [pargrams setObject:@"0" forKey:@"UserID"];
    NSLog(@"参数-- pargrams:%@",pargrams);
    NSString *postUrl = @"";
    if ([UserModel getUserModel].P_LSM.length > 0) {
        postUrl = [NSString stringWithFormat:@"%@?UserID=%@", postUrl, [UserModel getUserModel].P_LSM];
    } else {
        postUrl = [NSString stringWithFormat:@"%@?UserID=0", GetHomeInfo];
    }
    [BaseApi getMenthodWithUrl:postUrl block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            NSLog(@"success:%@",dict[@"data"]);
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
        NSLog(@"activeArray%@", self.activeArray);
        NSLog(@"recommendArray%@", self.recommendArray);

        [self createAdScrollView];
        [self.tableView reloadData];
    } dic:pargrams noNetWork:nil];
}
            



@end
