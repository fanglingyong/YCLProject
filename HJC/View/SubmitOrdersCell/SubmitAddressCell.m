//
//  SubmitAddressCell.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "SubmitAddressCell.h"

@implementation SubmitAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.phone];
    }
    return self;
}

-(void)setModel:(SubmitAddressModel *)model{
    _model = model;
    UIColor *color = nil;
    if (model.selThis) {
        self.contentView.backgroundColor = [UIColor colorFromHexCode:@"#F2A831"];
        color = [UIColor colorFromHexCode:@"#ffffff"];
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
        color = [UIColor colorFromHexCode:@"#8c8c8c"];
    }
    _name.textColor = color;
    _name.text = model.POSTCODE;
    _address.textColor = color;
    _address.text = model.ADDRESS;
    _phone.textColor = color;
    _phone.text = model.LINK;
}

-(UILabel*)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 80, 28)];
        _name.text = @"诸葛瑾筱";
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}
-(UILabel*)address{
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectMake(96, 4, kScreenWidth-104, 18)];
        _address.text = @"浙江省杭州市上城区清泰街金鸡岭路1号北五楼信息中心";
        _address.font = [UIFont systemFontOfSize:13];
    }
    return _address;
}
-(UILabel*)phone{
    if (!_phone) {
        _phone = [[UILabel alloc] initWithFrame:CGRectMake(96, 22, kScreenWidth-104, 18)];
        _phone.text = @"18813147418";
        _phone.font = [UIFont systemFontOfSize:14];
    }
    return _phone;
}

@end
