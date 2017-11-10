//
//  MedicineDetailCell.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailCell.h"
@interface MedicineDetailCell()

@property(nonatomic,strong)UILabel *nameLabel;  //名称
@property(nonatomic,strong)UILabel *specificationsLabel; // 规格包装
@property(nonatomic,strong)UILabel *productionLabel;   //生产厂家
@property(nonatomic,strong)UILabel *approveLabel;  //批准文号
@property(nonatomic,strong)UILabel *validityLabel;  //有效期


@end

@implementation MedicineDetailCell

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
        
        [self nameLabel];
        [self specificationsLabel];
        [self productionLabel];
        [self approveLabel];
        [self validityLabel];
        
    }
    return self;
}

#pragma mark - 页面元素

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(5), kScreenWidth - WidthXiShu(10), HeightXiShu(20))];
        nameLabel.text = @"商品名称:  999感冒灵颗粒 10g*9袋";
        nameLabel.font = HEITI(HeightXiShu(13));
        nameLabel.textColor = TitleColor;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)specificationsLabel{
    if(!_specificationsLabel){
        UILabel *specificationsLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(25), kScreenWidth - WidthXiShu(10), HeightXiShu(20))];
        specificationsLabel.text = @"规格包装:  10g*9袋/盒";
        specificationsLabel.font = HEITI(HeightXiShu(13));
        specificationsLabel.textColor = TitleColor;
        [self.contentView addSubview:specificationsLabel];
        _specificationsLabel = specificationsLabel;
    }
    return _specificationsLabel;
}

-(UILabel *)productionLabel{
    if(!_productionLabel){
        UILabel *productionLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(45), kScreenWidth - WidthXiShu(10), HeightXiShu(20))];
        productionLabel.text = @"生产厂家:  华润三九医药股份有限公司";
        productionLabel.font = HEITI(HeightXiShu(13));
        productionLabel.textColor = TitleColor;
        [self.contentView addSubview:productionLabel];
        _productionLabel = productionLabel;
    }
    return _productionLabel;
}

-(UILabel *)approveLabel{
    if(!_approveLabel){
        UILabel *approveLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(65), kScreenWidth - WidthXiShu(10), HeightXiShu(20))];
        approveLabel.text = @"批准文号:  国药准字Z44445454454";
        approveLabel.font = HEITI(HeightXiShu(13));
        approveLabel.textColor = TitleColor;
        [self.contentView addSubview:approveLabel];
        _approveLabel = approveLabel;
    }
    return _approveLabel;
}

-(UILabel *)validityLabel{
    if(!_validityLabel){
        UILabel *validityLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(85), kScreenWidth - WidthXiShu(10), HeightXiShu(20))];
        validityLabel.text = @"有效期至:  2019-07-02";
        validityLabel.font = HEITI(HeightXiShu(13));
        validityLabel.textColor = TitleColor;
        [self.contentView addSubview:validityLabel];
        _validityLabel = validityLabel;
    }
    return _validityLabel;
}

#pragma mark - setter

- (void)setModel:(MedicineDetailModel *)model{
    
}

@end
