//
//  ProcurementCell.m
//  HJC
//
//  Created by zhifu360 on 2017/12/4.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ProcurementCell.h"

@interface ProcurementCell()

@property(nonatomic, strong)UIImageView *promotionsImg; //左上角小图标
@property(nonatomic, strong)UIImageView *medicineImg; //药品图片
@property(nonatomic, strong)UILabel *nameLb;  //名称
@property(nonatomic, strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商

@property(nonatomic, strong)UILabel *priceLb;   //价格
@property(nonatomic, strong)UIImageView *integralImg; //积分图片

@property(nonatomic, strong)UIButton *subtractionBtn; // 减
@property(nonatomic, strong)UIButton *additionBtn;    // 加
@property(nonatomic, strong)UILabel *countLabel;   //个数
@property(nonatomic, strong)UIImageView *shoppCartImg; //积分图片

@property(nonatomic, strong)UIImageView *lineView;

@end

@implementation ProcurementCell

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
        [self medicineImg];
        [self promotionsImg];
        [self nameLb];
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];
        
        [self priceLb];
        [self integralImg];
        
        [self subtractionBtn];
        [self additionBtn];
        [self countLabel];
        [self shoppCartImg];
        
        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素

- (UIImageView *)promotionsImg{
    if(!_promotionsImg){
        UIImageView *promotionsImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(25), HeightXiShu(25))];
        promotionsImg.image = [GetImagePath getImagePath:@"procurePromo"];
        [self.contentView addSubview:promotionsImg];
        _promotionsImg = promotionsImg;
    }
    return _promotionsImg;
}

- (UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(115), HeightXiShu(115))];
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.layer.masksToBounds = YES;
        medicineImg.image = [UIImage imageNamed:@"sysIcon3.jpg"];
        [self.contentView addSubview:medicineImg];
        _medicineImg = medicineImg;
    }
    return _medicineImg;
}

-(UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(5), WidthXiShu(240), HeightXiShu(30))];
        nameLb.text = @"阿司匹林肠溶片阿司匹林肠溶片";
        nameLb.font = HEITI(HeightXiShu(15));
        nameLb.textColor = BlackColor;
        [self.contentView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(35), WidthXiShu(240), HeightXiShu(20))];
        specificationLb.text = @"规格: 100ml*30片";
        specificationLb.font = HEITI(HeightXiShu(11));
        specificationLb.textColor = TitleColor;
        [self.contentView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}


-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(55), WidthXiShu(240), HeightXiShu(20))];
        produceAreaLb.text = @"产地: 杭州中美华东制药有限公司";
        produceAreaLb.font = HEITI(HeightXiShu(11));
        produceAreaLb.textColor = TitleColor;
        [self.contentView addSubview:produceAreaLb];
        _produceAreaLb = produceAreaLb;
    }
    return _produceAreaLb;
}

-(UILabel *)suppliersLb{
    if(!_suppliersLb){
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(75), kScreenWidth - WidthXiShu(125), HeightXiShu(20))];
        suppliersLb.text = @"供应商: 华东医药股份有限公司";
        suppliersLb.font = HEITI(HeightXiShu(11));
        suppliersLb.textColor = TitleColor;
        [self.contentView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}

-(UILabel *)priceLb{
    if(!_priceLb){
        UILabel *priceLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(100), WidthXiShu(100), HeightXiShu(25))];
        priceLb.text = @"￥43.00/盒";
        priceLb.font = HEITI(HeightXiShu(17));
        priceLb.textColor = [UIColor blueColor];
        [self.contentView addSubview:priceLb];
        _priceLb = priceLb;
    }
    return _priceLb;
}

- (UIImageView *)integralImg{
    if(!_integralImg){
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(117), HeightXiShu(100), WidthXiShu(23), HeightXiShu(23))];
        integralImg.image = [GetImagePath getImagePath:@"procureIntegral"];
        [self.contentView addSubview:integralImg];
        _integralImg = integralImg;
    }
    return _integralImg;
}

- (UIButton *)subtractionBtn {
    if (!_subtractionBtn) {
        UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subtractionBtn.layer.masksToBounds = YES;
        subtractionBtn.layer.cornerRadius = WidthXiShu(4);
        subtractionBtn.layer.borderColor = TitleColor.CGColor;
        subtractionBtn.layer.borderWidth = HeightXiShu(.5);
        subtractionBtn.frame = CGRectMake(self.medicineImg.maxX + WidthXiShu(147), HeightXiShu(105), WidthXiShu(15), HeightXiShu(15));
        [subtractionBtn addTarget:self action:@selector(subtractionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [subtractionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [subtractionBtn setBackgroundImage:[GetImagePath getImagePath:@"reduce_S"] forState:UIControlStateNormal];
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
        additionBtn.frame = CGRectMake(self.medicineImg.maxX + WidthXiShu(190), HeightXiShu(105), WidthXiShu(15), HeightXiShu(15));
        [additionBtn addTarget:self action:@selector(additionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [additionBtn setBackgroundImage:[GetImagePath getImagePath:@"add_S"] forState:UIControlStateNormal];
        [additionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.contentView addSubview:additionBtn];
        _additionBtn = additionBtn;
    }
    return _additionBtn;
    
}

-(UILabel *)countLabel{
    if(!_countLabel){
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(164), HeightXiShu(105), HeightXiShu(25), HeightXiShu(15))];
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

- (UIImageView *)shoppCartImg{
    if(!_shoppCartImg){
        UIImageView *shoppCartImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(210), HeightXiShu(95), WidthXiShu(30), HeightXiShu(30))];
        shoppCartImg.image = [GetImagePath getImagePath:@"procureCart"];
        [self.contentView addSubview:shoppCartImg];
        _shoppCartImg = shoppCartImg;
    }
    return _shoppCartImg;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(135), kScreenWidth, .5)];
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

- (void)setModel:(ProcurementModel *)model {
    
}

@end
