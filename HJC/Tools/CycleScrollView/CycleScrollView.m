//
//  CycleScrollView.m
//  zhifu360
//
//  Created by zhifu on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView() <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;


@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;

@end

@implementation CycleScrollView
/**
 *  setTotalPagesCount
 *
 *  @param totalPagesCount 
 */
- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}
/**
 *  initWithFrame
 *
 *  @param frame             <#frame description#>
 *  @param animationDuration <#animationDuration description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    [self setupWithDuration:animationDuration];
    return self;
}
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration andIsSingle:(BOOL)ISSINGLE{
    _ISSINGLE = ISSINGLE;
    self = [self initWithFrame:frame];
    [self setupWithDuration:animationDuration];
    return self;

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
//        _ISSINGLE = true;
        [self setupWithDuration:5.0];
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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithDuration:5.0];
    }
    return self;
}
/**
 *  setupWithDuration
 *
 *  @param animationDuration <#animationDuration description#>
 */
- (void) setupWithDuration:(NSTimeInterval)animationDuration{
    // Initialization code
    self.autoresizesSubviews = YES;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = 0xFF;
    self.scrollView.contentMode = UIViewContentModeCenter;
    if (_ISSINGLE) {
        self.scrollView.contentSize = CGSizeMake(1 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    }else{
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    }
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    self.currentPageIndex = 0;
    
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
}



#pragma mark -
#pragma mark - 私有函数
/**
 *  configContentViews
 */
- (void)configContentViews
{
    if (self.CurrentPageBlock) {
        self.CurrentPageBlock(self.currentPageIndex);
    }
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:NO];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        //        NSLog(@"next，当前页:%d",self.currentPageIndex);
        //        NSLog(@"current offset: %f", scrollView.contentOffset.x);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        //        NSLog(@"previous，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    //    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    //    [self.scrollView setContentOffset:newOffset animated:YES];
    
    //    NSLog(@"new offset: %f", newOffset.x);
    //search: fix: 切换TAB时，滚动一半的情况
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)) animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}
- (void)setISSINGLE:(BOOL)ISSINGLE {
    _ISSINGLE = ISSINGLE;
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
