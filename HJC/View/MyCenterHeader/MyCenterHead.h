//
//  MyCenterHead.h
//  JieBa
//
//  Created by zhifu360 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCenterHeadDelegate <NSObject>
-(void)messageClick;
-(void)QRCoedeClick;
-(void)signClick;
-(void)activeClick;
-(void)changeHeadClick;
@end

@interface MyCenterHead : UIView
@property(nonatomic,weak)id<MyCenterHeadDelegate>delegate;
@property(nonatomic,strong)NSString *avatarUrl;
@end
