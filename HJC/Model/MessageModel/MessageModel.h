//
//  MessageModel.h
//  HJC
//
//  Created by 方灵勇 on 2018/1/19.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,strong) NSString *MessAgeId;//消息ID
@property (nonatomic,strong) NSString *MessageType;//消息类型ID
@property (nonatomic,strong) NSString *MessageTypeName;//消息类型名称
@property (nonatomic,strong) NSString *Isread;//是否已读（0未读1已读）
@property (nonatomic,strong) NSString *Messagecontent;//消息内容
@property (nonatomic,strong) NSString *MessageTitle;//消息标题
@property (nonatomic,strong) NSString *massagedate;//消息时间

@end

@interface MessageDetailModel : NSObject


@end
