//
//  ReceiveAddressModel.h
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiveAddressModel : NSObject

@property (nonatomic,strong) NSString*Sortid;//序列号
@property (nonatomic,strong) NSString*CORPID;//诊所名称
@property (nonatomic,strong) NSString*ADDRESS;//地址
@property (nonatomic,strong) NSString*POSTCODE;//联系人
@property (nonatomic,strong) NSString*LINK;//联系方式
@property (nonatomic,strong) NSString*ADDRESSID;//地址ID

@end
