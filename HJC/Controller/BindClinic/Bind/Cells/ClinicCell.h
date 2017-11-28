//
//  ClinicCell.h
//  HJC
//
//  Created by 方灵勇 on 2017/11/28.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bindStatus;
@property (nonatomic,strong) UILabel *clinicNmae;
@property (nonatomic,strong) UILabel *clinicLeader;
@property (nonatomic,strong) UILabel *clinicAddress;
@property (nonatomic,strong) UILabel *noClinic;

-(void)setValuesForClinicName:(NSString*)name leader:(NSString*)leader address:(NSString*)address;
//显示绑定诊所字样页面 只在无绑定诊所时候使用
-(void)setNoData;

@end
