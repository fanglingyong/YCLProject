//
//  HDDropdownButton.h
//  zhifu360
//
//  Created by zhifu on 8/24/14.
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDDropdownButtonDelegate;

/**
 *  支持下拉的Button
 */
@interface HDDropdownButton : UIView

@property (nonatomic, weak) id<HDDropdownButtonDelegate> delegate;
/**
 *  标题
 */
@property (nonatomic, retain) NSString *title;
/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL selected;
/**
 *  字体
 */
@property (nonatomic, retain) UIFont *font;
/**
 *  字体颜色
 */
@property (nonatomic, retain) UIColor *frontColor;
/**
 *  ICON的名字
 */
@property (nonatomic, retain) NSString *iconName;


@end

/**
 *  支持下拉的Button 的协议
 */
@protocol HDDropdownButtonDelegate <NSObject>
/**
 *  点击下拉
 */
-(void) dropdownButton:(HDDropdownButton*) titleView didTapButton:(UIButton *)sender;

@end
