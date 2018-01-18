//
//  SelectStatusView.h
//  HJC
//
//  Created by 方灵勇 on 2018/1/16.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SelectTypeThreeSelect,
    SelectTypeOneSelectTwoLable
} SelectType;

@interface SelectStatusView : UIView

@property (nonatomic,assign) SelectType type;
@property (nonatomic,assign) BOOL hideSelectView;


@end
