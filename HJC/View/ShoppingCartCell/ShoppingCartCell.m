//
//  ShoppingCartCell.m
//  HJC
//
//  Created by zhifu360 on 2017/11/10.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "ShopCartChangeAmout.h"

@interface ShoppingCartCell()

@property(nonatomic, strong)UIImageView *selectImg; //选择小图标
@property(nonatomic, strong)UIButton *selectBtn; //选择小图标

@property(nonatomic, strong)UIImageView *medicineImg; //药品图片
@property(nonatomic, strong)UILabel *nameLb;  //名称
@property(nonatomic, strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商

@property(nonatomic, strong)UIImageView *integralImg; //积分图片
@property(nonatomic, strong)UILabel *priceLb;   //价格
@property(nonatomic, strong)UILabel *countLb;   //个数

@property(nonatomic, strong)UIButton *editBtn; // 编辑
@property(nonatomic, strong)UIButton *deleteBtn;    // 删除

@property(nonatomic, strong)UIImageView *lineView;

@property (nonatomic,strong) ShopCartChangeAmout *editView;//编辑视图

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
        [self selectImg];
        [self selectBtn];
        
        [self medicineImg];
        [self nameLb];
        [self specificationLb];
        [self produceAreaLb];
        [self suppliersLb];
        
        [self integralImg];
        [self priceLb];
        [self countLb];
        [self editBtn];
        [self deleteBtn];

        [self lineView];
    }
    return self;
}

#pragma mark - 页面元素
- (UIImageView *)selectImg{
    if(!_selectImg){
        UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(8), HeightXiShu(48) - HeightXiShu(9), WidthXiShu(18), HeightXiShu(18))];
        selectImg.image = [GetImagePath getImagePath:@"cartDefault"];
        [self.contentView addSubview:selectImg];
        _selectImg = selectImg;
    }
    return _selectImg;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(0, 0, WidthXiShu(30), HeightXiShu(96));
        [selectBtn addTarget:self action:@selector(selectBtnBtnClick:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:selectBtn];
        _selectBtn = selectBtn;
    }
    return _selectBtn;
}

- (UIImageView *)medicineImg{
    if(!_medicineImg){
        UIImageView *medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(32), HeightXiShu(10), WidthXiShu(76), HeightXiShu(76))];
        medicineImg.image = [GetImagePath getImagePath:@"MyOrder_carInsurance_headerPhoto"];
        medicineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:medicineImg];
        _medicineImg = medicineImg;
    }
    return _medicineImg;
}

-(UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(5), WidthXiShu(170), HeightXiShu(20))];
        nameLb.text = @"阿司匹林肠溶片";
        nameLb.font = HEITI(HeightXiShu(15));
        nameLb.textColor = BlackColor;
        [self.contentView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        UILabel *specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(30), WidthXiShu(170), HeightXiShu(20))];
        specificationLb.text = @"规格: 40mg*6s";
        specificationLb.font = HEITI(HeightXiShu(11));
        specificationLb.textColor = TitleColor;
        [self.contentView addSubview:specificationLb];
        _specificationLb = specificationLb;
    }
    return _specificationLb;
}

-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        UILabel *produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(50), WidthXiShu(170), HeightXiShu(20))];
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
        UILabel *suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + WidthXiShu(5), HeightXiShu(70), WidthXiShu(170), HeightXiShu(20))];
        suppliersLb.text = @"供应商: 华东医药股份有限公司";
        suppliersLb.font = HEITI(HeightXiShu(11));
        suppliersLb.textColor = TitleColor;
        [self.contentView addSubview:suppliersLb];
        _suppliersLb = suppliersLb;
    }
    return _suppliersLb;
}

- (UIImageView *)integralImg{
    if(!_integralImg){
        UIImageView *integralImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(30), HeightXiShu(5), WidthXiShu(20), HeightXiShu(20))];
        integralImg.image = [GetImagePath getImagePath:@"procureIntegral"];
        [self.contentView addSubview:integralImg];
        _integralImg = integralImg;
    }
    return _integralImg;
}

