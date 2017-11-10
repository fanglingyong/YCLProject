//
//  ShoppingCartCell.m
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartCell.h"

@interface ShoppingCartCell()

@property(nonatomic, strong)UIImageView *selectImage; //选择小图标

@property(nonatomic, strong)UIImageView *medicineImageView; //药品图片
@property(nonatomic, strong)UILabel *medicineNameLabel;  //名称
@property(nonatomic, strong)UILabel *companyLabel; // 公司
@property(nonatomic, strong)UILabel *specificationLabel; // 规格
@property(nonatomic, strong)UILabel *validityPeriodLabel; // 有效期
@property(nonatomic, strong)UILabel *priceLabel;   //价格

@property(nonatomic, strong)UILabel *priceMeterLabel;   //价格小计
@property(nonatomic, strong)UILabel *integralMeterLabel;   //价格小计

@property(nonatomic, strong)UIButton *subtractionBtn; // 减
@property(nonatomic, strong)UIButton *additionBtn;    // 加
@property(nonatomic, strong)UILabel *countLabel;   //个数
@property(nonatomic, strong)UIImageView *lineView;

@end

@implementation ShoppingCartCell

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
        [self footerView];
        [self selectImage];
        [self medicineImageView];
        [self medicineNameLabel];
        [self companyLabel];
        [self specificationLabel];
        [self validityPeriodLabel];
        [self priceLabel];
        
        [self priceMeterLabel];
        [self integralMeterLabel];
        [self subtractionBtn];
        [self additionBtn];
        [self countLabel];

        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素

- (UIView *)footerView {
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, HeightXiShu(120), kScreenWidth, HeightXiShu(50))];
        footerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:footerView];
        _footerView = footerView;
    }
    return _footerView;
}
- (UIImageView *)selectImage{
    if(!_selectImage){
        UIImageView *selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(35), WidthXiShu(18), HeightXiShu(18))];
        selectImage.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        selectImage.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:selectImage];
        _selectImage = selectImage;
    }
    return _selectImage;
}

- (UIImageView *)medicineImageView{
    if(!_medicineImageView){
        UIImageView *medicineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(32), HeightXiShu(9), WidthXiShu(80), HeightXiShu(80))];
        medicineImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:medicineImageView];
        _medicineImageView = medicineImageView;
    }
    return _medicineImageView;
}

-(UILabel *)medicineNameLabel{
    if(!_medicineNameLabel){
        UILabel *medicineNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(5), kScreenWidth - WidthXiShu(125), HeightXiShu(20))];
        medicineNameLabel.text = @"阿司匹林肠溶片 100mg * 30片";
        medicineNameLabel.font = HEITI(HeightXiShu(13));
        medicineNameLabel.textColor = TitleColor;
        [self.contentView addSubview:medicineNameLabel];
        _medicineNameLabel = medicineNameLabel;
    }
    return _medicineNameLabel;
}

-(UILabel *)companyLabel{
    if(!_companyLabel){
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(27), kScreenWidth - WidthXiShu(125), HeightXiShu(20))];
        companyLabel.text = @"拜耳中医保健有限公司";
        companyLabel.font = HEITI(HeightXiShu(13));
        companyLabel.textColor = TitleColor;
        [self.contentView addSubview:companyLabel];
        _companyLabel = companyLabel;
    }
    return _companyLabel;
}

-(UILabel *)specificationLabel{
    if(!_specificationLabel){
        UILabel *specificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(47), kScreenWidth - WidthXiShu(125), HeightXiShu(15))];
        specificationLabel.text = @"规格: 100ml*30片";
        specificationLabel.font = HEITI(HeightXiShu(13));
        specificationLabel.textColor = TitleColor;
        [self.contentView addSubview:specificationLabel];
        _specificationLabel = specificationLabel;
    }
    return _specificationLabel;
}

