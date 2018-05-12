//
//  ReceiveAddressCell.m
//  HJC
//
//  Created by zhifu360 on 2017/12/6.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "ReceiveAddressCell.h"

@interface ReceiveAddressCell()

@property (nonatomic, retain)UIView *bgView;
@property (nonatomic, retain)UILabel *nameLb;
@property (nonatomic, retain)UILabel *phoneLb;
@property (nonatomic, retain)UILabel *addressLb;

@property(nonatomic, strong)UIImageView *acquiescenceImg; //默认地址
@property(nonatomic, strong)UIImageView *lineView; //默认地址

@property (nonatomic, retain)UIButton *acquiescenceBtn; // 设为默认
@property (nonatomic, retain)UIButton *editBtn;     // 编辑
@property (nonatomic, retain)UIButton *deleteBtn; //删除


@end

@implementation ReceiveAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self bgView];
        [self nameLb];
        [self phoneLb];
        [self addressLb];
        
        [self acquiescenceImg];
        [self lineView];
        
        [self acquiescenceBtn];
        [self editBtn];
        [self deleteBtn];
    }
    return self;
}
#pragma mark - 页面元素

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(WidthXiShu(10), HeightXiShu(10), kScreenWidth - WidthXiShu(20), HeightXiShu(135))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = WidthXiShu(8);
        [self.contentView addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

- (UILabel *)nameLb{
    if(!_nameLb){
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(20), HeightXiShu(20), WidthXiShu(70), HeightXiShu(25))];
        nameLb.text = @"王小明";
        nameLb.font = HEITI(HeightXiShu(17));
        nameLb.textColor = BlackColor;
        [self.bgView addSubview:nameLb];
        _nameLb = nameLb;
    }
    return _nameLb;
}

- (UILabel *)phoneLb{
    if(!_phoneLb){
        UILabel *phoneLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(20), WidthXiShu(140), HeightXiShu(25))];
        phoneLb.text = @"1829925536";
        phoneLb.font = HEITI(HeightXiShu(16));
        phoneLb.textColor = BlackColor;
        [self.bgView addSubview:phoneLb];
        _phoneLb = phoneLb;
    }
    return _phoneLb;
}

- (UILabel *)addressLb{
    if(!_addressLb){
        UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(WidthXiShu(100), HeightXiShu(45), kScreenWidth - WidthXiShu(20) - WidthXiShu(100) - WidthXiShu(15), HeightXiShu(40))];
        addressLb.text = @"浙江省杭州市下城区延安路";
        addressLb.numberOfLines = 0;
        addressLb.font = HEITI(HeightXiShu(14));
        addressLb.textColor = TitleColor;
        [self.bgView addSubview:addressLb];
        _addressLb = addressLb;
    }
    return _addressLb;
}

- (UIImageView *)acquiescenceImg{
    if(!_acquiescenceImg){
        UIImageView *acquiescenceImg = [[UIImageView alloc] initWithFrame:CGRectMake(WidthXiShu(30), HeightXiShu(55), WidthXiShu(45), HeightXiShu(16))];
        acquiescenceImg.image = [GetImagePath getImagePath:@"acquiescenceAddress"];
        [self.bgView addSubview:acquiescenceImg];
        _acquiescenceImg = acquiescenceImg;
    }
    return _acquiescenceImg;
}

- (UIImageView *)lineView{
    if(!_lineView){
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(97), kScreenWidth -WidthXiShu(20), .5)];
        lineView.backgroundColor = AllLightGrayColor;
        [self.bgView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

- (UIButton *)acquiescenceBtn {
    if (!_acquiescenceBtn) {
        UIButton *acquiescenceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        acquiescenceBtn.frame = CGRectMake(WidthXiShu(18), HeightXiShu(98), WidthXiShu(70), HeightXiShu(35));
        [acquiescenceBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        acquiescenceBtn.backgroundColor = [UIColor whiteColor];
        [acquiescenceBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [acquiescenceBtn addTarget:self action:@selector(acquiescenceBtnPress) forControlEvents:UIControlEventTouchDown];
        acquiescenceBtn.titleLabel.font = HEITI(HeightXiShu(15));
        [self.bgView addSubview:acquiescenceBtn];
        _acquiescenceBtn = acquiescenceBtn;
        
    }
    return _acquiescenceBtn;
    
}
- (UIButton *)editBtn {
    if (!_editBtn) {
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(WidthXiShu(195), HeightXiShu(98), WidthXiShu(65), HeightXiShu(35));
        editBtn.imageEdgeInsets = UIEdgeInsetsMake(WidthXiShu(8), 0, WidthXiShu(8), WidthXiShu(47));
        editBtn.titleEdgeInsets = UIEdgeInsetsMake(WidthXiShu(8), WidthXiShu(4), WidthXiShu(8), WidthXiShu(6));
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.backgroundColor = [UIColor whiteColor];
        [editBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [editBtn setImage:[GetImagePath getImagePath:@"edit"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editBtnPress) forControlEvents:UIControlEventTouchDown];
        editBtn.titleLabel.font = HEITI(HeightXiShu(15));
        [self.bgView addSubview:editBtn];
        _editBtn = editBtn;
    }
    return _editBtn;
    
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(WidthXiShu(278), HeightXiShu(98), WidthXiShu(65), HeightXiShu(35));
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(WidthXiShu(8), 0, WidthXiShu(8), WidthXiShu(47));
        deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(WidthXiShu(8), WidthXiShu(4), WidthXiShu(8), WidthXiShu(6));
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [deleteBtn setImage:[GetImagePath getImagePath:@"edit"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnPress) forControlEvents:UIControlEventTouchDown];
        deleteBtn.titleLabel.font = HEITI(HeightXiShu(15));
        [self.bgView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
    
}


#pragma mark - setter

- (void)setModel:(ReceiveAddressModel *)model {
    _nameLb.text = model.POSTCODE;
    _phoneLb.text = model.LINK;
    _addressLb.text = model.ADDRESS;
}
#pragma mark - 事件

- (void)acquiescenceBtnPress {
    NSLog(@"设为默认");
}
- (void)editBtnPress {
    NSLog(@"编辑");
}

- (void)deleteBtnPress {
    NSLog(@"删除");
}

@end
