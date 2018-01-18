//
//  AnnouncementViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/10.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "NavView.h"

@interface AnnouncementViewController ()
@property (nonatomic,strong) NavView *navView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) CGFloat scrol_height;
@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self netWorkForDataSource];
    // Do any additional setup after loading the view.
}
#pragma mark - Network
-(void)netWorkForDataSource{
    [self.view addSubview:self.scrollView];
    [self addTitle:@"积分换购商品活动开始了！"];
    [self createImageView:_scrol_height imageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515603393248&di=8f4911b5562a84e39fab35258dd7a47c&imgtype=0&src=http%3A%2F%2Fimg5.mtime.cn%2FCMS%2FNews%2F2017%2F05%2F10%2F080519.65791869_620X620.jpg"];
    [self createLable:_scrol_height str:@"轻轻敲醒沉睡的心灵 慢慢张开你的眼睛 \n看看忙碌的世界是否依然孤独地转个不停 \n春风不解风情 吹动少年的心 \n让昨日脸上的泪痕 随记忆风干了 \n抬头寻找天空的翅膀 侯鸟出现它的影迹 \n带来远处的饥荒无情的战火依然存在的消息 \n玉山白雪飘零 燃烧少年的心 \n使真情溶化成音符 倾诉遥远的祝福 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔 \n让我们的笑容充满着青春的骄傲 \n为明天献出虔诚的祈祷 \n谁能不顾自己的家园 抛开记忆中的童年 \n谁能忍心看那昨日的忧愁带走我们的笑容 \n青春不解红尘 胭脂沾染了灰 \n让久违不见的泪水 滋润了你的面容 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔 \n让我们的笑容充满着青春的骄傲 \n为明天献出虔诚的祈祷 \n轻轻敲醒沉睡的心灵 慢慢张开你的眼睛 \n看看忙碌的世界是否依然孤独地转个不停 \n日出唤醒清晨 大地光彩重生 \n让和风拂出的音响 谱成生命的乐章 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔 \n让我们的笑容充满着青春的骄傲 \n让我们期待着明天会更好 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔\n让我们的笑容充满着青春的骄傲 \n让我们期待着明天会更好 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔 \n让我们的笑容充满着青春的骄傲 \n让我们期待着明天会更好 \n唱出你的热情 伸出你的双手 让我拥抱着你的梦 \n让我拥有你真心的面孔"];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _scrol_height);
}
#pragma mark - nava
-(NavView *)navView{
    if(!_navView){
        NavView *navView = [NavView initNavView];
        navView.minY = kStateHeight;
        navView.backgroundColor = [UIColor whiteColor];
        navView.titleLabel.text = @"消息中心";
        navView.titleLabel.textColor = [UIColor blackColor];
        navView.titleLabel.font = [UIFont systemFontOfSize:18];
        navView.leftBtn.hidden = NO;
        navView.rightBtn.hidden = YES;
        [navView.leftBtn addTarget:self action:@selector(backLastControl_menthod) forControlEvents:UIControlEventTouchUpInside];
        _navView = navView;
    }
    return _navView;
}
-(void)backLastControl_menthod{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - other
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY)];
        
    }
    return _scrollView;
}
-(void)createImageView:(CGFloat)height_y imageUrl:(NSString*)imageUrl{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, height_y+10, kScreenWidth-20, kScreenWidth/2-10)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SmallPic,imageUrl]] placeholderImage:[UIImage imageNamed:@"default"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:imageView];
    _scrol_height+=kScreenWidth/2+10;
}
-(void)createLable:(CGFloat)height_y str:(NSString*)string{
    CGSize size = [AnimaDefaultUtil getAutoLayoutHeight:string Lsize:CGSizeMake(kScreenWidth-20, 9999) font:[UIFont systemFontOfSize:15]];
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, height_y, size.width, size.height)];
    content.numberOfLines = 0;
    content.font = [UIFont systemFontOfSize:15];
    content.text = string;
    [_scrollView addSubview:content];
    _scrol_height += size.height+10;
}
-(void)addTitle:(NSString*)title{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, kScreenWidth-20, 30)];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.textColor = [UIColor colorFromHexCode:@"#2B5CDC"];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = title;
    [_scrollView addSubview:titleLable];
    _scrol_height = 70.;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
