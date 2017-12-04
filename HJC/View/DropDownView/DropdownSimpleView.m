//
//  DropdownSimpleView.m
//  zhifu360
//
//  Created by zhifu on 4/14/15.
//  Copyright (c) 2015 rongzi. All rights reserved.
//

#import "DropdownSimpleView.h"

@implementation DropdownSimpleView
/**
 *  initWithFrame
 *
 *  @param frame frame description
 *
 *  @return return value description
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        rowHeight = HeightXiShu(50);
        
        _theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, self.containerView.frame.size.height - self.footerView.frame.size.height) style:UITableViewStylePlain];
        _theTableView.dataSource = self;
        _theTableView.delegate = self;
        _theTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _theTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.containerView addSubview:_theTableView];
    }
    return self;
}

/**
 *  重新设置内容的大小
 */
-(void) resetContentFrame{
    float height = self.dataArray.count * rowHeight;
    if (height > maxHeight - footerHeight) {
        height = maxHeight;
    }
    else{
        height += footerHeight;
    }
    
    self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, height);
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (_dataArray) {
        [self.theTableView reloadData];
    }
}

#pragma mark - UITableView Delegate
/**
 *  UITableView Delegate
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
/**
 *  UITableView Delegate
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}
/**
 *  UITableView Delegate
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kMsgCellID = @"InfosCellID";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:kMsgCellID];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMsgCellID];
        cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        cell1.textLabel.font = [UIFont systemFontOfSize: 15];
        cell1.textLabel.textColor = TitleColor;

    }
    
    UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeightXiShu(50), kScreenWidth, .5)];
    cutLine.backgroundColor = AllLightGrayColor;
    [cell1.contentView addSubview:cutLine];
    
    
    NSArray *array = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([array isKindOfClass:[NSArray class]]) {
        cell1.textLabel.text = [array objectAtIndex:1];
    }
    else{
        cell1.textLabel.text = (NSString *)array;
    }
    
    
    if (self.selectedIndex == indexPath.row) {
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        cell1.textLabel.textColor = TitleColor;
    }
    else{
        cell1.accessoryType = UITableViewCellAccessoryNone;
        cell1.textLabel.textColor = TitleColor;
    }
    
    return cell1;
}
/**
 *  UITableView Delegate
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowOfFilterView:)]) {
        [self.delegate didSelectRowOfFilterView:self];
    }
}
@end
