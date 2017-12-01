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
@property(nonatomic,strong)UILabel *orderNumLB;
@property(nonatomic,strong)UIImageView *headerLine;

@property(nonatomic,strong)UIImageView *medicineIMG;
@property(nonatomic,strong)UILabel *medicineNameLB;  //名称
@property(nonatomic,strong)UILabel *specificationLB; // 规格
@property(nonatomic,strong)UILabel *companyLB; // 公司

@property(nonatomic,strong)UILabel *priceLB;   //价格
@property(nonatomic,strong)UILabel *countLB;  //数量

@property(nonatomic,strong)UIImageView *footerLine;
@property(nonatomic,strong)UILabel *totalLB;  //数量

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
        [self orderNumLB];
        [self headerLine];
        
        [self medicineIMG];
        [self medicineNameLB];
        [self specificationLB];
        [self companyLB];
        
        [self priceLB];
        [self countLB];
        
        [self footerLine];
        [self totalLB];

    }
    return self;
}

#pragma mark - 页面元素

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), kScreenWidth - WidthXiShu(20), HeightXiShu(158))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = WidthXiShu(5);
        [self.contentView addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}
-(UILabel *)orderNumLB{
    if(!_orderNumLB){
        UILabel *orderNumLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(7), 0, kScreenWidth - WidthXiShu(20) - WidthXiShu(7), HeightXiShu(32))];
        orderNumLB.text = @"订单号:2017112014250001";
        orderNumLB.font = HEITI(HeightXiShu(15));
        orderNumLB.textColor = TitleColor;
        [self.bgView addSubview:orderNumLB];
        _orderNumLB = orderNumLB;
    }
    return _orderNumLB;
}

- (UIImageView *)headerLine{
    if(!_headerLine){
        UIImageView *headerLine = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(32), kScreenWidth - WidthXiShu(20) - WidthXiShu(20), .5)];
        headerLine.backgroundColor = AllLightGrayColor;
        [self.bgView addSubview:headerLine];
        _headerLine = headerLine;
    }
    return _headerLine;
}

-(UIImageView *)medicineIMG{
    if(!_medicineIMG){
        UIImageView *medicineIMG = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(43), WidthXiShu(70), HeightXiShu(70))];
        medicineIMG.layer.masksToBounds = YES;
        medicineIMG.layer.borderWidth = .5;
        medicineIMG.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineIMG.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineIMG.backgroundColor = [UIColor lightGrayColor];
        [self.bgView addSubview:medicineIMG];
        _medicineIMG = medicineIMG;
    }
    return _medicineIMG;
}

-(UILabel *)medicineNameLB{
    if(!_medicineNameLB){
        UILabel *medicineNameLB = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineIMG.maxX + WidthXiShu(5), HeightXiShu(40), WidthXiShu(180), HeightXiShu(20))];
        medicineNameLB.text = @"阿司匹林肠溶片... ...";
        medicineNameLB.font = HEITI(HeightXiShu(15));
        medicineNameLB.textColor = TitleColor;
        [self.bgView addSubview:medicineNameLB];
        _medicineNameLB = medicineNameLB;
    }
    return _medicineNameLB;
}

-(UILabel *)specificationLB{
    if(!_specificationLB){
        UILabel *specificationLB = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineIMG.maxX + WidthXiShu(5), HeightXiShu(65), kScreenWidth - WidthXiShu(120), HeightXiShu(25))];
        specificationLB.text = @"40mg*7s";
        specificationLB.font = HEITI(HeightXiShu(14));
        specificationLB.textColor = TitleColor;
        [self.bgView addSubview:specificationLB];
        _specificationLB = specificationLB;
    }
    return _specificationLB;
}

-(UILabel *)companyLB{
    if(!_companyLB){
        UILabel *companyLB = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineIMG.maxX + WidthXiShu(5), HeightXiShu(90), kScreenWidth - WidthXiShu(120), HeightXiShu(25))];
        companyLB.text = @"杭州中美华东制药有限公司";
        companyLB.font = HEITI(HeightXiShu(14));
        companyLB.textColor = TitleColor;
        [self.bgView addSubview:companyLB];
        _companyLB = companyLB;
    }
    return _companyLB;
}


