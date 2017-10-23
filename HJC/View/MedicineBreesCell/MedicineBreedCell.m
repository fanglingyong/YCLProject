//
//  MedicineBreedCell.m
//  HJC
//
//  Created by zhifu360 on 2017/10/23.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineBreedCell.h"

@interface MedicineBreedCell()
@property(nonatomic,strong)UIImageView *medicineImageView;
@property(nonatomic,strong)UILabel *medicineNameLabel;  //名称
@property(nonatomic,strong)UILabel *medicineCompanyLabel; // 公司
@property(nonatomic,strong)UILabel *medicinePriceLabel;   //价格
@property(nonatomic,strong)UILabel *medicineIntegralLabel;  //积分
@property(nonatomic,strong)UILabel *medicineCountLabel;  //积分

@property(nonatomic,strong)UIButton *addShopCartButton;  //加购物车
@property (nonatomic, retain)UIImageView *lineView;

@end

@implementation MedicineBreedCell

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

        [self medicineImageView];
        [self medicineNameLabel];
        [self medicineCompanyLabel];
        [self medicinePriceLabel];
        [self medicineIntegralLabel];
        [self medicineCountLabel];
        
        [self addShopCartButton];
        [self lineView];


    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)medicineImageView{
    if(!_medicineImageView){
        UIImageView *medicineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(100), HeightXiShu(100))];
        medicineImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:medicineImageView];
        _medicineImageView = medicineImageView;
    }
    return _medicineImageView;
}

-(UILabel *)medicineNameLabel{
    if(!_medicineNameLabel){
        UILabel *medicineNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(10), kScreenWidth - WidthXiShu(120), HeightXiShu(35))];
        medicineNameLabel.text = @"江中牌健胃消食片 100mg*30片";
        medicineNameLabel.font = HEITI(HeightXiShu(15));
        medicineNameLabel.textColor = TitleColor;
        [self.contentView addSubview:medicineNameLabel];
        _medicineNameLabel = medicineNameLabel;
    }
    return _medicineNameLabel;
}

-(UILabel *)medicineCompanyLabel{
    if(!_medicineCompanyLabel){
        UILabel *medicineCompanyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(35), kScreenWidth - WidthXiShu(120), HeightXiShu(30))];
        medicineCompanyLabel.text = @"江中药业股份有限公司";
        medicineCompanyLabel.font = HEITI(HeightXiShu(13));
        medicineCompanyLabel.textColor = TitleColor;
        [self.contentView addSubview:medicineCompanyLabel];
        _medicineCompanyLabel = medicineCompanyLabel;
    }
    return _medicineCompanyLabel;
}

-(UILabel *)medicinePriceLabel{
    if(!_medicinePriceLabel){
        UILabel *medicinePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(65), WidthXiShu(75), HeightXiShu(20))];
        medicinePriceLabel.text = @"$6.39";
        medicinePriceLabel.font = HEITI(HeightXiShu(14));
        medicinePriceLabel.textColor = AllRedColor;
        [self.contentView addSubview:medicinePriceLabel];
        _medicinePriceLabel = medicinePriceLabel;
    }
    return _medicinePriceLabel;
}

-(UILabel *)medicineIntegralLabel{
    if(!_medicineIntegralLabel){
        UILabel *medicineIntegralLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(85), WidthXiShu(52), HeightXiShu(25))];
        medicineIntegralLabel.text = @"积2分";
        medicineIntegralLabel.textAlignment = NSTextAlignmentCenter;
        medicineIntegralLabel.font = HEITI(HeightXiShu(12));
        medicineIntegralLabel.backgroundColor = [UIColor orangeColor];
        medicineIntegralLabel.textColor = [UIColor whiteColor];
        medicineIntegralLabel.layer.masksToBounds = YES;
        medicineIntegralLabel.layer.cornerRadius = HeightXiShu(4);
        [self.contentView addSubview:medicineIntegralLabel];
        _medicineIntegralLabel = medicineIntegralLabel;
    }
    return _medicineIntegralLabel;
}


-(UILabel *)medicineCountLabel{
    if(!_medicineCountLabel){
        UILabel *medicineCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(120), kScreenWidth - HeightXiShu(120), HeightXiShu(25))];
        medicineCountLabel.text = @"已销售1887盒";
        medicineCountLabel.font = HEITI(HeightXiShu(14));
        medicineCountLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:medicineCountLabel];
        _medicineCountLabel = medicineCountLabel;
    }
    return _medicineCountLabel;
}

- (UIButton *)addShopCartButton {
    
    if (!_addShopCartButton) {
        UIButton *addShopCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addShopCartButton.frame = CGRectMake(kScreenWidth - WidthXiShu(80), HeightXiShu(60), WidthXiShu(70), HeightXiShu(25));
        addShopCartButton.titleLabel.font = HEITI(HeightXiShu(14));
        [addShopCartButton setTitle:@"+购物车" forState:UIControlStateNormal];
        [addShopCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addShopCartButton addTarget:self action:@selector(addShopCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addShopCartButton.backgroundColor = NavColor;
        [self.contentView addSubview:addShopCartButton];
        _addShopCartButton = addShopCartButton;
    }
    return _addShopCartButton;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(150), kScreenWidth, .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

#pragma mark - setter

- (void)setModel:(MedicineBreesModel *)model{
    
}


- (void)addShopCartButtonClick {
    if([self.delegate respondsToSelector:@selector(addShoppingCartClick:)]){
        [self.delegate addShoppingCartClick:self.indexPath.row];
    }
}


@end
