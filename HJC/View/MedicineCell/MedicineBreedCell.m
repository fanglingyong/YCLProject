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
@property(nonatomic,strong)UILabel *companyLabel; // 公司
@property(nonatomic,strong)UILabel *priceLabel;   //价格
@property(nonatomic,strong)UILabel *integralLabel;  //积分
@property(nonatomic,strong)UILabel *countLabel;  //积分

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
        [self companyLabel];
        [self priceLabel];
        [self integralLabel];
        [self countLabel];
        
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

-(UILabel *)companyLabel{
    if(!_companyLabel){
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(35), kScreenWidth - WidthXiShu(120), HeightXiShu(30))];
        companyLabel.text = @"";
        companyLabel.font = HEITI(HeightXiShu(13));
        companyLabel.textColor = TitleColor;
        [self.contentView addSubview:companyLabel];
        _companyLabel = companyLabel;
    }
    return _companyLabel;
}

-(UILabel *)priceLabel{
    if(!_priceLabel){
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(65), WidthXiShu(75), HeightXiShu(20))];
        priceLabel.text = @"$6.39";
        priceLabel.font = HEITI(HeightXiShu(14));
        priceLabel.textColor = AllRedColor;
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}

-(UILabel *)integralLabel{
    if(!_integralLabel){
        UILabel *integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(85), WidthXiShu(52), HeightXiShu(25))];
        integralLabel.text = @"积2分";
        integralLabel.textAlignment = NSTextAlignmentCenter;
        integralLabel.font = HEITI(HeightXiShu(12));
        integralLabel.backgroundColor = [UIColor orangeColor];
        integralLabel.textColor = [UIColor whiteColor];
        integralLabel.layer.masksToBounds = YES;
        integralLabel.layer.cornerRadius = HeightXiShu(4);
        [self.contentView addSubview:integralLabel];
        _integralLabel = integralLabel;
    }
    return _integralLabel;
}


-(UILabel *)countLabel{
    if(!_countLabel){
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(10), HeightXiShu(120), kScreenWidth - HeightXiShu(120), HeightXiShu(25))];
        countLabel.text = @"已销售1887盒";
        countLabel.font = HEITI(HeightXiShu(14));
        countLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
    }
    return _countLabel;
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
