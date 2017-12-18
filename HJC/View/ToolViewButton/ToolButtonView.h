//
//  ToolButtonView.h
//  HJC
//
//  Created by 方灵勇 on 2017/12/13.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolButtonView : UIView

/**
 fangly
 2017-12-13 09:29:46
 @param frame view的frame
 @param btTitle 按钮的标题
 @return 返回一个底部的view 上有一个button。
 */
- (_Nullable instancetype)initWithFrame:(CGRect)frame button:(NSString *)btTitle;

- (void)addToolTarget:(nullable id)target action:(_Nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
