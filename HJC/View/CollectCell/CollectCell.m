//
//  CollectCell.m
//  HJC
//
//  Created by zhifu360 on 2017/12/5.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "CollectCell.h"

@interface CollectCell()

@property(nonatomic, strong)UIImageView *promotionsImg; //左上角小图标
@property(nonatomic,strong)UIImageView *medicineImg;

@property(nonatomic,strong)UILabel *medicineNameLb;  //名称
@property(nonatomic,strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商

@property(nonatomic,strong)UIImageView *integralImg;  //积分图标
@property(nonatomic,strong)UILabel *priceLb;   //价格
@property(nonatomic,strong)UIImageView *deleImg;  //删除图标
@property(nonatomic,strong)UIButton *deleBtn;//删除按钮
@property(nonatomic,strong)UIImageView *footerLine;

@end

@implementation CollectCell

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
        
        [self medicineNameLb];
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];
        
        [self integralImg];
        [self priceLb];
        [self deleImg];
        [self deleBtn];
        [self footerLine];
    }
    return self;
}

#pragma mark - 页面元素

-(UIImageView *)promotionsImg{
    if(!_promotionsImg){
        UIImageView *promotionsImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(10), WidthXiShu(18), HeightXiShu(18))];
        promotionsImg.image = [GetImagePath getImagePath:@"procurePromo"];
        [self.contentView addSubview:promotionsImg];
        _promotionsImg = promotionsImg;
    }
    return _promotionsImg;
}

-(UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(10), WidthXiShu(80), HeightXiShu(80))];
        medicineImg.layer.masksToBounds = YES;
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.image = [UIImage imageNamed:@"default"];
        [self.contentView addSubview:medicineImg];
        _medicineImg = medicineImg;
    }
    return _medicineImg;
}

-(UILabel *)medicineNameLb{
    if(!_medicineNameLb){
        UILabel *medicineNameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(5), WidthXiShu(180), HeightXiShu(25))];
        medicineNameLb.text = @"阿司匹林肠溶片... ...";
        medicineNameLb.font = HEITI(HeightXiShu(15));
        medicineNameLb.textColor = BlackColor;
        [self.contentView addSubview:medicineNameLb];
        _medicineNameLb = medicineNameLb;
    }
    return _medicineNameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(30), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        specificationLb.text = @"规格: 40mg*7s";
        specificationLb.font = HEITI(HeightXiShu(11));
        specificationLb.textColor = TitleColor;
        [self.contentView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}

-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(50), WidthXiShu(200), HeightXiShu(20))];
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
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(70), WidthXiShu(200), HeightXiShu(20))];
        suppliersLb.text = @"供应商: 华东医药股份有限公司";
        suppliersLb.font = HEITI(HeightXiShu(11));
        suppliersLb.textColor = TitleColor;
        [self.contentView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}

-(UIImageView *)integralImg{
    if(!_integralImg){
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(29), WidthXiShu(16), HeightXiShu(16))];
        integralImg.image = [GetImagePath getImagePath:@"procureIntegral"];
        [self.contentView addSubview:integralImg];
        _integralImg = integralImg;
    }
    return _integralImg;
}


-(UILabel *)priceLb{
    if(!_priceLb){
        UILabel *priceLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(80), HeightXiShu(50), WidthXiShu(80), HeightXiShu(20))];
        priceLb.text = @"$14.29/盒";
        priceLb.font = HEITI(HeightXiShu(14));
        priceLb.textColor = TitleColor;
        [self.contentView addSubview:priceLb];
        _priceLb = priceLb;
    }
    return _priceLb;
}

-(UIImageView *)deleImg{
    if(!_deleImg){
        UIImageView *deleImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(70), WidthXiShu(16), HeightXiShu(16))];
        deleImg.image = [GetImagePath getImagePath:@"delete"];
        [self.contentView addSubview:deleImg];
        _deleImg = deleImg;
    }
    return _deleImg;
}
-(UIButton*)deleBtn{
    if (!_deleBtn) {
        UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleBtn.frame = _deleImg.frame;
        [deleBtn addTarget:self action:@selector(deleteCollect) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleBtn];
        _deleBtn = deleBtn;
    }
    return _deleBtn;
}
- (UIImageView *)footerLine{
    if(!_footerLine){
        UIImageView *footerLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(99), kScreenWidth, .5)];
        footerLine.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:footerLine];
        _footerLine = footerLine;
    }
    return _footerLine;
}

#pragma mark - setter

- (void)setModel:(CollectModel *)model {
    _model = model;
    [_medicineImg sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",SmallPic,model.goodspic] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"default"]];
    _medicineNameLb.text = model.goodsname;
    _specificationLb.text = [NSString stringWithFormat:@"规格:%@",model.Spec];
    _produceAreaLb.text = [NSString stringWithFormat:@"产地:%@",model.CorpName];
    _suppliersLb.text = [NSString stringWithFormat:@"供应商:%@",model.producer];
    _priceLb.text = [NSString stringWithFormat:@"￥%@/%@",[model.asprice momeyString],model.useunit];   //价格
    
}
-(void)deleteCollect{
    if (self.delegate && [self.delegate respondsToSelector: @selector(deleteCollectAction:)]) {
        [self.delegate deleteCollectAction:_thisRow];
    }
}

@end
