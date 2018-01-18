//
//  SelectStatusView.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/16.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "SelectStatusView.h"

#define FontSize 15

@interface SelectStatusView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UILabel *lable1;
@property (nonatomic,strong) UILabel *lable2;
@property (nonatomic,strong) UILabel *lable3;
@property (nonatomic,strong) UILabel *lable4;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,strong) UIImageView *line1;
@property (nonatomic,strong) UIImageView *line2;
@property (nonatomic,strong) UIImageView *line3;

@property (nonatomic,strong) UIView *selectView;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) CGRect sframe;
@property (nonatomic,strong) NSMutableArray *statusArr;//二维数组
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *tableArr;
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) UIView *didView;

@end

@implementation SelectStatusView

- (instancetype)initWithFrame:(CGRect)frame withSframe:(CGRect)sframe sonView:(UIView*)view withArr:(NSMutableArray*)selStatus
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sframe = sframe;
        self.selectIndex = 0;
        self.titleArr = @[@"全部分类",@"供应商",@"促销"];
        self.statusArr = [NSMutableArray arrayWithArray:selStatus];
        [self addSubview:self.lable1];
        [self addSubview:self.button1];
        [self addSubview:self.line1];
        [self addSubview:self.lable2];
        [self addSubview:self.button2];
        [self addSubview:self.line2];
        [self addSubview:self.lable3];
        [self addSubview:self.button3];
        [self.selectView addSubview:self.tableView];
        self.didView = view;
    }
    return self;
}
- (instancetype)initWithTimeFrame:(CGRect)frame withSframe:(CGRect)sframe sonView:(UIView*)view withArr:(NSMutableArray*)selStatus
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sframe = sframe;
        ;
        self.titleArr = @[@"状态",[NSString stringWithFormat:@"%@/01",[NSDate getNewDateStringWithDateFmt:@"yyyy/MM"]],[NSDate getNewDateStringWithDateFmt:@"yyyy/MM/dd"]];
        self.statusArr = [NSMutableArray arrayWithArray:selStatus];
        [self addSubview:self.lable1];
        [self addSubview:self.button1];
        [self addSubview:self.line1];
        
        [self addSubview:self.lable4];
        [self addSubview:self.lable2];
        _lable2.frame = CGRectMake(self.width/3+68, 6, 70, 30);
        [self addSubview:self.button2];
        [self addSubview:self.line3];// - 线
        [self addSubview:self.lable3];
        [self addSubview:self.button3];
        [self addSubview:self.line2]; //搜索功能键
        [self.selectView addSubview:self.tableView];
        [view addSubview:self.selectView];
    }
    return self;
}
#pragma mark - other
-(UIView*)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:_sframe];
        _selectView.hidden = YES;
        _selectView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.2];
    }
    return _selectView;
}
-(UIImageView*)line1{
    if (!_line1) {
        _line1 = [[UIImageView alloc] initWithFrame:CGRectMake(_lable1.maxX, self.height/2-10, 20, 20)];
        _line1.image = [UIImage imageNamed:@"down_arrow"];
    }
    return _line1;
}
-(UIImageView*)line2{
    if (!_line2) {
        _line2 = [[UIImageView alloc] initWithFrame:CGRectMake(_lable2.maxX, self.height/2-10, 20, 20)];
        _line2.image = [UIImage imageNamed:@"down_arrow"];
    }
    return _line2;
}
-(UILabel*)lable1{
    if (!_lable1) {
        _lable1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, self.width/3-36, 30)];
        _lable1.text = _titleArr[0];
        _lable4.font = [UIFont systemFontOfSize:FontSize];
    }
    return _lable1;
}
-(UILabel*)lable2{
    if (!_lable2) {
        _lable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.width/3+8, 6, self.width/3-36, 30)];
        _lable4.font = [UIFont systemFontOfSize:FontSize];
        _lable1.text = _titleArr[1];
    }
    return _lable2;
}
-(UILabel*)lable3{
    if (!_lable3) {
        _lable3 = [[UILabel alloc] initWithFrame:CGRectMake(self.width*2/3+8, 6, self.width/3-36, 30)];
        _lable4.font = [UIFont systemFontOfSize:FontSize];
        _lable1.text = _titleArr[2];
    }
    return _lable3;
}
-(UILabel*)lable4{
    if (!_lable4) {
        _lable4 = [[UILabel alloc] initWithFrame:CGRectMake(self.width/3, 6, 60, 30)];
        _lable4.text = @"订单时间";
        _lable4.font = [UIFont systemFontOfSize:FontSize];
    }
    return _lable4;
}
-(UIButton*)button1{
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = _lable1.frame;
        [_button1 addTarget:self action:@selector(showSelect1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}
-(UIButton*)button2{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = _lable2.frame;
        [_button2 addTarget:self action:@selector(showSelect2:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}
-(UIButton*)button3{
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.frame = _lable3.frame;
        [_button3 addTarget:self action:@selector(showSelect3:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}
#pragma mark - tableView
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.width, _statusArr.count*44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self calcCellHeight:indexPath];
}
-(CGFloat)calcCellHeight:(NSIndexPath*)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selectStatusView"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectStatusView"];
    }
    cell.textLabel.text = self.tableArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex == 0) {
        self.lable1.text = self.tableArr[indexPath.row];
    }else if (_selectIndex==1){
        self.lable2.text = self.tableArr[indexPath.row];
    }else if (_selectIndex==2){
        self.lable3.text = self.tableArr[indexPath.row];
    }
    _selectView.hidden = YES;
    [_selectView removeFromSuperview];
}
#pragma mark - action
-(void)showSelect1:(UIButton*)sender{
    self.selectIndex = 0;
    self.tableArr = [NSArray arrayWithArray:self.statusArr[0]];
    self.selectView.hidden = NO;
    [_tableView reloadData];
    [_didView addSubview:self.selectView];
}
-(void)showSelect2:(UIButton*)sender{
    self.selectIndex = 1;
    self.tableArr = [NSArray arrayWithArray:self.statusArr[2]];
    self.selectView.hidden = NO;
    [_tableView reloadData];
    [_didView addSubview:self.selectView];
}
-(void)showSelect3:(UIButton*)sender{
    self.selectIndex = 2;
    self.tableArr = [NSArray arrayWithArray:self.statusArr[3]];
    self.selectView.hidden = NO;
    [_tableView reloadData];
    [_didView addSubview:self.selectView];
}
@end
