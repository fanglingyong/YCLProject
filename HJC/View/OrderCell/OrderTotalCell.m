//
//  OrderTotalCell.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/25.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "OrderTotalCell.h"


@interface OrderTotalCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UILabel *orderID;//订单
@property (nonatomic,strong) UILabel *psStatus;//配送状态
@property (nonatomic,strong) UILabel *createTime;//创建时间
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UITableView *listtab;
@property (nonatomic,strong) UILabel *integral;//积分
@property (nonatomic,strong) UILabel *ordersum;//总价
@property (nonatomic,strong) UIView *cellView;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) NSMutableArray *goodslist;

@end

@implementation OrderTotalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.goodslist = [NSMutableArray array];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.cellView];
        self.contentView.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
        
        [self.cellView addSubview:self.orderID];
        [self.cellView addSubview:self.psStatus];
        [self.cellView addSubview:self.view1];
        [self.cellView addSubview:self.listtab];
//        [self.cellView addSubview:self.address];
        [self.cellView addSubview:self.view2];
        [self.cellView addSubview:self.createTime];
        [self.cellView addSubview:self.integral];
        [self.cellView addSubview:self.ordersum];
    }
    return self;
}
-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, kScreenWidth-20, 228)];
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
-(UIView*)view2{
    if (!_view2) {
        _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, _listtab.maxY, _cellView.width, 2)];
        _view2.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
    }
    return _view2;
}
-(UIView*)view1{
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 36, _cellView.width, 1)];
        _view1.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
    }
    return _view1;
}

-(UILabel *)orderID{
    if (!_orderID) {
        _orderID = [[UILabel alloc] initWithFrame:CGRectMake(70, 8,  _cellView.width-140, 20)];
        _orderID.text = @"";
        _orderID.font = [UIFont systemFontOfSize:15];
//        _orderID.textAlignment = NSTextAlignmentRight;
    }
    return _orderID;
}
-(UILabel *)psStatus{
    if (!_psStatus) {
        _psStatus = [[UILabel alloc] initWithFrame:CGRectMake(_cellView.width-70, 8, 62, 20)];
        _psStatus.text = @"等待配送";
        _psStatus.textAlignment = NSTextAlignmentRight;
        _psStatus.font = [UIFont systemFontOfSize:15];
    }
    return _psStatus;
}

