//
//  PickerView.h
//  JieBa
//
//  Created by zhifu360 on 16/10/18.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic,strong)void (^cancelBlock)();
@property(nonatomic,strong)void (^finshBlock)(NSInteger index);
- (id)initWithTitle:(CGRect)frame title:(NSString *)title dataArr:(NSMutableArray *)dataArr flag:(NSInteger)flag;
@end
