//
//  ToolButtonView.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/13.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ToolButtonView.h"

@interface ToolButtonView ()

//@property (nonatomic,assign) SEL action;
//@property (nonatomic,strong) id target;
//@property (nonatomic,assign) UIControlEvents controlEvents;
@property (nonatomic,strong) UIButton *button;
@end

@implementation ToolButtonView

- (instancetype)initWithFrame:(CGRect)frame button:(NSString*)btTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOpacity = 0.5f;
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(8, 4, kScreenWidth-16, 40);
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [[UIColor colorFromHexCode:@"#b3b3b3"] CGColor];
        _button.layer.cornerRadius = 3;
        _button.clipsToBounds = YES;
        [_button setTitle:btTitle forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor colorFromHexCode:@"#4399e9"];
        [_button setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
        
        
        [self addSubview:_button];
    }
    return self;
}
- (void)addToolTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
//    _target = target;
//    _action = action;
//    _controlEvents = controlEvents;
//    [_button addTarget:_target action:_action forControlEvents:_controlEvents];
//}
    [_button addTarget:target action:action forControlEvents:controlEvents];
}
@end
