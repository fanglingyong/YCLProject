//
//  MyCenterHead.m
//  JieBa
//
//  Created by zhifu360 on 16/10/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "MyCenterHead.h"

@interface MyCenterHead()
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIButton *userImgBtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UIButton *changeBtn;

@end

@implementation MyCenterHead

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgImageView];
        [self userImgBtn];
        [self nameLabel];
        [self addressLabel];
        [self phoneLabel];
        [self changeBtn];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)bgImageView{
    if(!_bgImageView){
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgImageView.image = [GetImagePath getImagePath:@"myCenter_banner"];
        bgImageView.backgroundColor = NavColor;
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}

- (UIButton *)userImgBtn {
    if (!_userImgBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WidthXiShu(30), HeightXiShu(70), WidthXiShu(75), HeightXiShu(75))];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.layer.cornerRadius = btn.halfWidth;
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = RGBACOLOR(0, 0, 0, .3).CGColor;
        btn.layer.masksToBounds = YES;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [btn addTarget:self action:@selector(changeHeadAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _userImgBtn = btn;
    }
    return _userImgBtn;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(110), HeightXiShu(80), WidthXiShu(150), HeightXiShu(25))];
        nameLabel.text = @"奔走的大熊";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = HEITI(HeightXiShu(17));
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)addressLabel{
    if(!_addressLabel){
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(110), HeightXiShu(110), WidthXiShu(150), HeightXiShu(20))];
        addressLabel.textColor = [UIColor whiteColor];
        addressLabel.text = @"古荡社区诊所";
        addressLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:addressLabel];
        _addressLabel = addressLabel;
    }
    return _addressLabel;
}

-(UILabel *)phoneLabel{
    if(!_phoneLabel){
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(110), HeightXiShu(130), WidthXiShu(150), HeightXiShu(20))];
        phoneLabel.textColor = [UIColor whiteColor];
        phoneLabel.text = @"182-6883-44545";
        phoneLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:phoneLabel];
        _phoneLabel = phoneLabel;
    }
    return _phoneLabel;
}

-(UIButton *)changeBtn{
    if(!_changeBtn){
        UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        changeBtn.frame = CGRectMake(kScreenWidth - WidthXiShu(7)-WidthXiShu(53), HeightXiShu(75), WidthXiShu(53), HeightXiShu(20));
        changeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        changeBtn.layer.cornerRadius = HeightXiShu(5);
        changeBtn.layer.borderWidth = 1;
        changeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        changeBtn.layer.masksToBounds = YES;
        [changeBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [changeBtn setImage:[GetImagePath getImagePath:@"myCenter_ewm"] forState:UIControlStateNormal];
        changeBtn.titleLabel.font = HEITI(HeightXiShu(13));
        changeBtn.titleLabel.textColor = TitleColor;
        [changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeBtn];
        _changeBtn = changeBtn;
    }
    return _changeBtn;
}



#pragma mark - 事件

-(void)changeHeadAction{
    if([self.delegate respondsToSelector:@selector(changeHeadClick)]){
        [self.delegate changeHeadClick];
    }
}

-(void)changeBtnAction{
    if([self.delegate respondsToSelector:@selector(changeHeadClick)]){
        [self.delegate changeHeadClick];
    }
}


#pragma mark - setter

-(void)setAvatarUrl:(NSString *)avatarUrl{

}
@end
