//
//  MessagesCell.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/10.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "MessagesCell.h"

@implementation MessagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = AllBackLightGratColor;
        [self.contentView addSubview:self.cellView];
    }
    return self;
}

-(void)updateData{
    _type.backgroundColor = [UIColor colorFromHexCode:@"#636363"];
}

-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, kScreenWidth-16, 100)];
        _cellView.backgroundColor = [UIColor whiteColor];
        _cellView.layer.cornerRadius = 8.;
        _cellView.clipsToBounds = YES;
        [_cellView addSubview:self.type];
        [_cellView addSubview:self.title];
        [_cellView addSubview:self.sign];
        [_cellView addSubview:self.content];
        [_cellView addSubview:self.datelb];
    }
    return _cellView;
}

-(UILabel*)type{
    if (!_type) {
        _type = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 70, 22)];
        _type.text = @"消息";
        _type.font = [UIFont systemFontOfSize:15];
        _type.textAlignment = NSTextAlignmentCenter;
        _type.backgroundColor = [UIColor colorFromHexCode:@"#F2A831"];
        _type.textColor = [UIColor whiteColor];
    }
    return _type;
}
-(UILabel*)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, _cellView.width-142, 22)];
        _title.text = @"这是一条消息";
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor colorFromHexCode:@"#F2A831"];
    }
    return _title;
}
-(UILabel*)sign{
    if (!_sign) {
        _sign = [[UILabel alloc] initWithFrame:CGRectMake(_cellView.width-40, 10, 40, 22)];
        _sign.textColor = [UIColor colorFromHexCode:@"#F2A831"];
        _sign.text = @"未读";
        _sign.font = [UIFont systemFontOfSize:15];
    }
    return _sign;
}
-(UILabel*)content{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, _cellView.width-16, 30)];
        _content.text = @"轻轻敲醒沉睡的心灵 慢慢张开你的眼睛 看那忙碌的世界是否依然孤独地转个不停 春风不解风情 吹动少年的心";
        _content.font = [UIFont systemFontOfSize:15];
    }
    return _content;
}
-(UILabel*)datelb{
    if (!_datelb) {
        _datelb = [[UILabel alloc] initWithFrame:CGRectMake(8, 70, _cellView.width-16, 20)];
        _datelb.textColor = [UIColor colorFromHexCode:@"#9c9c9c"];
        _datelb.text = @"2018-03-01 21:08:52";
        _datelb.textAlignment = NSTextAlignmentRight;
        _datelb.font = [UIFont systemFontOfSize:15];
    }
    return _datelb;
}
-(void)setModel:(MessageModel *)model{
    _model = model;
    _sign.text = model.Isread?@"已读":@"未读";
    _content.text = model.Messagecontent;
    _type.text = model.MessageTypeName;
    _title.text = model.MessageTitle;
    _datelb.text = model.MessDate;
}

@end

@implementation MsgYzxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = AllBackLightGratColor;
        [self.contentView addSubview:self.cellView];
    }
    return self;
}

-(void)updateData{
    _type.backgroundColor = [UIColor colorFromHexCode:@"#636363"];
}

-(UIView*)cellView{
    if (!_cellView) {
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, kScreenWidth-16, 100)];
        _cellView.backgroundColor = [UIColor whiteColor];
        _cellView.layer.cornerRadius = 8.;
        _cellView.clipsToBounds = YES;
//        [_cellView addSubview:self.type];
        [_cellView addSubview:self.title];
//        [_cellView addSubview:self.sign];
        [_cellView addSubview:self.content];
        [_cellView addSubview:self.datelb];
    }
    return _cellView;
}

-(UILabel*)type{
    if (!_type) {
        _type = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 70, 22)];
        _type.text = @"消息";
        _type.font = [UIFont systemFontOfSize:15];
        _type.textAlignment = NSTextAlignmentCenter;
        _type.backgroundColor = [UIColor colorFromHexCode:@"#F2A831"];
        _type.textColor = [UIColor whiteColor];
    }
    return _type;
}
-(UILabel*)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, _cellView.width-142, 22)];
        _title.text = @"这是一条消息";
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor colorFromHexCode:@"#F2A831"];
    }
    return _title;
}
-(UILabel*)sign{
    if (!_sign) {
        _sign = [[UILabel alloc] initWithFrame:CGRectMake(_cellView.width-40, 10, 40, 22)];
        _sign.textColor = [UIColor colorFromHexCode:@"#F2A831"];
        _sign.text = @"未读";
        _sign.font = [UIFont systemFontOfSize:15];
    }
    return _sign;
}
-(UILabel*)content{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, _cellView.width-16, 30)];
        _content.text = @"轻轻敲醒沉睡的心灵 慢慢张开你的眼睛 看那忙碌的世界是否依然孤独地转个不停 春风不解风情 吹动少年的心";
        _content.font = [UIFont systemFontOfSize:15];
    }
    return _content;
}
-(UILabel*)datelb{
    if (!_datelb) {
        _datelb = [[UILabel alloc] initWithFrame:CGRectMake(8, 70, _cellView.width-16, 20)];
        _datelb.textColor = [UIColor colorFromHexCode:@"#9c9c9c"];
        _datelb.text = @"2018-03-01 21:08:52";
        _datelb.textAlignment = NSTextAlignmentRight;
        _datelb.font = [UIFont systemFontOfSize:15];
    }
    return _datelb;
}
-(void)setModel:(MsgYaozixunModel *)model{
    _model = model;
//    _sign.text = model.Isread?@"已读":@"未读";
    _content.text = model.messageconyent;
//    _type.text = model.MessageTypeName;
    _title.text = model.messagetitle;
    _datelb.text = model.messagedate;
}


@end
