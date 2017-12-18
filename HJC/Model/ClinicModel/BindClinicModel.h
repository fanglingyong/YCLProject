//
//  BindClinicModel.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/17.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BindClinicModel : NSObject
//地址
@property (nonatomic,strong) NSString *ADDRESS;
//诊所id
@property (nonatomic,strong) NSString *CORPID;
//昵称
@property (nonatomic,strong) NSString *CORPNAME;
//法人
@property (nonatomic,strong) NSString *LAWMAN;
//
@property (nonatomic,strong) NSString *datakey;
//
@property (nonatomic,strong) NSString *sortid;
//
@property (nonatomic,strong) NSString *totalcount;

@end
