//
//  HomePageTimeScrollView.m
//  JieBa
//
//  Created by zhifu360 on 17/3/6.
//  Copyright © 2017年 zhixin. All rights reserved.
//

#import "HomePageTimeScrollView.h"
#import "UIView+Common.h"

@interface HomePageTimeScrollView ()<UIScrollViewDelegate>

@property (nonatomic, retain)UIScrollView *showAwardScrollView;
@property (nonatomic, retain)UIButton *leftButton;
@property (nonatomic, retain)UIButton *rightButton;
@property (nonatomic, retain)NSMutableArray *statementArr;

@end

@implementation HomePageTimeScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self createScrollView];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(createAnimation) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)createScrollView
{
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(WidthXiShu(10), HeightXiShu(10), WidthXiShu(45), HeightXiShu(45));
    
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.leftButton setImage:[UIImage imageNamed:@"homePage_newjilt"] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(kScreenWidth - WidthXiShu(65), HeightXiShu(7), WidthXiShu(50), self.frame.size.height - HeightXiShu(14));
    
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.rightButton setImage:[UIImage imageNamed:@"homePage_jiltImage"] forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    
    self.showAwardScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(WidthXiShu(60), self.frame.size.height / 2 - 17, kScreenWidth - WidthXiShu(130), 34)];
    self.showAwardScrollView.showsHorizontalScrollIndicator = NO;
    self.showAwardScrollView.showsVerticalScrollIndicator = NO;
    self.showAwardScrollView.scrollEnabled = false;
    self.showAwardScrollView.delegate = self;
    [self addSubview:self.showAwardScrollView];
}

-(void)setAwardTitleArr:(NSMutableArray *)titleArr{
    self.statementArr = [NSMutableArray arrayWithArray:titleArr];
    [self.showAwardScrollView removeAllSubviews]; //防止重复添加
    for(int i = 0; i < titleArr.count ; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.showAwardScrollView.size.height * i, self.showAwardScrollView.frame.size.width, self.showAwardScrollView.size.height)];
        label.font = [UIFont systemFontOfSize:12.0];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAdClick:)];
        [label addGestureRecognizer:tap];
        UIView *tapView = [tap view];
        tapView.tag = i;
        label.userInteractionEnabled = true;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.showAwardScrollView addSubview:label];
        
    }
    self.showAwardScrollView.contentSize = CGSizeMake(kScreenWidth - WidthXiShu(120), self.showAwardScrollView.frame.size.height * titleArr.count);
}

-(void)createAnimation
{
    //    NSLog(@"%lu", (unsigned long)self.statementArr.count);
    [UIView animateWithDuration:0.5 animations:^{
        self.showAwardScrollView.contentOffset = CGPointMake(0, self.showAwardScrollView.contentOffset.y + self.showAwardScrollView.frame.size.height);
    } completion:^(BOOL finished) {
//                NSLog(@"%f", self.showAwardScrollView.contentOffset.y);
//                NSLog(@"%f", (self.statementArr.count - 1) * self.showAwardScrollView.frame.size.height);
        
        if(self.showAwardScrollView.contentOffset.y == (self.statementArr.count - 1) * self.showAwardScrollView.frame.size.height) {
            self. showAwardScrollView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //scrollView.scrollEnabled = true;
}

-(void)leftButtonClick:(UIButton*)button {
    NSLog(@"zuo");
//    self.block(100);
}

-(void)rightButtonClick:(UIButton*)button {
    NSLog(@"you");
//    self.block(101);
}

-(void)selectAdClick:(id)sender{
//    NSLog(@"选择广告");
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
//    NSLog(@"___%ld",[tap view].tag);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didhomePageTimeScrollView:)]) {
        [self.delegate didhomePageTimeScrollView:[tap view].tag];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