-(UILabel *)createTime{
    if (!_createTime) {
        _createTime = [[UILabel alloc] initWithFrame:CGRectMake(8, _listtab.maxY+10, kScreenWidth==320?120:130, 20)];
        _createTime.text = @"订单时间:";
        _createTime.font = [UIFont systemFontOfSize:kScreenWidth==320?12:13];
        _createTime.textColor = [UIColor colorFromHexCode:@"#969696"];
    }
    return _createTime;
}
-(UILabel*)integral{
    if (!_integral) {
        _integral = [[UILabel alloc] initWithFrame:CGRectMake(_createTime.maxX+5, _listtab.maxY+10, 60, 20)];
        _integral.text = @"积90000";
        _integral.font = [UIFont systemFontOfSize:14];
    }
    return _integral;
}
-(UILabel *)ordersum{
    if (!_ordersum) {
        _ordersum = [[UILabel alloc] initWithFrame:CGRectMake(_createTime.maxX+70, _listtab.maxY+10, _cellView.width-_createTime.maxX-78, 20)];
        _ordersum.textColor = [UIColor colorFromHexCode:@"#FF9900"];
        _ordersum.textAlignment = NSTextAlignmentRight;
        _ordersum.font = [UIFont systemFontOfSize:14];
    }
    return _ordersum;
}
-(UILabel *)address{    // 没有用
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kScreenWidth-60, 40)];
        _address.text = @"浙江省杭州市上城区清泰街366号北五楼信息中心";
        _address.numberOfLines = 0;
        _address.font = [UIFont systemFontOfSize:15];
    }
    return _address;
}
#pragma mark - table
-(UITableView*)listtab{
    if (!_listtab) {
        _listtab = [[UITableView alloc] initWithFrame:CGRectMake(0, 37,_cellView.width,150) style:UITableViewStylePlain];
        _listtab.delegate = self;
        _listtab.dataSource = self;
        _listtab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listtab.userInteractionEnabled = NO;
    }
    return _listtab;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodslist.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTotalGoodListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTotalGoodListCell"];
    if (!cell) {
        cell = [[OrderTotalGoodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTotalGoodListCell"];
    }
    cell.iddNum = indexPath.row;
    cell.model = _goodslist[indexPath.row];
    return cell;
}

-(void)setModel:(OrderTotalModel *)model{
    _orderID.text = [NSString stringWithFormat:@"%@",model.ORDERNO];
    _psStatus.text = [NSString stringWithFormat:@"%@",model.PROSTATUSNAME];
//    _address.text = model.ADDRESS;
    
    _ordersum.text = [NSString stringWithFormat:@"￥%@",[model.ORDERSUMS momeyString]];
    _createTime.text = [NSString stringWithFormat:@"%@",model.CREATETIME];
    _integral.text = [NSString stringWithFormat:@"积%@",model.INTEGRAL];
    
    _goodslist = [NSMutableArray array];
    [_goodslist addObjectsFromArray:model.GoodsList];
    
    _cellView.frame = CGRectMake(10, 8, kScreenWidth-20, 90+_goodslist.count*30-12);
    _listtab.frame = CGRectMake(0, 37,_cellView.width,_goodslist.count*30);
    _view2.frame = CGRectMake(0, _listtab.maxY, _cellView.width, 2);
    _ordersum.frame = CGRectMake(_createTime.maxX+70, _listtab.maxY+10, _cellView.width-_createTime.maxX-78, 20);
    _integral.frame = CGRectMake(_createTime.maxX+5, _listtab.maxY+10, 60, 20);
    _createTime.frame = CGRectMake(8, _listtab.maxY+10, kScreenWidth==320?120:130, 20);
    [_listtab reloadData];
}


@end

/** cell套tableView的cell */
@implementation OrderTotalGoodListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.cellView];
        [self.cellView addSubview:self.idd];
        [self.cellView addSubview:self.goodName];
        [self.cellView addSubview:self.countNum];
        [self.cellView addSubview:self.momeyNum];
    }
    return self;
}
-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth-16, 22)];
        _cellView.backgroundColor = [UIColor whiteColor];
    }
    return _cellView;
}
-(UILabel*)idd{
    if (!_idd){
        _idd = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 22, 22)];
        _idd.textColor = [UIColor colorFromHexCode:@"#9c9c9c"];
        _idd.font = [UIFont systemFontOfSize:15];
        _idd.text = @"";
    }
    return _idd;
}
-(UILabel*)goodName{
    if (!_goodName){
        _goodName = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, _cellView.width-190, 22)];
        _goodName.text = @"";
        _goodName.font = [UIFont systemFontOfSize:14];
    }
    return _goodName;
}
-(UILabel*)countNum{
    if (!_countNum){
        _countNum = [[UILabel alloc] initWithFrame:CGRectMake(_cellView.width-148, 0, 40, 22)];
        _countNum.text = @"X0";
        _countNum.font = [UIFont systemFontOfSize:14];
    }
    return _countNum;
}
-(UILabel*)momeyNum{
    if (!_momeyNum){
        _momeyNum = [[UILabel alloc] initWithFrame:CGRectMake(_cellView.width-108, 0, 100, 22)];
        _momeyNum.text = @"￥0.00";
//        _momeyNum.textAlignment = NSTextAlignmentRight;
        _momeyNum.font = [UIFont systemFontOfSize:14];
    }
    return _momeyNum;
}
-(void)setIddNum:(NSInteger)iddNum{
    _idd.text = [NSString stringWithFormat:@"%ld",iddNum];
}
-(void)setModel:(OrderGoodsListModel *)model{
    _model=model;
    _goodName.text = model.GOODSNAME;
    _countNum.text = [NSString stringWithFormat:@"X%@",[model.ORDERAMOUNT fString]];
    _momeyNum.text = [NSString stringWithFormat:@"￥%@",[model.ORDERSUMS fString]];
}

@end
#pragma mark --------- 细单Cell
@interface OrderDetailInfoCell()

@property (nonatomic, retain)UIView *bgView;

@property(nonatomic,strong)UIImageView *medicineImg;//图片

@property(nonatomic,strong)UILabel *medicineNameLb;  //名称
@property(nonatomic,strong)UILabel *specificationLb; // 规格
@property(nonatomic, strong)UILabel *produceAreaLb; // 产地
@property(nonatomic, strong)UILabel *suppliersLb; // 供应商


@property(nonatomic,strong)UILabel *priceLb;   //价格
@property(nonatomic,strong)UILabel *countLb;  //数量
@property(nonatomic,strong)UIImageView *integral;//积分icon
@property(nonatomic,strong)UIView *footerLine;//分割线


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
        [self.bgView addSubview:self.integral];
        
        [self.bgView addSubview:self.footerLine];
    }
    return self;
}

#pragma mark - 页面元素

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 88)];
        bgView.backgroundColor = [UIColor whiteColor];
        _bgView = bgView;
    }
    return _bgView;
}

-(UIImageView *)medicineImg{
    if(!_medicineImg){
        _medicineImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 72, 72)];
        _medicineImg.layer.masksToBounds = YES;
        _medicineImg.layer.borderWidth = .5;
        _medicineImg.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        _medicineImg.image = [UIImage imageNamed:@"syspic.jpg"];
        _medicineImg.backgroundColor = [UIColor lightGrayColor];
        _medicineImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _medicineImg;
}

