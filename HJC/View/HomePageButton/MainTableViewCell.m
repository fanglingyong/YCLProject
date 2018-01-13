
//
//  MainTableViewCell.m
//  HJC
//
//  Created by zhifu360 on 2018/1/11.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "MainTableViewCell.h"

@interface ActivityZoneCell()
@property (nonatomic, retain)UIScrollView *scrollView;
@end

@implementation ActivityZoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpContentView];
    }
    return self;
}

#pragma mark - 页面元素
- (void)setUpContentView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(150))];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(WidthXiShu(95) * 6 + WidthXiShu(5), 0);
    [self.contentView addSubview:self.scrollView];
    
    for (int i = 0; i < 6; i++) {
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, 0, WidthXiShu(90), HeightXiShu(90))];
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.layer.masksToBounds = YES;
        medicineImg.image = [UIImage imageNamed:@"sysIcon3.jpg"];
        [self.scrollView addSubview:medicineImg];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, HeightXiShu(90), WidthXiShu(90), HeightXiShu(30))];
        label.text = @"泮托拉错那苍茸胶囊(泮立苏)";
        label.textColor = TitleColor;
        label.font = HEITI(HeightXiShu(10));
        label.numberOfLines = 2;
        [self.scrollView addSubview:label];

        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, HeightXiShu(125), WidthXiShu(90), HeightXiShu(20))];
        priceLabel.text = @"$43.00/盒";
        priceLabel.textColor = [UIColor blueColor];
        priceLabel.textColor = TitleColor;
        priceLabel.font = HEITI(HeightXiShu(10));
        [self.scrollView addSubview:priceLabel];
        
    }
    
}

@end


@implementation RecommendVarietiesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpContentView];
    }
    return self;
}

#pragma mark - 页面元素
- (void)setUpContentView {
  
    CGFloat width = (kScreenWidth - WidthXiShu(20) * 3) / 2;
    CGFloat height = HeightXiShu(155);
    for (int i = 0; i < 8; i++) {
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(5) + HeightXiShu(210) * (i / 2), width, height)];
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.layer.masksToBounds = YES;
        medicineImg.image = [UIImage imageNamed:@"sysIcon3.jpg"];
        [self.contentView addSubview:medicineImg];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(165) + HeightXiShu(210) * (i / 2), width, HeightXiShu(15))];
        label.text = @"泮托拉错那苍茸胶囊(泮立苏)";
        label.textColor = TitleColor;
        label.font = HEITI(HeightXiShu(10));
        [self.contentView addSubview:label];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(180) + HeightXiShu(210) * (i / 2), width, HeightXiShu(15))];
        priceLabel.text = @"$43.00/盒";
        priceLabel.textColor = [UIColor blueColor];
        priceLabel.textColor = TitleColor;
        priceLabel.font = HEITI(HeightXiShu(10));
        [self.contentView addSubview:priceLabel];
        
    }
    
}

@end

