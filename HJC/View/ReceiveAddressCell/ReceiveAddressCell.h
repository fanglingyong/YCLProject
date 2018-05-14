//
//  ReceiveAddressCell.h
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiveAddressModel.h"

@protocol ReceiveAddressCellDelegate <NSObject>

-(void)cellMenthodClickToDoOnController:(NSInteger)type row:(NSIndexPath*)row;
//-(void)cellEditorToDoOnController:(NSString*)name address:(NSString*)addr phone:(NSString*)phone;

@end


@interface ReceiveAddressCell : UITableViewCell
@property(nonatomic,strong)ReceiveAddressModel *model;
@property(nonatomic,strong) NSIndexPath* row;
@property(nonatomic,weak) id<ReceiveAddressCellDelegate> delegate;

@end
