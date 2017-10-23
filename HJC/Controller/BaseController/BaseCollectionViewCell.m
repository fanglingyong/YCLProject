//
//  RKBaseCollectionViewCell.m
//  tianjing
//
//  Created by 孙元侃 on 15/11/11.
//  Copyright © 2015年 lanwan. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.origin = CGPointZero;
    }
    return self;
}

#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end
