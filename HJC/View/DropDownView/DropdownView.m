//
//  HDFilterView.m
//  Jiedai
//
//  Created by zhifu on 7/30/14.
//  Copyright (c) 2014 zhifu. All rights reserved.
//

#import "DropdownView.h"
#import <QuartzCore/QuartzCore.h>

@interface DropdownView (){
    float direction;
}

@end

@implementation DropdownView
/**
 *  initWithFrame
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        maxHeight = [UIScreen mainScreen].applicationFrame.size.height - 44 - 35 - 49 -20 - 10;
        
        footerHeight = 1;

        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, maxHeight)];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_containerView];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, maxHeight-footerHeight, self.frame.size.width, footerHeight)];
        [_containerView addSubview:_footerView];
        _footerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _footerView.layer.contents = (__bridge id)[[UIImage imageNamed:@"drag_footer"] CGImage];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        panGestureRecognizer.delaysTouchesBegan = NO;
        panGestureRecognizer.delaysTouchesEnded = NO;
        [_footerView addGestureRecognizer:panGestureRecognizer];
        
//        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//        [_footerView addGestureRecognizer:swipeGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];

    if (!hidden) {
        [self resetContentFrame];
    }
    else{
        self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, footerHeight);
    }
}

-(void) resetContentFrame{
    
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer{
    if ([recognizer state] == UIGestureRecognizerStateChanged){
        CGPoint translation = [recognizer translationInView:self];
        direction = translation.y;
        
        CGRect rect = self.containerView.frame;
        rect.size.height += translation.y;
        
        if (rect.size.height < maxHeight && rect.size.height > footerHeight) {
            self.containerView.frame = rect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.containerView];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
//        XLOG(@"pri: %f", direction);
        if (direction > 0) {//down
            [self resetContentFrame];
        }
        else{//up
            self.hidden = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didHideFilterView:)]) {
                [self.delegate didHideFilterView:self];
            }
        }
    }
}

- (void) handleTap:(UITapGestureRecognizer*) recognizer{
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHideFilterView:)]) {
        [self.delegate didHideFilterView:self];
    }
}

#pragma mark - UIGestureRecognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint touchPoint = [touch locationInView:self];
    return !CGRectContainsPoint(self.containerView.frame, touchPoint);
}



@end
