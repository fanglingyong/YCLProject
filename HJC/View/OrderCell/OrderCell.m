//
//  OrderCell.m
//  HJC
//
//  Created by zhifu360 on 2017/11/3.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderCell.h"

@interface OrderListCell()

@property (nonatomic, retain)UIView *bgView;
@property(nonatomic,strong)UILabel *orderNumLb;
//@property(nonatomic,strong)UIImageView *headerLine;

@property(nonatomic,strong)UIImageView *medicineImg;
@property(nonatomic,strong)UILabel *medicineNameLb;  //名称
@property(nonatomic,strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商


@property(nonatomic,strong)UILabel *priceLb;   //价格
@property(nonatomic,strong)UILabel *countLb;  //数量

@property(nonatomic,strong)UIImageView *footerLine;

@property(nonatomic,strong)UILabel *orderTimeLb;  //数量
@property(nonatomic,strong)UILabel *integralLb;  //数量
@property(nonatomic,strong)UILabel *totalLb;  //数量

@end

@implementation OrderListCell

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
        [self bgView];
        [self orderNumLb];
//        [self headerLine];
        
        [self medicineImg];
        [self medicineNameLb];
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];
        
        [self priceLb];
        [self countLb];
        
        [self footerLine];
        [self orderTimeLb];
        [self integralLb];
        [self totalLb];

    }
    return self;
}

#pragma mark - 页面元素

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), kScreenWidth - WidthXiShu(20), HeightXiShu(158))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = WidthXiShu(8);
        [self.contentView addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}
-(UILabel *)orderNumLb{
    if(!_orderNumLb){
        UILabel *orderNumLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(7), 0, kScreenWidth - WidthXiShu(20) - WidthXiShu(7), HeightXiShu(30))];
        orderNumLb.text = @"订单号:2017112014250001";
        orderNumLb.font = HEITI(HeightXiShu(14));
        orderNumLb.textColor = BlackColor;
        [self.bgView addSubview:orderNumLb];
        _orderNumLb = orderNumLb;
    }
    return _orderNumLb;
}

//- (UIImageView *)headerLine{
//    if(!_headerLine){
//        UIImageView *headerLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(32), kScreenWidth - WidthXiShu(20) - WidthXiShu(20), .5)];
//        headerLine.backgroundColor = AllLightGrayColor;
//        [self.bgView addSubview:headerLine];
//        _headerLine = headerLine;
//    }
//    return _headerLine;
//}

-(UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(35), WidthXiShu(80), HeightXiShu(80))];
        medicineImg.layer.masksToBounds = YES;
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImg.backgroundColor = [UIColor lightGrayColor];
        [self.bgView addSubview:medicineImg];
        _medicineImg = medicineImg;
    }
    return _medicineImg;
}

-(UILabel *)medicineNameLb{
    if(!_medicineNameLb){
        UILabel *medicineNameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(30), WidthXiShu(180), HeightXiShu(20))];
        medicineNameLb.text = @"阿司匹林肠溶片... ...";
        medicineNameLb.font = HEITI(HeightXiShu(16));
        medicineNameLb.textColor = BlackColor;
        [self.bgView addSubview:medicineNameLb];
        _medicineNameLb = medicineNameLb;
    }
    return _medicineNameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(55), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        specificationLb.text = @"规格: 40mg*7s";
        specificationLb.font = HEITI(HeightXiShu(11));
        specificationLb.textColor = TitleColor;
        [self.bgView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}

-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(75), WidthXiShu(200), HeightXiShu(20))];
        produceAreaLb.text = @"产地: ";
        produceAreaLb.font = HEITI(HeightXiShu(11));
        produceAreaLb.textColor = TitleColor;
        [self.bgView addSubview:produceAreaLb];
        _produceAreaLb = produceAreaLb;
    }
    return _produceAreaLb;
}

-(UILabel *)suppliersLb{
    if(!_suppliersLb){
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(95), WidthXiShu(200), HeightXiShu(20))];
        suppliersLb.text = @"供应商: ";
        suppliersLb.font = HEITI(HeightXiShu(11));
        suppliersLb.textColor = TitleColor;
        [self.bgView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}


-(UILabel *)priceLb{
    if(!_priceLb){
        UILabel *priceLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(275), HeightXiShu(40), kScreenWidth - WidthXiShu(20) - WidthXiShu(293) + WidthXiShu(10), HeightXiShu(20))];
        priceLb.text = @"$14.29";
        priceLb.textAlignment = NSTextAlignmentRight;
        priceLb.font = HEITI(HeightXiShu(16));
        priceLb.textColor = TitleColor;
        [self.bgView addSubview:priceLb];
        _priceLb = priceLb;
    }
    return _priceLb;
}

