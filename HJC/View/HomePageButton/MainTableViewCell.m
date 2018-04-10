
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
        [self setDate:self.array];
    }
    return self;
}

#pragma mark - 页面元素
- (void)setDate:(NSMutableArray *)array {
    if (array.count > 0) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeightXiShu(150))];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize = CGSizeMake(WidthXiShu(95) * array.count + WidthXiShu(5), 0);
        [self.contentView addSubview:self.scrollView];
        
        for (int i = 0; i < array.count; i++) {
            
            UIButton *targetButton = [UIButton buttonWithType:UIButtonTypeCustom];
            targetButton.frame = CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, 0, WidthXiShu(90), HeightXiShu(90));
            targetButton.backgroundColor = [UIColor clearColor];
            targetButton.tag = i;
            [targetButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:targetButton];

            UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, 0, WidthXiShu(90), HeightXiShu(90))];
            medicineImg.layer.borderWidth = .5;
            medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
            medicineImg.layer.masksToBounds = YES;
            
            [medicineImg sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@", SmallPic, [array[i] objectForKey:@"goodspic"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"default"]];
            [self.scrollView addSubview:medicineImg];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, HeightXiShu(90), WidthXiShu(90), HeightXiShu(30))];
            label.text = [array[i] objectForKey:@"goodsname"];
            label.textColor = TitleColor;
            label.font = HEITI(HeightXiShu(10));
            label.numberOfLines = 2;
            [self.scrollView addSubview:label];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5) + (WidthXiShu(90) + WidthXiShu(5)) * i, HeightXiShu(125), WidthXiShu(90), HeightXiShu(20))];
            
            priceLabel.text = [NSString stringWithFormat:@"%@/%@", [array[i] objectForKey:@"Spec"], [array[i] objectForKey:@"useunit"]];
            priceLabel.textColor = [UIColor blueColor];
            priceLabel.textColor = TitleColor;
            priceLabel.font = HEITI(HeightXiShu(10));
            [self.scrollView addSubview:priceLabel];
        }
    }
}

-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(activityButtonClick:)]){
        [self.delegate activityButtonClick:button.tag];
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
        [self setDate:self.array];
    }
    return self;
}

#pragma mark - 页面元素
- (void)setDate:(NSMutableArray *)array {

    if (array.count > 0) {
        CGFloat width = (kScreenWidth - WidthXiShu(20) * 3) / 2;
        CGFloat height = HeightXiShu(155);
        for (int i = 0; i < array.count; i++) {
            
            UIButton *targetButton = [UIButton buttonWithType:UIButtonTypeCustom];
            targetButton.frame = CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(5) + HeightXiShu(210) * (i / 2), width, height);
            targetButton.backgroundColor = [UIColor clearColor];
            targetButton.tag = i;
            [targetButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:targetButton];
            
            UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(5) + HeightXiShu(210) * (i / 2), width, height)];
            medicineImg.layer.borderWidth = .5;
            medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
            medicineImg.layer.masksToBounds = YES;
            [medicineImg sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@", SmallPic, [array[i] objectForKey:@"goodspic"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"default"]];
            [self.contentView addSubview:medicineImg];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(165) + HeightXiShu(210) * (i / 2), width, HeightXiShu(15))];
            label.text = [array[i] objectForKey:@"goodsname"];
            label.textColor = TitleColor;
            label.font = HEITI(HeightXiShu(10));
            [self.contentView addSubview:label];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20) + (WidthXiShu(20) + width) * (i % 2), HeightXiShu(180) + HeightXiShu(210) * (i / 2), width, HeightXiShu(15))];
            priceLabel.text = [NSString stringWithFormat:@"%@/%@", [array[i] objectForKey:@"Spec"], [array[i] objectForKey:@"useunit"]];
            
            priceLabel.textColor = [UIColor blueColor];
            priceLabel.textColor = TitleColor;
            priceLabel.font = HEITI(HeightXiShu(10));
            [self.contentView addSubview:priceLabel];
            
        }
    }
    
}

-(void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(recommendButtonClick:)]){
        [self.delegate recommendButtonClick:button.tag];
    }
}

@end

