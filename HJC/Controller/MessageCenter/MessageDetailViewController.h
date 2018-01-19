//
//  MessageDetailViewController.h
//  HJC
//
//  Created by 方灵勇 on 2018/1/19.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"

@interface MessageDetailViewController : BaseViewController

//@property (nonatomic,copy) NSString *messageId;
@property (nonatomic,strong) MessageModel *msgModel;

@end