-(UILabel *)priceLB{
    if(!_priceLB){
        UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(293), HeightXiShu(40), kScreenWidth - WidthXiShu(20) - WidthXiShu(293), HeightXiShu(20))];
        priceLB.text = @"$14.29";
        priceLB.font = HEITI(HeightXiShu(16));
        priceLB.textColor = TitleColor;
        [self.bgView addSubview:priceLB];
        _priceLB = priceLB;
    }
    return _priceLB;
}

-(UILabel *)countLB{
    if(!_countLB){
        UILabel *countLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(293), HeightXiShu(65), kScreenWidth - WidthXiShu(20) - WidthXiShu(293) - WidthXiShu(10), HeightXiShu(25))];
        countLB.text = @"x8";
        countLB.textAlignment = NSTextAlignmentRight;
        countLB.font = HEITI(HeightXiShu(16));
        countLB.textColor = TitleColor;
        [self.bgView addSubview:countLB];
        _countLB = countLB;
    }
    return _countLB;
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

-(UILabel *)totalLB{
    if(!_totalLB){
        UILabel *totalLB = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(5), HeightXiShu(123), kScreenWidth - WidthXiShu(20) - WidthXiShu(15), HeightXiShu(35))];
        totalLB.font = HEITI(HeightXiShu(15));
        totalLB.textColor = TitleColor;
        totalLB.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:totalLB];
        _totalLB = totalLB;
    }
    return _totalLB;
}


#pragma mark - setter

- (void)setModel:(OrderModel *)model {
    
    NSString *priceText = @"总计 ^43.00";
    NSMutableAttributedString *priceAttStr = [[NSMutableAttributedString alloc] initWithString:priceText];
    [priceAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:HeightXiShu(18)] range:NSMakeRange(3, priceText.length - 3)];
    [priceAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(3, priceText.length - 3)];
    self.totalLB.attributedText = priceAttStr;
}

@end



@interface OrderDetailCell()

@property(nonatomic,strong)UIImageView *medicineImageView;
@property(nonatomic,strong)UILabel *medicineNameLabel;  //名称
@property(nonatomic,strong)UILabel *companyLabel; // 公司
@property(nonatomic,strong)UILabel *specificationLabel; // 规格
@property(nonatomic,strong)UILabel *validityPeriodLabel; // 有效期

@property(nonatomic,strong)UILabel *priceLabel;   //价格
@property(nonatomic,strong)UILabel *countLabel;  //积分

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
        [self medicineImageView];
        [self medicineNameLabel];
        [self companyLabel];
        [self specificationLabel];
        [self validityPeriodLabel];
        [self priceLabel];
        [self countLabel];
        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)medicineImageView{
    if(!_medicineImageView){
        UIImageView *medicineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(5), HeightXiShu(5), WidthXiShu(80), HeightXiShu(80))];
        medicineImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:medicineImageView];
        _medicineImageView = medicineImageView;
    }
    return _medicineImageView;
}

-(UILabel *)medicineNameLabel{
    if(!_medicineNameLabel){
        UILabel *medicineNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(5), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
        medicineNameLabel.text = @"阿司匹林肠溶片 100mg * 30片";
        medicineNameLabel.font = HEITI(HeightXiShu(15));
        medicineNameLabel.textColor = TitleColor;
        [self.contentView addSubview:medicineNameLabel];
        _medicineNameLabel = medicineNameLabel;
    }
    return _medicineNameLabel;
}

-(UILabel *)companyLabel{
    if(!_companyLabel){
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(27), kScreenWidth - WidthXiShu(120), HeightXiShu(20))];
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
        UILabel *specificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(47), kScreenWidth - WidthXiShu(120), HeightXiShu(15))];
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
        UILabel *validityPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImageView.maxX + WidthXiShu(5), HeightXiShu(62), kScreenWidth - WidthXiShu(120), HeightXiShu(15))];
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
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(60), HeightXiShu(5), HeightXiShu(55), HeightXiShu(20))];
        priceLabel.text = @"$14.29";
        priceLabel.font = HEITI(HeightXiShu(15));
        priceLabel.textColor = TitleColor;
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}

