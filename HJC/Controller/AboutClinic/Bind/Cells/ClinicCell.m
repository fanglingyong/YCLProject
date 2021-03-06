//
//  ClinicCell.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/28.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ClinicCell.h"

@implementation ClinicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor colorFromHexCode:@"#f2f2f2"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 150)];
        view.backgroundColor = [UIColor whiteColor];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 5;
        
        _bindStatus = [[UILabel alloc] initWithFrame:CGRectMake(view.maxX-85, 5, 70, 24)];
        _bindStatus.text = @"点击绑定";
        _bindStatus.textColor = [UIColor redColor];
        _bindStatus.font = [UIFont systemFontOfSize:15];
        _bindStatus.textAlignment = NSTextAlignmentCenter;
        _bindStatus.layer.borderWidth = 1;
        _bindStatus.layer.borderColor = [[UIColor redColor] CGColor];
        [view addSubview:_bindStatus];
        
        _clinicNmae = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, view.maxX-20, 30)];
        _clinicNmae.font = [UIFont systemFontOfSize:17 weight:600];
        [view addSubview:_clinicNmae];
        
        _clinicLeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 63, view.maxX-20, 24)];
        _clinicLeader.font = [UIFont systemFontOfSize:15];
        [view addSubview:_clinicLeader];
        
        _clinicAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 87, view.maxX-20, 48)];
        _clinicAddress.numberOfLines = 2;
        _clinicAddress.textColor = [UIColor grayColor];
        _clinicAddress.font = [UIFont systemFontOfSize:14];
        [view addSubview:_clinicAddress];
        
        _noClinic = [[UILabel alloc] initWithFrame:CGRectMake(view.centerX-30, view.centerY-12, 60, 24)];
        _noClinic.text = @"绑定诊所";
        _noClinic.textColor = [UIColor grayColor];
        [view addSubview:_noClinic];
        
        [self.contentView addSubview:view];
    }
    return self;
}

-(void)setModel:(BindClinicModel *)model{
    _clinicNmae.text = model.CORPNAME;
    _clinicLeader.text = model.LAWMAN;
    _clinicAddress.text = model.ADDRESS;
    _bindStatus.hidden = NO;
    _noClinic.hidden = YES;
}

-(void)setNoData{
    _clinicNmae.hidden = YES;
    _clinicLeader.hidden = YES;
    _clinicAddress.hidden = YES;
    _bindStatus.hidden = YES;
    _noClinic.hidden = NO;
}

@end
