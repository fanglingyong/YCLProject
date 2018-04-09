//
//  AdPageControl.m
//  HJC
//
//  Created by 方灵勇 on 2018/4/9.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "AdPageControl.h"

@implementation AdPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor whiteColor];
        self.isValid = YES;
        [self addSubview:self.adPage];
        [self addSubview:self.logo];
        [self removiewForDely:5.];
    }
    return self;
}
#pragma mark - crate init
-(UIImageView*)adPage{
    if (!_adPage) {
        _adPage = [[UIImageView alloc] initWithFrame:self.bounds];
        _adPage.image = [UIImage imageNamed:@"syspic.jpg"];
        if (iPhoneX) {
            [_adPage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523261379975&di=de03a2f9b86a050a3033f93a019800f5&imgtype=0&src=http%3A%2F%2Ffile.mumayi.com%2Fforum%2F201408%2F21%2F140851pvg3vgqr6rqr3q54.jpg"] placeholderImage:[UIImage imageNamed:@"iphonex"]];
        }else{
            [_adPage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523855891&di=3ff3ae49d9a10ebbd8c582998927b6da&imgtype=jpg&er=1&src=http%3A%2F%2Fimgfs.oppo.cn%2Fuploads%2Fthread%2Fattachment%2F2017%2F01%2F03%2F14833739994785.png"] placeholderImage:[UIImage imageNamed:@"iphone6p"]];
        }
    }
    return _adPage;
}
-(UIButton*)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _cancelBtn;
}

-(void)removiewForDely:(NSTimeInterval)timer{
    [self bk_performAfterDelay:timer usingBlock:^(id  _Nonnull obj) {
        if (_isValid) {
            _isValid = NO;
            [self removeFromSuperview];
            //此处可以做个动画效果，暂时不做.
        }
    }];
}
@end