-(UILabel *)countLabel{
    if(!_countLabel){
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(60), HeightXiShu(23), HeightXiShu(55), HeightXiShu(15))];
        countLabel.text = @"x8";
        countLabel.font = HEITI(HeightXiShu(12));
        countLabel.textColor = TitleColor;
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
    }
    return _countLabel;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(94), kScreenWidth, .5)];
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


@interface OrderLogisticsInfoCell()

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLabel;  //名称
@property(nonatomic,strong)UILabel *timeLabel; // 公司
@property(nonatomic,strong)UIImageView *arrowImageView;
@property (nonatomic, retain)UIImageView *lineView;

@end

@implementation OrderLogisticsInfoCell

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
        [self leftImageView];
        [self titleLabel];
        [self timeLabel];
        [self arrowImageView];
        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)leftImageView{
    if(!_leftImageView){
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(20), WidthXiShu(30), HeightXiShu(30))];
        leftImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        leftImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:leftImageView];
        _leftImageView = leftImageView;
    }
    return _leftImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(50), 0, kScreenWidth - WidthXiShu(30) - WidthXiShu(50), HeightXiShu(45))];
        titleLabel.text = @"货品已经签收, 签收人李先生. 派件员电话188-8866-6044";
        titleLabel.numberOfLines = 2;
        titleLabel.font = HEITI(HeightXiShu(15));
        titleLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(50), HeightXiShu(50), kScreenWidth - WidthXiShu(30) - WidthXiShu(50), HeightXiShu(15))];
        timeLabel.text = @"2017-7-27 12:08:14";
        timeLabel.font = HEITI(HeightXiShu(12));
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
    }
    return _timeLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(23), HeightXiShu(25), WidthXiShu(16), HeightXiShu(20))];
        arrowImageView.image = [GetImagePath getImagePath:@"right_arrow"];
        [self.contentView addSubview:arrowImageView];
        _arrowImageView = arrowImageView;
    }
    return _arrowImageView;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(69), kScreenWidth, .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}


@end


@interface OrderAddressCell()

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *nameLabel;  //名称
@property(nonatomic,strong)UILabel *phoneLabel; // 公司
@property(nonatomic,strong)UILabel *addressLabel; // 公司

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
        [self leftImageView];
        [self nameLabel];
        [self phoneLabel];
        [self addressLabel];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)leftImageView{
    if(!_leftImageView){
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(15), WidthXiShu(30), HeightXiShu(30))];
        leftImageView.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        leftImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:leftImageView];
        _leftImageView = leftImageView;
    }
    return _leftImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(50), HeightXiShu(10), kScreenWidth - WidthXiShu(30) - WidthXiShu(50), HeightXiShu(20))];
        nameLabel.text = @"古荡社区诊所 李小明";
        nameLabel.font = HEITI(HeightXiShu(13));
        nameLabel.textColor = TitleColor;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel{
    if(!_phoneLabel){
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(240), HeightXiShu(10), kScreenWidth - WidthXiShu(240), HeightXiShu(20))];
        phoneLabel.text = @"182-2288-1122";
        phoneLabel.font = HEITI(HeightXiShu(12));
        phoneLabel.textColor = TitleColor;
        [self.contentView addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
    }
    return _phoneLabel;
}

-(UILabel *)addressLabel{
    if(!_addressLabel){
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(50), HeightXiShu(35), kScreenWidth - WidthXiShu(50), HeightXiShu(20))];
        addressLabel.text = @"浙江省杭州市西湖区天目山路百丽大厦10栋1层2334室";
        addressLabel.font = HEITI(HeightXiShu(13));
        addressLabel.textColor = TitleColor;
        [self.contentView addSubview:addressLabel];
        _addressLabel = addressLabel;
    }
    return _addressLabel;
}

@end



