//
//  MedicineDetailCell.m
//  HJC
//
//  Created by zhifu360 on 2017/11/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "MedicineDetailCell.h"
@interface MedicineDetailCell()

@property(nonatomic,strong)UILabel *nameLb;  //名称
@property(nonatomic,strong)UILabel *originalPriceLb;  //原价
@property(nonatomic,strong)UILabel *currentPriceLb;  //现价

@property(nonatomic,strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商

@property(nonatomic, strong)UIImageView *integralImg;   //积分图片
@property(nonatomic, strong)UILabel *integralCountLb;   //积分数量
@property(nonatomic, strong)UIButton *subtractionBtn; // 减
@property(nonatomic, strong)UIButton *additionBtn;    // 加
@property(nonatomic, strong)UILabel *countLb;   //个数



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
        self.num = 1;
        [self nameLb];
        [self originalPriceLb];
        [self currentPriceLb];
        
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];

        [self integralImg];
        [self integralCountLb];
        [self subtractionBtn];
        [self additionBtn];
        [self countLb];
    }
    return self;
}

#pragma mark - 页面元素

- (UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), 0, kScreenWidth - WidthXiShu(15), HeightXiShu(40))];
        nameLb.text = @"商品名称:999感冒灵颗粒";
        nameLb.font = HEITI(HeightXiShu(20));
        nameLb.textColor = BlackColor;
        [self.contentView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}
- (UILabel *)originalPriceLb{
    if(!_originalPriceLb){
        UILabel *originalPriceLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(40), WidthXiShu(70), HeightXiShu(25))];
        originalPriceLb.text = @"$43.00/盒";
        originalPriceLb.font = HEITI(HeightXiShu(12));
        originalPriceLb.textColor = TitleColor;
        [self.contentView addSubview:originalPriceLb];
        _originalPriceLb = originalPriceLb;
    }
    return _originalPriceLb;
}

- (UILabel *)currentPriceLb{
    if(!_currentPriceLb){
        UILabel *currentPriceLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(82), HeightXiShu(40), kScreenWidth - WidthXiShu(100), HeightXiShu(25))];
        currentPriceLb.text = @"$38.00/盒";
        currentPriceLb.font = HEITI(HeightXiShu(18));
        currentPriceLb.textColor = [UIColor colorFromHexCode:@"#f4b842"];
        [self.contentView addSubview:currentPriceLb];
        _currentPriceLb = currentPriceLb;
    }
    return _currentPriceLb;
}

- (UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(65), kScreenWidth - WidthXiShu(15), HeightXiShu(25))];
        specificationLb.text = @"规格: 10g*9袋/盒";
        specificationLb.font = HEITI(HeightXiShu(14));
        specificationLb.textColor = TitleColor;
        [self.contentView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}

- (UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(90), kScreenWidth - WidthXiShu(15), HeightXiShu(25))];
        produceAreaLb.text = @"产地: 华润三九医药股份有限公司";
        produceAreaLb.font = HEITI(HeightXiShu(14));
        produceAreaLb.textColor = TitleColor;
        [self.contentView addSubview:produceAreaLb];
        _produceAreaLb = produceAreaLb;
    }
    return _produceAreaLb;
}

- (UILabel *)suppliersLb{
    if(!_suppliersLb){
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(15), HeightXiShu(115), kScreenWidth - WidthXiShu(15), HeightXiShu(25))];
        suppliersLb.text = @"供应商: 华东医药股份有限公司";
        suppliersLb.font = HEITI(HeightXiShu(14));
        suppliersLb.textColor = TitleColor;
        [self.contentView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}

- (UIImageView *)integralImg{
    if(!_integralImg){
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(110), HeightXiShu(158), WidthXiShu(21), WidthXiShu(21))];
        integralImg.image = [GetImagePath getImagePath:@"detail_integral"];
        [self.contentView addSubview:integralImg];
        _integralImg = integralImg;
    }
    return _integralImg;
}