-(UILabel *)countLb{
    if(!_countLb){
        UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(293), HeightXiShu(65), kScreenWidth - WidthXiShu(20) - WidthXiShu(293) - WidthXiShu(10), HeightXiShu(25))];
        countLb.text = @"X8";
        countLb.textAlignment = NSTextAlignmentRight;
        countLb.font = HEITI(HeightXiShu(16));
        countLb.textColor = TitleColor;
        [self.bgView addSubview:countLb];
        _countLb = countLb;
    }
    return _countLb;
}

- (UIImageView *)footerLine{
    if(!_footerLine){
        UIImageView *footerLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(122), kScreenWidth, .5)];
        footerLine.backgroundColor = AllLightGrayColor;
        [self.bgView addSubview:footerLine];
        _footerLine = footerLine;
    }
    return _footerLine;
}

-(UILabel *)orderTimeLb{
    if(!_orderTimeLb){
        UILabel *orderTimeLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(122), WidthXiShu(155), HeightXiShu(35))];
        orderTimeLb.text = @"订单时间: 2017/02/10 08:14";
        orderTimeLb.font = HEITI(HeightXiShu(11));
        orderTimeLb.textColor = [UIColor lightGrayColor];
        [self.bgView addSubview:orderTimeLb];
        _orderTimeLb = orderTimeLb;
    }
    return _orderTimeLb;
}

-(UILabel *)integralLb{
    if(!_integralLb){
        UILabel *integralLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(170), HeightXiShu(122), WidthXiShu(70), HeightXiShu(35))];
        integralLb.font = HEITI(HeightXiShu(15));
        integralLb.textColor = TitleColor;
        [self.bgView addSubview:integralLb];
        _integralLb = integralLb;
    }
    return _integralLb;
}
-(UILabel *)totalLb{
    if(!_totalLb){
        UILabel *totalLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5), HeightXiShu(122), kScreenWidth - WidthXiShu(20) - WidthXiShu(15), HeightXiShu(35))];
        totalLb.font = HEITI(HeightXiShu(15));
        totalLb.textColor = TitleColor;
        totalLb.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:totalLb];
        _totalLb = totalLb;
    }
    return _totalLb;
}


#pragma mark - setter

- (void)setModel:(OrderModel *)model {
    
    NSString *priceText = [NSString stringWithFormat:@"总计 ^%@", [model.ORDERSUMS momeyString]];
    NSMutableAttributedString *priceAttStr = [[NSMutableAttributedString alloc] initWithString:priceText];
    [priceAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HeightXiShu(18)] range:NSMakeRange(3, priceText.length - 3)];
    [priceAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3, priceText.length - 3)];
    self.totalLb.attributedText = priceAttStr;
    
    
    NSString *integralText = @"积分 2";
    NSMutableAttributedString *integralAttStr = [[NSMutableAttributedString alloc] initWithString:integralText];
    [integralAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HeightXiShu(18)] range:NSMakeRange(3, integralText.length - 3)];
    [integralAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3, integralText.length - 3)];
    self.integralLb.attributedText = integralAttStr;
    
    self.orderNumLb.text = [NSString stringWithFormat:@"订单号:%@", model.ORDERID];
    self.medicineNameLb.text = model.GOODSNAME;
    self.specificationLb.text = [NSString stringWithFormat:@"规格:%@%@", model.SPEC, model.CALCUNIT];
    self.produceAreaLb.text = [NSString stringWithFormat:@"产地:%@", model.PRODUCER];
    self.priceLb.text = [NSString stringWithFormat:@"%@", [model.SELLPRICE momeyString]];
    self.countLb.text = [NSString stringWithFormat:@"X%ld", (long)[model.ORDERAMOUNT integerValue]];

    self.orderTimeLb.text = model.CREATETIME;

    
}

@end



@interface OrderDetailCell()

@property(nonatomic,strong)UIImageView *medicineImg;

@property(nonatomic, strong)UILabel *nameLb;  //名称
@property(nonatomic, strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商

@property(nonatomic,strong)UILabel *priceLb;   //价格
@property(nonatomic,strong)UILabel *countLb;  //积分
@property(nonatomic,strong)UIImageView *integralImg;  //积分

@property (nonatomic, retain)UIImageView *lineView;

@end

@implementation OrderDetailCell

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
        [self nameLb];
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];
        
        [self priceLb];
        [self countLb];
        [self integralImg];
        
        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(12), WidthXiShu(80), HeightXiShu(80))];
        medicineImg.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:medicineImg];
        _medicineImg = medicineImg;
    }
    return _medicineImg;
}

