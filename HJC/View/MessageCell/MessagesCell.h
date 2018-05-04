//
//  MessagesCell.h
//  HJC
//
//  Created by 方灵勇 on 2018/1/10.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "MsgYaozixunModel.h"

@interface MessagesCell : UITableViewCell

@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *sign;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIView *cellView;
@property (nonatomic,strong) UILabel *datelb;
@property (nonatomic,strong) MessageModel*model;

@end

@interface MsgYzxCell : UITableViewCell

@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *sign;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIView *cellView;
@property (nonatomic,strong) UILabel *datelb;
@property (nonatomic,strong) MsgYaozixunModel*model;

@end