- (UILabel *)integralCountLb{
    if(!_integralCountLb){
        UILabel *integralCountLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(140), HeightXiShu(152), WidthXiShu(110), HeightXiShu(35))];
        integralCountLb.text = @"积分数量: 1分";
        integralCountLb.font = HEITI(HeightXiShu(14));
        integralCountLb.textColor = TitleColor;
        [self.contentView addSubview:integralCountLb];
        _integralCountLb = integralCountLb;
    }
    return _integralCountLb;
}

- (UIButton *)subtractionBtn {
    if (!_subtractionBtn) {
        UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subtractionBtn.frame = CGRectMake(WidthXiShu(258), HeightXiShu(153), WidthXiShu(25), HeightXiShu(25));
        [subtractionBtn addTarget:self action:@selector(subtractionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [subtractionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [subtractionBtn setBackgroundImage:[GetImagePath getImagePath:@"reduce_S"] forState:UIControlStateNormal];
        [self.contentView addSubview:subtractionBtn];
        
    }
    return _subtractionBtn;
}

- (UIButton *)additionBtn {
    if (!_additionBtn) {
        UIButton *additionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        additionBtn.frame = CGRectMake(WidthXiShu(326), HeightXiShu(153), WidthXiShu(25), HeightXiShu(25));
        [additionBtn addTarget:self action:@selector(additionBtnClick:) forControlEvents:UIControlEventTouchDown];
        [additionBtn setBackgroundImage:[GetImagePath getImagePath:@"add_S"] forState:UIControlStateNormal];
        [additionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.contentView addSubview:additionBtn];
        _additionBtn = additionBtn;
    }
    return _additionBtn;
    
}

- (UILabel *)countLb{
    if(!_countLb){
        UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(284), HeightXiShu(153), HeightXiShu(40), HeightXiShu(25))];
        countLb.layer.borderColor = TitleColor.CGColor;
        countLb.layer.borderWidth = HeightXiShu(.5);
        countLb.text = [NSString stringWithFormat:@"%ld",_num];
        countLb.textAlignment = NSTextAlignmentCenter;
        countLb.font = HEITI(HeightXiShu(12));
        countLb.textColor = TitleColor;
        [self.contentView addSubview:countLb];
        _countLb = countLb;
    }
    return _countLb;
}
#pragma mark - 事件
-(void)subtractionBtnClick:(UIButton *)sender{
    // 减少
    if (_num > 1) {
        _num-- ;
        _countLb.text = [NSString stringWithFormat:@"%ld",_num];
    }
}
-(void)additionBtnClick:(UIButton*)sender{
    //增加
    if (_num < 999999) {
        _num++ ;
        _countLb.text = [NSString stringWithFormat:@"%ld",_num];
    }
}

#pragma mark - setter

- (void)setModel:(MedicineDetailModel *)model{
    
    self.nameLb.text = model.GOODSNAME;
    if ([model.RETAILPRICE isEqualToString:model.PRICE]) {
        self.originalPriceLb.text = [NSString stringWithFormat:@"￥%@/%@",[model.PRICE fString],model.CALCUNIT];
        self.currentPriceLb.text = @"";// 无现价只显示一个价
    }else{
        self.originalPriceLb.attributedText = [self deleteLine:[NSString stringWithFormat:@"￥%@/%@",[model.RETAILPRICE fString],model.CALCUNIT]];//零售价
        self.currentPriceLb.text = [NSString stringWithFormat:@"￥%@/%@",[model.PRICE fString],model.CALCUNIT];//现价
    }
    self.specificationLb.text = [NSString stringWithFormat:@"规格:%@",model.SPEC];
    self.produceAreaLb.text = [NSString stringWithFormat:@"厂家:%@",model.PRODUCER];
    self.suppliersLb.text = [NSString stringWithFormat:@"供应商:%@",model.CORPNAME];
    
}
-(NSMutableAttributedString*)deleteLine:(NSString*)oldPrice{
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorFromHexCode:@"#F2A831"] range:NSMakeRange(0, length)];
    return attri;
}

@end
