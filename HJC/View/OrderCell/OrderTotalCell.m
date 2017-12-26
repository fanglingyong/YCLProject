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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
