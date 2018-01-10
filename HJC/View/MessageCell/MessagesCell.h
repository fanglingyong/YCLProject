//
//  MessagesCell.h
//  HJC
//
//  Created by 方灵勇 on 2018/1/10.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesCell : UITableViewCell

@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *sign;
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,strong) UIView *cellView;

@end