-(UILabel *)priceLb{
    if(!_priceLb){
        UILabel *priceLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(125), HeightXiShu(30), WidthXiShu(120), HeightXiShu(20))];
        priceLb.text = @"￥6.39/盒";
        priceLb.textAlignment = NSTextAlignmentRight;
        priceLb.font = HEITI(HeightXiShu(13));
        priceLb.textColor = BlackColor;
        [self.contentView addSubview:priceLb];
        _priceLb = priceLb;
    }
    return _priceLb;
}


-(UILabel *)countLb{
    if(!_countLb){
        UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - WidthXiShu(85), HeightXiShu(50), WidthXiShu(80), HeightXiShu(20))];
        countLb.text = @"x 1";
        countLb.textAlignment = NSTextAlignmentRight;
        countLb.font = HEITI(HeightXiShu(13));
        countLb.textColor = TitleColor;
        [self.contentView addSubview:countLb];
        _countLb = countLb;
    }
    return _countLb;
}


- (UIButton *)editBtn {
    if (!_editBtn) {
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(55), HeightXiShu(70), WidthXiShu(20), HeightXiShu(20));
        [editBtn setImage:[GetImagePath getImagePath:@"edit"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchDown];
        [editBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.contentView addSubview:editBtn];
        _editBtn = editBtn;
    }
    return _editBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(25), HeightXiShu(70), WidthXiShu(20), HeightXiShu(20));
        [deleteBtn setImage:[GetImagePath getImagePath:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchDown];
        [deleteBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.contentView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
    
}
- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(95), kScreenWidth, .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}
-(ShopCartChangeAmout*)editView{
    if (!_editView) {
        _editView = [[ShopCartChangeAmout alloc] initWithFrame:CGRectMake(_medicineImg.maxX+1, 0, kScreenWidth-_medicineImg.maxX-1, self.contentView.maxY)];
    }
    return _editView;
}
#pragma mark - 事件
- (void)selectBtnBtnClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    if (_model.isSelect) {
        _model.isSelect = NO;
        _selectImg.image = [UIImage imageNamed:@"cartDefault"];
    }else{
        _model.isSelect = YES;
        _selectImg.image = [UIImage imageNamed:@"cartSelect"];
    }
    [self updateCell];
    sender.userInteractionEnabled = YES;
}

- (void)editBtnClick:(UIButton *)sender {
    [self.contentView addSubview:self.editView];
    __block typeof(self) wself = self;
    [_editView setGoodsInfo:_model.goodsname count:[_model.amount integerValue] block:^(NSInteger amout) {
        wself.countLb.text = [NSString stringWithFormat:@"x %ld",amout];
        NSString *oldCount = wself.model.amount;
        wself.model.amount = [NSString stringWithFormat:@"%ld",amout];
        if (wself.delegate && [wself.delegate respondsToSelector:@selector(changeOrderDetail:oldCount:)]) {
            [wself.delegate changeOrderDetail:wself.row oldCount:oldCount];
        }
    }];
}

- (void)deleteBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteThisCell:)]) {
        [self.delegate deleteThisCell:_row];
    }
}
-(void)updateCell{
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateCellForData:)]) {
        [self.delegate updateCellForData:_row];
    }
}

#pragma mark - setter
- (void)setModel:(ShoppingCartModel *)model {
    _model = model;
    [self updateinfo];
}
-(void)updateinfo{
    [_medicineImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"sysIcon3.jpg"]];//药品图片
    _nameLb.text = _model.goodsname;
    _specificationLb.text = [NSString stringWithFormat:@"规格:%@",_model.spec];
    _produceAreaLb.text = [NSString stringWithFormat:@"产地:%@",_model.prodarea];
    _suppliersLb.text = [NSString stringWithFormat:@"供应商:%@",_model.CorpName];
    _priceLb.text = [NSString stringWithFormat:@"￥%@/%@",_model.sellprice,_model.useunit];
    _countLb.text = [NSString stringWithFormat:@"x %@",_model.amount];
    if (_model.isSelect) {
        _selectImg.image = [UIImage imageNamed:@"cartSelect"];
    }else{
        _selectImg.image = [UIImage imageNamed:@"cartDefault"];
    }
}


@end
