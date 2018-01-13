//
//  OrderTotalCell.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderTotalCell.h"

@implementation OrderTotalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.cellView];
        self.contentView.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
        
        [self.cellView addSubview:self.orderID];
        
        [self.cellView addSubview:self.address];
        [self.cellView addSubview:[self view]];
        [self.cellView addSubview:self.ordersum];
        [self.cellView addSubview:self.createTime];
    }
    return self;
}
-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, kScreenWidth-20, 102)];
        _cellView.backgroundColor = [UIColor whiteColor];
        _cellView.layer.cornerRadius = 5;
        _cellView.clipsToBounds = YES;
        UILabel *ordertitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 60, 20)];
        ordertitle.text = @"总单ID:";
        ordertitle.font = [UIFont systemFontOfSize:15];
        [_cellView addSubview:ordertitle];
    }
    return _cellView;
}
-(UIView*)view{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 75, kScreenWidth-20, 2)];
    view.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
    return view;
}
-(UILabel *)orderID{
    if (!_orderID) {
        _orderID = [[UILabel alloc] initWithFrame:CGRectMake(70, 8, kScreenWidth-100, 20)];
        _orderID.text = @"";
        _orderID.font = [UIFont systemFontOfSize:15];
        _orderID.textAlignment = NSTextAlignmentRight;
    }
    return _orderID;
}
-(UILabel *)createTime{
    if (!_createTime) {
        _createTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-160, 81, 140, 17)];
        _createTime.text = @"";
        _createTime.font = [UIFont systemFontOfSize:14];
        _createTime.textAlignment = NSTextAlignmentRight;
        _createTime.textColor = [UIColor colorFromHexCode:@"#666666"];
    }
    return _createTime;
}
-(UILabel *)ordersum{
    if (!_ordersum) {
        _ordersum = [[UILabel alloc] initWithFrame:CGRectMake(8, 81, kScreenWidth-170, 17)];
        _ordersum.textColor = [UIColor colorFromHexCode:@"#FF9900"];
        _ordersum.font = [UIFont systemFontOfSize:15];
    }
    return _ordersum;
}
-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kScreenWidth-60, 40)];
        _address.text = @"浙江省杭州市上城区清泰街366号北五楼信息中心";
        _address.numberOfLines = 0;
        _address.font = [UIFont systemFontOfSize:15];
    }
    return _address;
}

-(void)setModel:(OrderTotalModel *)model{
    _orderID.text = [NSString stringWithFormat:@"%@",model.ORDERNO];
    _address.text = model.ADDRESS;
    _ordersum.text = [NSString stringWithFormat:@"￥%@",[model.ORDERSUMS momeyString]];
    _createTime.text = model.CREATETIME;
}

@end

@interface OrderDetailInfoCell()

@property (nonatomic, retain)UIView *bgView;

@property(nonatomic,strong)UIImageView *medicineImg;
@property(nonatomic,strong)UILabel *medicineNameLb;  //名称
@property(nonatomic,strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商


@property(nonatomic,strong)UILabel *priceLb;   //价格
@property(nonatomic,strong)UILabel *countLb;  //数量

@property(nonatomic,strong)UIImageView *footerLine;


@end

@implementation OrderDetailInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.medicineImg];
        [self.bgView addSubview:self.medicineNameLb];
        [self.bgView addSubview:self.specificationLb];
        [self.bgView addSubview:self.produceAreaLb];
        [self.bgView addSubview:self.suppliersLb];
        
        [self.bgView addSubview:self.priceLb];
        [self.bgView addSubview:self.countLb];
        
        [self.bgView addSubview:self.footerLine];
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
        _bgView = bgView;
    }
    return _bgView;
}

-(UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(35), WidthXiShu(80), HeightXiShu(80))];
        medicineImg.layer.masksToBounds = YES;
        medicineImg.layer.borderWidth = .5;
        medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        medicineImg.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImg.backgroundColor = [UIColor lightGrayColor];
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
        produceAreaLb.text = @"产地: 杭州中美华东制药有限公司";
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
        suppliersLb.text = @"供应商: 华东医药股份有限公司";
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

#pragma mark - setter

- (void)setModel:(OrderModel *)model {
    
    self.medicineNameLb.text = model.GOODSNAME;
    self.specificationLb.text = [NSString stringWithFormat:@"规格:%@%@", model.SPEC, model.CALCUNIT];
    self.produceAreaLb.text = [NSString stringWithFormat:@"产地:%@", model.PRODUCER];
    self.priceLb.text = [NSString stringWithFormat:@"%@", [model.SELLPRICE momeyString]];
    self.countLb.text = [NSString stringWithFormat:@"X%ld", (long)[model.ORDERAMOUNT integerValue]];
}


@end