-(UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(5), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        nameLb.text = @"阿司匹林肠溶片";
        nameLb.font = HEITI(HeightXiShu(15));
        nameLb.textColor = TitleColor;
        [self.contentView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(35), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        specificationLb.text = @"规格: 100ml*30片";
        specificationLb.font = HEITI(HeightXiShu(10));
        specificationLb.textColor = TitleColor;
        [self.contentView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}

-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(55), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        produceAreaLb.text = @"产地: ";
        produceAreaLb.font = HEITI(HeightXiShu(10));
        produceAreaLb.textColor = TitleColor;
        [self.contentView addSubview:produceAreaLb];
        _produceAreaLb = produceAreaLb;
    }
    return _produceAreaLb;
}

-(UILabel *)suppliersLb{
    if(!_suppliersLb){
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(75), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        suppliersLb.text = @"供应商: ";
        suppliersLb.font = HEITI(HeightXiShu(10));
        suppliersLb.textColor = TitleColor;
        [self.contentView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}


-(UILabel *)priceLb{
    if(!_priceLb){
        UILabel *priceLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(70), HeightXiShu(20), HeightXiShu(60), HeightXiShu(20))];
        priceLb.text = @"$14.29";
        priceLb.textAlignment = NSTextAlignmentRight;
        priceLb.font = HEITI(HeightXiShu(17));
        priceLb.textColor = TitleColor;
        [self.contentView addSubview:priceLb];
        _priceLb = priceLb;
    }
    return _priceLb;
}

-(UILabel *)countLb{
    if(!_countLb){
        UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(70), HeightXiShu(45), HeightXiShu(60), HeightXiShu(20))];
        countLb.text = @"x8";
        countLb.textAlignment = NSTextAlignmentRight;
        countLb.font = HEITI(HeightXiShu(15));
        countLb.textColor = TitleColor;
        [self.contentView addSubview:countLb];
        _countLb = countLb;
    }
    return _countLb;
}

- (UIImageView *)integralImg {
    if (!_integralImg) {
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(70), WidthXiShu(20), HeightXiShu(20))];
        integralImg.image = [GetImagePath getImagePath:@"procureIntegral"];
        [self.contentView addSubview:integralImg];
        _integralImg = integralImg;
    }
    return _integralImg;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(104), kScreenWidth, .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}




#pragma mark - setter

- (void)setModel:(OrderModel *)model {
    
}

@end


@implementation OrderAddressCell

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
        [self addressTitleLb];
        [self nameLb];
        [self phoneLb];
        [self addressLb];
        [self remarkTitleLb];
        [self remarkLb];

    }
    return self;
}

#pragma mark - 页面元素
-(UILabel *)addressTitleLb{
    if(!_addressTitleLb){
        UILabel *addressTitleLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(0), WidthXiShu(80), HeightXiShu(40))];
        addressTitleLb.text = @"收货地址";
        addressTitleLb.font = HEITI(HeightXiShu(14));
        addressTitleLb.textColor = TitleColor;
        [self.contentView addSubview:addressTitleLb];
        _addressTitleLb = addressTitleLb;
    }
    return _addressTitleLb;
}

-(UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(10), WidthXiShu(50), HeightXiShu(15))];
        nameLb.text = @"李小明";
        nameLb.font = HEITI(HeightXiShu(10));
        nameLb.textColor = TitleColor;
        [self.contentView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}

-(UILabel *)phoneLb{
    if(!_phoneLb){
        UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(150), HeightXiShu(10), WidthXiShu(100), HeightXiShu(15))];
        phoneLb.text = @"18222881122";
        phoneLb.font = HEITI(HeightXiShu(10));
        phoneLb.textColor = TitleColor;
        [self.contentView addSubview:phoneLb];
        _phoneLb = phoneLb;
    }
    return _phoneLb;
}

-(UILabel *)addressLb{
    if(!_addressLb){
        UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(30), kScreenWidth - WidthXiShu(50), HeightXiShu(20))];
        addressLb.text = @"浙江省杭州市西湖区天目山路百丽大厦10栋1层2334室";
        addressLb.font = HEITI(HeightXiShu(10));
        addressLb.textColor = TitleColor;
        [self.contentView addSubview:addressLb];
        _addressLb = addressLb;
    }
    return _addressLb;
}

-(UILabel *)remarkTitleLb{
    if(!_remarkTitleLb){
        UILabel *remarkTitleLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(55), WidthXiShu(80), HeightXiShu(30))];
        remarkTitleLb.text = @"备注";
        remarkTitleLb.font = HEITI(HeightXiShu(14));
        remarkTitleLb.textColor = TitleColor;
        [self.contentView addSubview:remarkTitleLb];
        _remarkTitleLb = remarkTitleLb;
    }
    return _remarkTitleLb;
}

