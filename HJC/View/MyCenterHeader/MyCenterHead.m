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
@property(nonatomic,strong)UILabel *levelLabel;
@property(nonatomic,strong)UIButton *QRBtn;
@property(nonatomic,strong)UIView *messageView;
@property(nonatomic,strong)UILabel *numLabel;
@end

@implementation MyCenterHead

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self bgImageView];
        [self userImgBtn];
        [self nameLabel];
        [self levelLabel];
        [self messageView];
        [self QRBtn];
    }
    return self;
}

#pragma mark - 页面元素
-(UIImageView *)bgImageView{
    if(!_bgImageView){
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        bgImageView.image = [GetImagePath getImagePath:@"myCenter_banner"];
        [self addSubview:bgImageView];
        _bgImageView = bgImageView;
    }
    return _bgImageView;
}

- (UIButton *)userImgBtn {
    if (!_userImgBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(60), WidthXiShu(65), HeightXiShu(65))];
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
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(72), WidthXiShu(150), HeightXiShu(20))];
        nameLabel.text = @"";
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

-(UILabel *)levelLabel{
    if(!_levelLabel){
        UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(90), HeightXiShu(97), WidthXiShu(150), HeightXiShu(20))];
        levelLabel.textColor = [UIColor whiteColor];
        levelLabel.text = @"";
        levelLabel.font = HEITI(HeightXiShu(14));
        [self addSubview:levelLabel];
        _levelLabel = levelLabel;
    }
    return _levelLabel;
}

-(UIView *)messageView{
    if(!_messageView){
        UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-WidthXiShu(20)-WidthXiShu(30), HeightXiShu(30), WidthXiShu(30), HeightXiShu(30))];
        
        UIImageView *messageImage = [[UIImageView alloc] initWithImage:[GetImagePath getImagePath:@"myCenter_message"]];
        messageImage.center = CGPointMake(WidthXiShu(15), HeightXiShu(15));
        [messageView addSubview:messageImage];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, messageView.width, messageView.height);
        [btn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        [messageView addSubview:btn];
        
        [self addSubview:messageView];
        
        _messageView = messageView;
    }
    return _messageView;
}

-(UIButton *)QRBtn{
    if(!_QRBtn){
        UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        QRBtn.frame = CGRectMake(kScreenWidth-WidthXiShu(20)-WidthXiShu(25), HeightXiShu(84), WidthXiShu(25), HeightXiShu(23));
        [QRBtn setImage:[GetImagePath getImagePath:@"myCenter_ewm"] forState:UIControlStateNormal];
        [QRBtn addTarget:self action:@selector(QRCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:QRBtn];
        _QRBtn = QRBtn;
    }
    return _QRBtn;
}



#pragma mark - 事件
-(void)changeHeadAction{
    if([self.delegate respondsToSelector:@selector(changeHeadClick)]){
        [self.delegate changeHeadClick];
    }
}

-(void)messageAction{
    if([self.delegate respondsToSelector:@selector(messageClick)]){
        [self.delegate messageClick];
    }
}

-(void)QRCodeAction{
    if([self.delegate respondsToSelector:@selector(QRCoedeClick)]){
        [self.delegate QRCoedeClick];
    }
}

-(void)signAction{
    if([self.delegate respondsToSelector:@selector(signClick)]){
        [self.delegate signClick];
    }
}

-(void)activeAction{
    if([self.delegate respondsToSelector:@selector(activeClick)]){
        [self.delegate activeClick];
    }
}

#pragma mark - setter

-(void)setAvatarUrl:(NSString *)avatarUrl{

}
@end
