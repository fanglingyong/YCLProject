//
//  HDFilterView.h
//  Jiedai
//
//  Created by zhifu on 7/30/14.
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropdownViewDelegate;
/**
 *  下拉视图
 */
@interface DropdownView : UIView<UIGestureRecognizerDelegate>{
    float maxHeight;
    float footerHeight;
}

@property (nonatomic, weak) id<DropdownViewDelegate> delegate;
/**
 *  容器视图
 */
@property (nonatomic, strong) UIView *containerView;
/**
 *  Footer视图
 */
@property (nonatomic, strong) UIView *footerView;
/**
 *  重置内容大小
 */
-(void) resetContentFrame;
@end

/**
 *  下拉视图协议
 */
@protocol DropdownViewDelegate <NSObject>
/**
 *  隐藏视图
 */
-(void)didHideFilterView:(DropdownView *)filterView;
/**
 *  选中视图中的某一行
 */
-(void)didSelectRowOfFilterView:(DropdownView *)filterView;

@end
