//
//  MedicineDetailViewController.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailViewController.h"
#import "NavView.h"
#import "MedicineDetailCell.h"
#import "MedicineDetailModel.h"

#import "CycleScrollView.h"
#import "MerchandiseFooterButton.h"

@interface MedicineDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, MerchandiseFooterButtonDelegate>

{
    CGFloat minY;
    CGFloat maxY;
    // 是否显示底部视图，
    BOOL _isShowBottom;
}

@property(nonatomic,strong)NavView *navView;

@property (nonatomic, retain)UIView *contentView; //容器视图
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UIWebView *webView;

@property (nonatomic, retain)UIView *headerView;
@property (nonatomic, retain)UILabel *bottomLab;
@property (nonatomic, retain)UILabel *middleLab;

@property (nonatomic, retain)MerchandiseFooterButton *footerView;

@property(nonatomic)NSInteger startIndex;
@property(nonatomic,strong)NSMutableArray *modelArr;
// banner
@property(nonatomic, retain)CycleScrollView *adScrollView;
@property(nonatomic, retain)UIPageControl *pageControl;
@property(nonatomic, retain)NSMutableArray *bannerArray;
@end

@implementation MedicineDetailViewController

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
    [self statusBar];
    [self navView];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.webView];
    
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-d1131eb89323cd1e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/8390198-e0efc31aa87a32fb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    [self.bannerArray addObject:@"http://upload-images.jianshu.io/upload_images/1154433-a4cc27b8469fbb8e.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    
    [self createAdScrollView];
    [self footerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 页面元素

- (NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = 20;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"药品详情页";
        [navView.leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight * 2)];
        contentView.backgroundColor = AllBackLightGratColor;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + HeightXiShu(80)) style:UITableViewStylePlain];
        tableView.backgroundColor = AllBackLightGratColor;
        tableView.tableHeaderView = self.headerView;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setMinY:0 maxY:kScreenHeight];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (UIWebView *)webView
{
    if(!_webView){
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }
    return _webView;
}

- (UILabel *)bottomLab
{
    if (!_bottomLab)
    {
        _bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height - HeightXiShu(80), kScreenWidth, HeightXiShu(80))];
        _bottomLab.font = [UIFont systemFontOfSize:13.0f];
        _bottomLab.textAlignment = NSTextAlignmentCenter;
        _bottomLab.text = @"下拉返回中间View";
        [self.webView.scrollView addSubview:_bottomLab];
    }
    return _bottomLab;
}

- (UILabel *)middleLab
{
    if (!_middleLab)
    {
        _middleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height, kScreenWidth, HeightXiShu(80))];
        _middleLab.font = [UIFont systemFontOfSize:13.0f];
        _middleLab.textAlignment = NSTextAlignmentCenter;
        _middleLab.backgroundColor = [UIColor purpleColor];
        _middleLab.text = @"上拉显示底部View";
        _middleLab.textColor = [UIColor blackColor];
        [self.tableView addSubview:_middleLab];
    }
    return _middleLab;
}

- (void)createAdScrollView {
    
    NSLog(@"%@", self.bannerArray);
    
    if (self.bannerArray.count == 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350)) animationDuration:10000 andIsSingle:true];
    } else if (self.bannerArray.count > 1) {
        self.adScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350)) animationDuration:5 andIsSingle:false];
    } else {
        return;
    }
    NSLog(@"创建banner");
    
    self.adScrollView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.adScrollView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - WidthXiShu(80), HeightXiShu(350) - HeightXiShu(30), WidthXiShu(160), HeightXiShu(20))];
    
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
        
        __weak typeof(MedicineDetailViewController) *weakSelf = self;
        self.pageControl.numberOfPages = self.bannerArray.count;
        //给图片赋值
        self.adScrollView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350))];
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

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(350))];
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
    }
    return _headerView;
}

- (MerchandiseFooterButton *)footerView {
    if (!_footerView) {
        MerchandiseFooterButton *footerView = [[MerchandiseFooterButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - HeightXiShu(55), kScreenWidth, HeightXiShu(55))];
        footerView.delegate = self;
        footerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
    
}



#pragma mark - tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 1;
    } else {
        return 3;
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
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == self.tableView)
    {
        if (offset <= self.tableView.contentSize.height - kScreenHeight + HeightXiShu(80))
        {
            self.middleLab.text = @"释放返回中间View";
        } else
        {
            self.middleLab.text = @"上拉显示底部View";
        }
    }else
    {
        // WebView中的ScrollView
        if (offset <= -HeightXiShu(80))
        {
            self.bottomLab.text = @"释放返回中间View";
        } else
        {
            self.bottomLab.text = @"下拉返回中间View";
        }
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate)
    {
        CGFloat offset = scrollView.contentOffset.y;
        NSLog(@"----offset=%f",offset);
        if (scrollView == self.tableView)
        {
            if (offset < 0)
            {
                minY = MIN(minY, offset);
            } else {
                maxY = MAX(maxY, offset);
            }
        }
        else
        {
            minY = MIN(minY, offset);
        }
        // 滚到底部视图
        NSLog(@"----maxY=%f",maxY);
        NSLog(@"----contentSize=%f",self.tableView.contentSize.height);
        if (maxY >= self.tableView.contentSize.height - kScreenHeight + HeightXiShu(80))
        {
            NSLog(@"----%@",NSStringFromCGRect(self.contentView.frame));
            _isShowBottom = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -kScreenHeight);
            } completion:^(BOOL finished) {
                maxY = 0.0f;
                _isShowBottom = YES;
            }];
        }
        
        // 滚到中间视图
        if (minY <= -HeightXiShu(80) && _isShowBottom)
        {
            NSLog(@"----minY=%f",minY);
            NSLog(@"----%@",NSStringFromCGRect(self.contentView.frame));
            _isShowBottom = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.contentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                minY = 0.0f;
            }];
        }
        
    }
}

// 进入详情的动画
- (void)goToDetailAnimation
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _tableView.frame = CGRectMake(0, -self.contentView.bounds.size.height, kScreenWidth, self.contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


// 返回第一个界面的动画
- (void)backToFirstPageAnimation
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, self.contentView.bounds.size.height);
        _webView.frame = CGRectMake(0, _tableView.contentSize.height, kScreenWidth, kScreenHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end

