//
//  SubmitOrdersCell.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "SubmitOrdersCell.h"

#define FontSizeA 14
#define FontSizeB 13
#define FontSizeC 12

@interface SubmitOrdersCell ()

@property (nonatomic,strong) UIImageView* goodsPic;//货品图片
@property (nonatomic,strong) UIImageView* integralPic;//积分图片
@property (nonatomic,strong) UILabel *goodsNameLable;//货品名称
@property (nonatomic,strong) UILabel *goodsSpecLable;//规格
@property (nonatomic,strong) UILabel *goodsProcerLable;//产地
@property (nonatomic,strong) UILabel *goodsSupplierLable;//供应商
@property (nonatomic,strong) UILabel *goodsPriceLable;//价格
@property (nonatomic,strong) UILabel *goodsAmoutLable;//数量

@property (nonatomic,assign) CGFloat s_with;
@property (nonatomic,assign) CGFloat s_height;

@end

@implementation SubmitOrdersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _s_with = self.contentView.frame.size.width;
        _s_height = 100;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.goodsPic];
        [self.contentView addSubview:self.integralPic];
        [self.contentView addSubview:self.goodsNameLable];
        [self.contentView addSubview:self.goodsSpecLable];
        [self.contentView addSubview:self.goodsProcerLable];
        [self.contentView addSubview:self.goodsSupplierLable];
        [self.contentView addSubview:self.goodsPriceLable];
        [self.contentView addSubview:self.goodsAmoutLable];
    }
    return self;
}
#pragma mark - model
-(void)setModel:(ShoppingCartModel *)model{
    [_goodsPic sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",SmallPic,model.goodspic] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"nodata.jpg"]];
    _goodsNameLable.text = model.goodsname;
    _goodsSpecLable.text = [NSString stringWithFormat:@"规格:%@",model.spec];
    _goodsProcerLable.text = [NSString stringWithFormat:@"产地:%@",model.prodarea];
    _goodsSupplierLable.text = [NSString stringWithFormat:@"供应商:%@",model.CorpName];
    _goodsPriceLable.text = [NSString stringWithFormat:@"￥%@/%@",[model.sellprice momeyString],model.useunit];
    _goodsAmoutLable.text = [NSString stringWithFormat:@"x%@",model.amount];
}
#pragma mark - control


#pragma mark - view
-(UIImageView*)goodsPic{
    if (!_goodsPic) {
        _goodsPic = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, _s_height-16, _s_height-16)];
        _goodsPic.image = [UIImage imageNamed:@"default"];
    }
    return _goodsPic;
}
-(UIImageView*)integralPic{
    if (!_integralPic) {
        _integralPic = [[UIImageView alloc]initWithFrame:CGRectMake(_s_with-20, 8, 15, 15)];
        _integralPic.image = [UIImage imageNamed:@"procureIntegral"];
    }
    return _integralPic;
}
-(UILabel*)goodsNameLable{
    if (!_goodsNameLable) {
        _goodsNameLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_height-6, 8, _s_with-_s_height-26, 20)];
        _goodsNameLable.text = @"GoodName";
        _goodsNameLable.font = [UIFont systemFontOfSize:FontSizeA weight:500];
    }
    return _goodsNameLable;
}
-(UILabel*)goodsSpecLable{
    if (!_goodsSpecLable) {
        _goodsSpecLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_height-6, 28, _s_with-_s_height-96, 20)];
        _goodsSpecLable.text = @"规格:";
        _goodsSpecLable.font = [UIFont systemFontOfSize:FontSizeC];
    }
    return _goodsSpecLable;
}
-(UILabel*)goodsProcerLable{
    if (!_goodsProcerLable) {
        _goodsProcerLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_height-6, 48, _s_with-_s_height-16, 20)];
        _goodsProcerLable.text = @"产地:";
        _goodsProcerLable.font = [UIFont systemFontOfSize:FontSizeC];
    }
    return _goodsProcerLable;
}
-(UILabel*)goodsSupplierLable{
    if (!_goodsSupplierLable) {
        _goodsSupplierLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_height-6, 68, _s_with-_s_height-66, 20)];
        _goodsSupplierLable.text = @"供应商:";
        _goodsSupplierLable.font = [UIFont systemFontOfSize:FontSizeC];
    }
    return _goodsSupplierLable;
}
-(UILabel*)goodsPriceLable{
    if (!_goodsPriceLable) {
        _goodsPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_with-90, 28, 90, 20)];
        _goodsPriceLable.text = @"$00000.00/盒";
        _goodsPriceLable.font = [UIFont systemFontOfSize:FontSizeB];
        _goodsPriceLable.textAlignment = NSTextAlignmentRight;
        _goodsPriceLable.textColor = [UIColor redColor];
    }
    return _goodsPriceLable;
}
-(UILabel*)goodsAmoutLable{
    if (!_goodsAmoutLable) {
        _goodsAmoutLable = [[UILabel alloc] initWithFrame:CGRectMake(_s_with-60, 68, 60, 24)];
        _goodsAmoutLable.text = @"x000000";
        _goodsAmoutLable.textAlignment = NSTextAlignmentRight;
        _goodsAmoutLable.font = [UIFont systemFontOfSize:FontSizeB];
    }
    return _goodsAmoutLable;
}

@end