-(UILabel *)validityPeriodLabel{
    if(!_validityPeriodLabel){
        UILabel *validityPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(62), kScreenWidth - WidthXiShu(125), HeightXiShu(15))];
        validityPeriodLabel.text = @"效期: 2019-7-28";
        validityPeriodLabel.font = HEITI(HeightXiShu(13));
        validityPeriodLabel.textColor = TitleColor;
        [self.contentView addSubview:validityPeriodLabel];
        _validityPeriodLabel = validityPeriodLabel;
    }
    return _validityPeriodLabel;
}


-(UILabel *)priceLabel{
    if(!_priceLabel){
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(80), kScreenWidth - WidthXiShu(125), HeightXiShu(25))];
        priceLabel.text = @"￥6.39";
        priceLabel.font = HEITI(HeightXiShu(20));
        priceLabel.textColor = AllRedColor;
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}


-(UILabel *)priceMeterLabel{
    if(!_priceMeterLabel){
        UILabel *priceMeterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), 0, WidthXiShu(160), HeightXiShu(20))];
        priceMeterLabel.text = @"价格小计 ￥14.29";
        priceMeterLabel.font = HEITI(HeightXiShu(13));
        priceMeterLabel.textColor = TitleColor;
        [self.footerView addSubview:priceMeterLabel];
        _priceMeterLabel = priceMeterLabel;
    }
    return _priceMeterLabel;
}

-(UILabel *)integralMeterLabel{
    if(!_integralMeterLabel){
        UILabel *integralMeterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(20), WidthXiShu(180), HeightXiShu(20))];
        integralMeterLabel.text = @"积分小计 ￥1.429";
        integralMeterLabel.font = HEITI(HeightXiShu(13));
        integralMeterLabel.textColor = TitleColor;
        [self.footerView addSubview:integralMeterLabel];
        _integralMeterLabel = integralMeterLabel;
    }
    return _integralMeterLabel;
}

- (UIButton *)subtractionBtn {
    if (!_subtractionBtn) {
        UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subtractionBtn.layer.masksToBounds = YES;
        subtractionBtn.layer.cornerRadius = WidthXiShu(4);
        subtractionBtn.layer.borderColor = TitleColor.CGColor;
        subtractionBtn.layer.borderWidth = HeightXiShu(.5);
        subtractionBtn.frame = CGRectMake(WidthXiShu(245), HeightXiShu(80), WidthXiShu(30), HeightXiShu(30));
        [subtractionBtn addTarget:self action:@selector(subtractionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [subtractionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [subtractionBtn setTitle:@"-" forState:UIControlStateNormal];
        [self.contentView addSubview:subtractionBtn];
        _subtractionBtn = subtractionBtn;
    }
    return _subtractionBtn;
}

- (UIButton *)additionBtn {
    if (!_additionBtn) {
        UIButton *additionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        additionBtn.layer.cornerRadius = WidthXiShu(4);
        additionBtn.layer.borderColor = TitleColor.CGColor;
        additionBtn.layer.borderWidth = HeightXiShu(.5);
        additionBtn.frame = CGRectMake(WidthXiShu(314), HeightXiShu(80), WidthXiShu(30), HeightXiShu(30));
        [additionBtn addTarget:self action:@selector(additionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [additionBtn setTitle:@"+" forState:UIControlStateNormal];
        [additionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.contentView addSubview:additionBtn];
        _additionBtn = additionBtn;
    }
    return _additionBtn;
    
}

-(UILabel *)countLabel{
    if(!_countLabel){
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(277), HeightXiShu(80), HeightXiShu(35), HeightXiShu(30))];
        countLabel.layer.borderColor = TitleColor.CGColor;
        countLabel.layer.borderWidth = HeightXiShu(.5);
        countLabel.text = @"1";
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = HEITI(HeightXiShu(12));
        countLabel.textColor = TitleColor;
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
    }
    return _countLabel;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(169), kScreenWidth, .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}
#pragma mark - 事件
- (void)subtractionBtnClick:(UIButton *)sender {
    
}

- (void)additionBtnClick:(UIButton *)sender {
    
}

#pragma mark - setter

- (void)setModel:(ShoppingCartModel *)model {
    
}

@end
