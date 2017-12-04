//
//  DropdownSimpleView.h
//  zhifu360
//
//  Created by zhifu on 4/14/15.
//  Copyright (c) 2015 rongzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownView.h"
/**
 *  下拉简单视图
 */
@interface DropdownSimpleView : DropdownView<UITableViewDataSource, UITableViewDelegate>{
        int rowHeight;
}

@property (nonatomic, strong) UITableView * theTableView;
/**
 *  数据源
 */
@property (nonatomic, strong) NSArray * dataArray;
/**
 *  选中的项
 */
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
