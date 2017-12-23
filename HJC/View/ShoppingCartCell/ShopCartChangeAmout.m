//
//  ShopCartChangeAmout.m
//  HJC
//
//  Created by 方灵勇 on 2017/12/22.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ShopCartChangeAmout.h"

@implementation ShopCartChangeAmout

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.successBtn];
        [self addSubview:self.goosInfo];
        [self addSubview:self.numSubBtn];
        [self addSubview:self.amoutTf];
        [self addSubview:self.numAddBtn];
    }
    return self;
}

-(UILabel*)goosInfo{
    if (!_goosInfo) {
        _goosInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-60, 20)];
        _goosInfo.font = [UIFont systemFontOfSize:14];
        _goosInfo.text = @"这是神器的药水";
    }
    return _goosInfo;
}

-(UIButton*)successBtn{
    if (!_successBtn) {
        _successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _successBtn.frame = CGRectMake(self.frame.size.width-50, 0, 50, self.frame.size.height);
        _successBtn.backgroundColor = [UIColor redColor];
        [_successBtn setTitle:@"完成" forState:UIControlStateNormal];
        _successBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:500];
        [_successBtn addTarget:self action:@selector(successForChangeNum:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _successBtn;
}

-(UITextField*)amoutTf{
    if (!_amoutTf) {
        _amoutTf = [[UITextField alloc] initWithFrame:CGRectMake(32, 30, 76, 20)];
        _amoutTf.text = @"999999";
        _amoutTf.font = [UIFont systemFontOfSize:14];
        _amoutTf.clipsToBounds = YES;
        _amoutTf.layer.borderWidth = 1;
        _amoutTf.textAlignment = NSTextAlignmentCenter;
        _amoutTf.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return _amoutTf;
}

- (UIButton *)numSubBtn {
    if (!_numSubBtn) {
        UIButton *subtractionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subtractionBtn.layer.masksToBounds = YES;
        subtractionBtn.layer.cornerRadius = 4;
        subtractionBtn.layer.borderColor = TitleColor.CGColor;
        subtractionBtn.layer.borderWidth = .5;
        subtractionBtn.frame = CGRectMake(10, 30, 20, 20);
        [subtractionBtn addTarget:self action:@selector(subtractAction:) forControlEvents:UIControlEventTouchDown];
        [subtractionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [subtractionBtn setBackgroundImage:[GetImagePath getImagePath:@"reduce_S"] forState:UIControlStateNormal];
        _numSubBtn = subtractionBtn;
    }
    return _numSubBtn;
}

- (UIButton *)numAddBtn {
    if (!_numAddBtn) {
        UIButton *additionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        additionBtn.clipsToBounds = YES;
        additionBtn.layer.cornerRadius = 4;
        additionBtn.layer.borderColor = TitleColor.CGColor;
        additionBtn.layer.borderWidth = .5;
        additionBtn.frame = CGRectMake(110, 30, 20, 20);
        [additionBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchDown];
        [additionBtn setBackgroundImage:[GetImagePath getImagePath:@"add_S"] forState:UIControlStateNormal];
        [additionBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        _numAddBtn = additionBtn;
    }
    return _numAddBtn;
}
#pragma mark - action
-(void)successForChangeNum:(UIButton*)sender{
    _newCount = [_amoutTf.text integerValue];
    if (_newCount != _numCount) {
        //做了修改了
        self.block(_newCount);
    }
    [self removeFromSuperview];
}
-(void)subtractAction:(UIButton*)sender{
    _newCount = [_amoutTf.text integerValue];
    if (_newCount>1) {
        _newCount--;
        _amoutTf.text = [NSString stringWithFormat:@"%ld",_newCount];
    }
}
-(void)addAction:(UIButton*)sender{
    _newCount = [_amoutTf.text integerValue];
    if (_newCount<999999) {
        _newCount++;
        _amoutTf.text = [NSString stringWithFormat:@"%ld",_newCount];
    }
}
-(void)setGoodsInfo:(NSString *)info count:(NSInteger)count block:(ShopCartChangeAmoutBlock)compleBlock{
    _goosInfo.text = info;
    _numCount = count;
    _block = compleBlock;
    _amoutTf.text = [NSString stringWithFormat:@"%ld",count];
}

@end
