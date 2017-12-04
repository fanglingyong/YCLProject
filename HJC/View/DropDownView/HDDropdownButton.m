//
//  HDDropdownButton.m
//  zhifu360
//
//  Created by zhifu on 8/24/14.
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import "HDDropdownButton.h"
#import "Utilities.h"
#import "UIColor+AddColor.h"

@implementation HDDropdownButton
/**
 *  初始化界面
 */
-(void) setup{
    

    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4 * 3 / 5 - 2, 30)];
    lbl.textColor = TitleColor;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = HEITI(HeightXiShu(14));
    lbl.backgroundColor = [UIColor clearColor];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.tag = 1;
    [self addSubview: lbl];
    
    _iconName = @"Agent_DropDownBurron_defalut";

    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: _iconName]];
    arrowImageView.frame = CGRectMake(kScreenWidth / 4 * 3 / 5, 0, kScreenWidth / 4 * 2 / 5, 10);
    arrowImageView.tag = 2;
    [self addSubview:arrowImageView];
    arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //间距
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(lbl, arrowImageView);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[lbl]-2-[arrowImageView]"
                                                                   options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
    //水平居中对齐
    [self addConstraint: [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-5.0]];
    //垂直居中对齐
    [self addConstraint: [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
    //垂直居中对齐
    [self addConstraint: [NSLayoutConstraint constraintWithItem:arrowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0]];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.tag = 3;
    titleButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    titleButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [titleButton addTarget:self action:@selector(btnChoosePressed:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:titleButton];
    
    

}
/**
 *  initWithCoder
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
/**
 *  initWithFrame
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    UILabel* lbl = (UILabel*)[self viewWithTag:1];
    lbl.font = font;
}

-(void)setFrontColor:(UIColor *)frontColor{
    _frontColor = frontColor;
    UILabel* lbl = (UILabel*)[self viewWithTag:1];
    lbl.textColor = frontColor;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    if (title) {
        
//        CGSize size= [Utilities getTextSize:title withFont: [UIFont systemFontOfSize:13] andConstrainedToSize:self.frame.size];
        UILabel *lbl = (UILabel *)[self viewWithTag:1];
        lbl.text = title;
//        [lbl sizeToFit];
//        lbl.bounds = CGRectMake(0, 0, kScreenWidth / 4 * 3 / 5 - 2, 30);
        lbl.font = HEITI(HeightXiShu(14));
        if ([self.iconName isEqualToString:@"ico_down1.png"]) {
            self.frame = CGRectMake(0, 0, WidthXiShu(120), 30);
        }
    }
}


-(void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:2];
    arrowImageView.image = [UIImage imageNamed:iconName];
}

- (void)btnChoosePressed:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownButton:didTapButton:)]) {
        [self.delegate dropdownButton:self didTapButton:sender];
    }
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;

    
    UILabel* titleLabel = (UILabel*)[self viewWithTag:1];
    titleLabel.font = HEITI(HeightXiShu(14));
    titleLabel.textColor = selected ? TitleColor : TitleColor;
    
    UIImageView *arrowImageView = (UIImageView *)[self viewWithTag:2];
   arrowImageView.image = selected ? [UIImage imageNamed:@"Agent_DropDownBurron_selected"] : [UIImage imageNamed: self.iconName];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
