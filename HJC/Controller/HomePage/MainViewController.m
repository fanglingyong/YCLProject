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
@interface MainViewController ()<MainButtonCellDelegate>

@property(nonatomic,strong)NSMutableArray *controllersArr;

@property (nonatomic, retain)UIView *headerView;
@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *bannerArray;

@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bannerArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self statusBar];
    

    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-d1131eb89323cd1e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/8390198-e0efc31aa87a32fb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-a4cc27b8469fbb8e.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    
    [self.tableView setMinY:0 maxY:kScreenHeight];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self createAdScrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - 页面元素

- (void)createAdScrollView {
    
//    NSLog(@"%@", self.bannerArray);
    
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(180)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(180)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
//    NSLog(@"创建banner");
    
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.adScrollView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - WidthXiShu(80), HeightXiShu(180) - HeightXiShu(30), WidthXiShu(160), HeightXiShu(20))];
    
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
        
//        NSLog(@"%@", self.bannerArray);
//        NSLog(@"创建banner图片");
        
        __weak typeof(MainViewController) *weakSelf = self;
        self.pageControl.numberOfPages = self.bannerArray.count;
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(180))];
            NSString *url = weakSelf.bannerArray[pageIndex];
//            NSLog(@"%@", url);
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

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(180))];
        headerView.backgroundColor = [UIColor whiteColor];
        
        
        _headerView = headerView;
    }
    return _headerView;
}


#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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

        return HeightXiShu(180);
    }
    if (indexPath.section == 1) {

        return HeightXiShu(40);
        
    }

    return HeightXiShu(175);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* const identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
       
        MainButtonCell *mainButtonView = [[MainButtonCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(180))];
        mainButtonView.delegate = self;
        [cell.contentView addSubview:mainButtonView];
        return cell;
        
    } else if (indexPath.section == 1) {
       
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(35), HeightXiShu(20))];
        dateLabel.text = @"公告";
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = [UIColor blueColor];
        dateLabel.font = HEITI(HeightXiShu(13));
        [cell.contentView addSubview:dateLabel];
        
        
        UILabel *rearkLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(54), HeightXiShu(10), WidthXiShu(235), HeightXiShu(20))];
        rearkLabel.text = @"积分换购商品活动开始啦！";
        rearkLabel.textColor = [UIColor blueColor];
        rearkLabel.font = HEITI(HeightXiShu(13));
        [cell.contentView addSubview:rearkLabel];
        
    } else {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), 0, WidthXiShu(70), HeightXiShu(30))];
        titleLabel.text = @[@"现在抢购:", @"支付卡号:", @"支付编号:"][indexPath.row];
        titleLabel.textColor = TitleColor;
        titleLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:titleLabel];
        
        UILabel *snLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(80), 0,kScreenWidth - WidthXiShu(80), HeightXiShu(30))];
        snLabel.text = @[@"", @"7864874564649643", @"54984564954654951564"][indexPath.row];
        snLabel.textColor = TitleColor;
        snLabel.font = HEITI(HeightXiShu(14));
        [cell.contentView addSubview:snLabel];
    }
    return cell;
}
#pragma mark - 事件

#pragma - mark delegate
-(void)mainButtonClick:(NSInteger)index{
    switch (index) {
        case 0:
        {
        }
            break;
        case 1:
        {
           
        }
            break;
        case 2:
        {

        }
            break;
        case 3:
        {
            
       
            
            
            
        }
            break;
        case 4:
        {
           
            
        }
            break;
        case 5:
        {
          
            
        }
            break;
        case 6:
        {
          
            
        }
            break;
        case 7:
        {
            
            
        }
            break;
        default:
            break;
    }
}



@end
