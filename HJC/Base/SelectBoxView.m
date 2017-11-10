//
//  SelectBoxView.m
//  HJC
//
//  Created by 方灵勇 on 2017/11/8.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "SelectBoxView.h"

@interface SelectBoxView ()

@property (nonatomic,strong) UILabel *placeholderLable;
@property (nonatomic,strong) UILabel *textLable;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation SelectBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (frame.size.height < 38) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 38);
        }else{
            self.frame = frame;
        }
        self.backgroundColor= [UIColor colorFromHexCode:@"#fdfdfd"];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorFromHexCode:@"#c1ccd5"] CGColor];
        
        self.textLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, frame.size.width-36, 22)];
        
        [self addSubview:_textLable];
        
        self.placeholderLable = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, frame.size.width-46, 22)];
        self.placeholderLable.hidden = YES;
        _placeholderLable.textColor = [UIColor colorFromHexCode:@"#707070"];
        [self addSubview:_placeholderLable];
        
        self.imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(_placeholderLable.maxX+8, 8, 22, 22)];
        _imgView.image = [UIImage imageNamed:@"select_down.png"];
        [self addSubview:_imgView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_button];
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    if ([placeholder isEqualToString:@""]) {
        _placeholderLable.hidden = YES;
    }else{
        self.placeholderLable.text = placeholder;
        _placeholderLable.hidden = NO;
    }
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderLable.textColor = placeholderColor;
}
-(void)setText:(NSString *)text{
    _textLable.text = text;
}
-(void)setTextColor:(UIColor *)textColor{
    _textLable.textColor = textColor;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