-(UILabel *)remarkLb{
    if(!_remarkLb){
        UILabel *remarkLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(60), kScreenWidth - WidthXiShu(50), HeightXiShu(20))];
        remarkLb.text = @"只要最新包装的金水宝, 旧包装的不要";
        remarkLb.font = HEITI(HeightXiShu(10));
        remarkLb.textColor = TitleColor;
        [self.contentView addSubview:remarkLb];
        _remarkLb = remarkLb;
    }
    return _remarkLb;
}

@end



@implementation OrderPriceInfoCell

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
        [self saleLb];
        [self actualLb];
        [self salePriceLb];
        [self actualPriceLb];
    }
    return self;
}

#pragma mark - 页面元素

-(UILabel *)saleLb{
    if(!_saleLb){
        UILabel *saleLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(80), HeightXiShu(30))];
        saleLb.text = @"优惠促销";
        saleLb.font = HEITI(HeightXiShu(14));
        saleLb.textColor = TitleColor;
        [self.contentView addSubview:saleLb];
        _saleLb = saleLb;
    }
    return _saleLb;
}

-(UILabel *)salePriceLb{
    if(!_salePriceLb){
        UILabel *salePriceLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(70), HeightXiShu(10), WidthXiShu(60), HeightXiShu(25))];
        salePriceLb.text = @"-$3.80";
        salePriceLb.textAlignment = NSTextAlignmentRight;
        salePriceLb.font = HEITI(HeightXiShu(10));
        salePriceLb.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:salePriceLb];
        _salePriceLb = salePriceLb;
    }
    return _salePriceLb;
}
-(UILabel *)actualLb{
    if(!_actualLb){
        UILabel *actualLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(40), WidthXiShu(80), HeightXiShu(20))];
        actualLb.text = @"实付款";
        actualLb.font = HEITI(HeightXiShu(14));
        actualLb.textColor = TitleColor;
        [self.contentView addSubview:actualLb];
        _actualLb = actualLb;
    }
    return _actualLb;
}

-(UILabel *)actualPriceLb{
    if(!_actualPriceLb){
        UILabel *actualPriceLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(110), HeightXiShu(40), WidthXiShu(100), HeightXiShu(20))];
        actualPriceLb.text = @"$330.80";
        actualPriceLb.textAlignment = NSTextAlignmentRight;
        actualPriceLb.font = HEITI(HeightXiShu(15));
        actualPriceLb.textColor = [UIColor blueColor];
        [self.contentView addSubview:actualPriceLb];
        _actualPriceLb = actualPriceLb;
    }
    return _actualPriceLb;
}
@end

@implementation OrderTimeCell

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
        [self orderTimeLb];
        [self deliveryTimeLb];
        [self receiveTimeLb];
    }
    return self;
}

#pragma mark - 页面元素

-(UILabel *)orderTimeLb{
    if(!_orderTimeLb){
        UILabel *orderTimeLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), kScreenWidth - WidthXiShu(20), HeightXiShu(17))];
        orderTimeLb.text = @"下单时间: 2017/02/10 08:11:03";
        orderTimeLb.font = HEITI(HeightXiShu(10));
        orderTimeLb.textColor = TitleColor;
        [self.contentView addSubview:orderTimeLb];
        _orderTimeLb = orderTimeLb;
    }
    return _orderTimeLb;
}

-(UILabel *)deliveryTimeLb{
    if(!_deliveryTimeLb){
        UILabel *deliveryTimeLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(32), kScreenWidth - WidthXiShu(20), HeightXiShu(17))];
        deliveryTimeLb.text = @"发货时间: 2017/02/10 08:11:03";
        deliveryTimeLb.font = HEITI(HeightXiShu(10));
        deliveryTimeLb.textColor = TitleColor;
        [self.contentView addSubview:deliveryTimeLb];
        _deliveryTimeLb = deliveryTimeLb;
    }
    return _deliveryTimeLb;
}

-(UILabel *)receiveTimeLb{
    if(!_receiveTimeLb){
        UILabel *receiveTimeLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(54), kScreenWidth - WidthXiShu(20), HeightXiShu(17))];
        receiveTimeLb.text = @"收货时间: 2017/02/10 08:11:03";
        receiveTimeLb.font = HEITI(HeightXiShu(10));
        receiveTimeLb.textColor = TitleColor;
        [self.contentView addSubview:receiveTimeLb];
        _receiveTimeLb = receiveTimeLb;
    }
    return _orderTimeLb;
}

@end
