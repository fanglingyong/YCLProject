//
//  UserModel.h
//  myKaxiu
//
//  Created by 方灵勇 on 16/7/2.
//  Copyright © 2016年 Shanghai mai yi sports co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Anima.h"

@interface UserModel : NSObject<NSCoding>

/*  返回的信息
 {
 "status":1,"message":"登录成功",
 "data":[
 {
 "dept_no":"1", --
 "ischoose":"1", --积分
 "P_LSM":"1", --序号id
 "P_NAME":"admin", --昵称
 "WORK_NO":"admin", --登录账号
 "PASSWORD":"e10adc3949ba59abbe56e057f20f883e", --登录密码
 "P_STATE":"1", --账号状态
 "P_LEVER":"1", -- 权限
 "LastLoginTime":"", --最后一次登录时间
 "spellcode":"  ", -- 拼音码
 "LINKCALL":"", -- 座机电话
 "EMail":"", -- 邮箱
 "P_Type":"1", -- 类型
 "RID":"1", -- 关联诊所id
 "PostAddress":"", --通讯地址
 "dept_No1":"1",
 "Ischoose1":"1",
 "ThemeID":"1",
 "spelltype":"1",
 "handphone":"", --手机号
 "RegisterMemo":"" --备注信息
 }
 ]
 }
 */
/*
 e10adc3949ba59abbe56e057f20f883e
 */

@property (nonatomic, strong) NSString *dept_no;
@property (nonatomic, strong) NSString *ischoose;
@property (nonatomic, strong) NSString *P_LSM;
@property (nonatomic, strong) NSString *P_NAME;
@property (nonatomic, strong) NSString *PASSWORD;
@property (nonatomic, strong) NSString *P_STATE;
@property (nonatomic, strong) NSString *P_LEVER;
@property (nonatomic, strong) NSString *LastLoginTime;
@property (nonatomic, strong) NSString *LINKCALL;
@property (nonatomic, strong) NSString *EMail;
@property (nonatomic, strong) NSString *P_Type;
@property (nonatomic, strong) NSString *RID;
@property (nonatomic, strong) NSString *PostAddress;
@property (nonatomic, strong) NSString *dept_No1;
@property (nonatomic, strong) NSString *Ischoose1;
@property (nonatomic, strong) NSString *ThemeID;
@property (nonatomic, strong) NSString *spelltype;
@property (nonatomic, strong) NSString *handphone;
@property (nonatomic, strong) NSString *RegisterMemo;
/**
 *  类方法初始化、初始化会读取本地数据。
 *
 *  @return 返回本地存储的数据
 */
+(UserModel*)getUserModel;
/**
 *  存储数据
 */
+(void)saveModel:(UserModel *)model;

/**
 *  如果是init初始化，是没有读取数据的
 */
@end