-(UILabel *)medicineNameLb{
    if(!_medicineNameLb){
        _medicineNameLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX+5,2,_bgView.width-_medicineImg.maxX-10,20)];
        _medicineNameLb.text = @"阿司匹林肠溶片... ...";
        _medicineNameLb.font = HEITI(16);
        _medicineNameLb.textColor = BlackColor;
    }
    return _medicineNameLb;
}

-(UILabel *)specificationLb{
    if(!_specificationLb){
        _specificationLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + 5 , _medicineNameLb.maxY+6, _bgView.width-175, 16)];
        _specificationLb.text = @"规格: 40mg*7s";
        _specificationLb.font = HEITI(12);
        _specificationLb.textColor = TitleColor;
    }
    return _specificationLb;
}

-(UILabel *)produceAreaLb{
    if(!_produceAreaLb){
        _produceAreaLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + 5, _specificationLb.maxY+4, 200, 16)];
        _produceAreaLb.text = @"产地: ";
        _produceAreaLb.font = HEITI(12);
        _produceAreaLb.textColor = TitleColor;
    }
    return _produceAreaLb;
}

-(UILabel *)suppliersLb{
    if(!_suppliersLb){
        _suppliersLb = [[UILabel alloc] initWithFrame:CGRectMake(self.medicineImg.maxX + 5, _produceAreaLb.maxY+4, 200, 16)];
        _suppliersLb.text = @"供应商: ";
        _suppliersLb.font = HEITI(12);
        _suppliersLb.textColor = TitleColor;
    }
    return _suppliersLb;
}


-(UILabel *)priceLb{
    if(!_priceLb){
        _priceLb = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.width-100, 24, 92, 20)];
        _priceLb.text = @"$14.29";
        _priceLb.textAlignment = NSTextAlignmentRight;
        _priceLb.font = HEITI(14);
        _priceLb.textColor = TitleColor;
    }
    return _priceLb;
}

-(UILabel *)countLb{
    if(!_countLb){
        _countLb = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.width-60, 44, 52, 20)];
        _countLb.text = @"X8888";
        _countLb.textAlignment = NSTextAlignmentRight;
        _countLb.font = HEITI(14);
        _countLb.textColor = TitleColor;
    }
    return _countLb;
}
-(UIImageView*)integral{
    if (!_integral) {
        _integral = [[UIImageView alloc] initWithFrame:CGRectMake(_bgView.width-28, 64, 20, 20)];
        _integral.image = [UIImage imageNamed:@"procureIntegral"];
    }
    return _integral;
}
- (UIView *)footerLine{
    if(!_footerLine){
        _footerLine = [[UIView alloc] initWithFrame:CGRectMake(0, _bgView.maxY-1, kScreenWidth, 1)];
        _footerLine.backgroundColor = AllLightGrayColor;
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
#pragma mark - orderDetail -订单号
@implementation OrderDetailOrderNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        view.backgroundColor = [UIColor colorFromHexCode:@"#e9e9e9"];
        [self.contentView addSubview:view];
        [self.contentView addSubview:self.orderNum];
        [self.contentView addSubview:self.status];
        [self.contentView addSubview:[self view1]];
    }
    return self;
}
-(UILabel*)orderNum{
    if (!_orderNum) {
        _orderNum = [[UILabel alloc] initWithFrame:CGRectMake(8, 19, kScreenWidth-80, 22)];
        _orderNum.text =@"订单号: 2018011317040500001";
        _orderNum.font = [UIFont systemFontOfSize:15];
    }
    return _orderNum;
}
-(UILabel*)status{
    if (!_status) {
        _status = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-78, 19, 70, 22)];
        _status.text =@"等待配送";
        _status.font = [UIFont systemFontOfSize:15];
        _status.textAlignment = NSTextAlignmentRight;
    }
    return _status;
}
-(UIView*)view1{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 52, kScreenWidth, 1)];
    view1.backgroundColor = [UIColor colorFromHexCode:@"#cccccc"];
    return view1;
}
@end
@implementation OrderDetailPublicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titlelb];
        [self.contentView addSubview:self.contentlb];
    }
    return self;
}
-(UILabel*)titlelb{
    if (!_titlelb) {
        _titlelb = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 72, 30)];
        _titlelb.font = [UIFont systemFontOfSize:16];
    }
    return _titlelb;
}
-(UILabel*)contentlb{
    if (!_contentlb) {
        _contentlb = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth-90, 50)];
        _contentlb.numberOfLines = 0;
    }
    return _contentlb;
}

@end


