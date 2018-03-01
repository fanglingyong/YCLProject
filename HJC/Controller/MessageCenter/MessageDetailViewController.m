//
//  MessageDetailViewController.m
//  HJC
//
//  Created by 方灵勇 on 2018/1/19.
//  Copyright © 2018年 EastChina. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "NavView.h"

@interface MessageDetailViewController ()

@property (nonatomic,strong) NavView *navView;

@property (nonatomic,strong) UILabel *msgTitle;//标题
@property (nonatomic,strong) UILabel *msgAuthorTime;//作者 时间
@property (nonatomic,strong) UILabel *msgInfo;//消息内容
@property (nonatomic,strong) UIScrollView *msgScroll;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self statusBar];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.msgScroll];
    [self net_messageinfo];
    // Do any additional setup after loading the view.
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
#pragma mark - 元素
-(UIScrollView*)msgScroll{
    if (!_msgScroll) {
        _msgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navView.maxY, kScreenWidth, kScreenHeight-_navView.maxY)];
        [_msgScroll addSubview:self.msgTitle];
        [_msgScroll addSubview:self.msgAuthorTime];
        [_msgScroll addSubview:self.msgInfo];
    }
    return _msgScroll;
}
-(UILabel*)msgTitle{
    if (!_msgTitle) {
        _msgTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _msgScroll.width, 22)];
        
        _msgTitle.textAlignment = NSTextAlignmentCenter;
        _msgTitle.numberOfLines = 0;
        _msgTitle.textColor = [UIColor redColor];
    }
    return _msgTitle;
}
-(UILabel*)msgAuthorTime{
    if (!_msgAuthorTime) {
        _msgAuthorTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, _msgScroll.width, 20)];
        
        _msgAuthorTime.textAlignment = NSTextAlignmentRight;
        _msgAuthorTime.font = [UIFont systemFontOfSize:14];
        _msgAuthorTime.textColor = [UIColor blueColor];
    }
    return _msgAuthorTime;
}
-(UILabel*)msgInfo{
    if (!_msgInfo) {
        _msgInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, _msgScroll.width, 22)];
        
        _msgInfo.font = [UIFont systemFontOfSize:15];
        _msgInfo.numberOfLines = 0;
    }
    return _msgInfo;
}

-(void)updateMesssageInfo{
    /*  false data
    _msgTitle.text = @"江山如此多娇 引无数英雄尽折腰";
    _msgAuthorTime.text = @"公告 2018-01-19 21:57:11";
    NSString *content = @"   江山如此多娇 引无数英雄竞折腰 美人如此多娇 英雄连江山都不要 一颦一语如此温柔妖娇 再美的江山都比不上红颜一笑 像鸟一样捆绑 绑不住她年华 像繁华正盛开 挡不住她灿烂 少年英姿焕发 怎么想都是她 红尘反复来去 美人孤寂有谁问 大江东去浪淘尽千古风流人物 故垒西边人道是三国周郎赤壁 乱石崩云惊涛裂岸卷起千堆的雪 羽扇纶巾谈笑间强虏灰飞烟灭 江山如此多娇 引无数英雄竞折腰 美人如此多娇 英雄连江山都不要 一颦一语如此温柔妖娇 再美的江山都比不上红颜一笑 像鸟一样捆绑 绑不住她年华 像繁华正盛开 挡不住她灿烂 少年英姿焕发 怎么想都是她 红尘反复来去 美人孤寂有谁问 大江东去浪淘尽千古风流人物 故垒西边人道是三国周郎赤壁 乱石崩云惊涛裂岸卷起千堆的雪 羽扇纶巾谈笑间强虏灰飞烟灭 没有你爱不会有我 你已不在怎么偷活 一代一代美人像梦 梦醒之后只剩传说 江山如此多娇 引无数英雄竞折腰 美人如此多娇 英雄连江山都不要 一颦一语如此温柔妖娇 再美的江山都比不上红颜一笑 回眸一笑百媚生情 六宫粉黛颜色失去 春寒赐浴华清池洗 始是新承恩泽时期 云鬓花颜金步缓摇 芙蓉帐暖夜夜春宵 春宵苦短日阳高照 从此君王不早朝起 千古风流 都看今朝 把酒高歌 只需欢笑 谁还想明朝（多少豪杰） 只为红颜呀（将江山忘掉） 四面楚歌啊（江山哪比得上红颜花娇） 都能笑傲 九重城开烟尘升起 千乘万骑西南行军 六军不发无奈何矣 宛转峨嵋马前离去 君王掩面救不得矣 天长地久有时尽期 此恨绵绵可有绝期 你美啊美啊我退啊退啊（美人如此多娇）";
    */
    _msgTitle.text = _msgModel.MessageTitle;
    _msgAuthorTime.text = [NSString stringWithFormat:@"%@ %@",_msgModel.MessageTypeName,_msgModel.MessDate];
    _msgInfo.text = _msgModel.Messagecontent;
    CGFloat height = [AnimaDefaultUtil getAutoLayoutHeight:_msgModel.Messagecontent Lsize:CGSizeMake(kScreenWidth-16, 99999) font:[UIFont systemFontOfSize:15]].height;
    _msgInfo.frame = CGRectMake(8, 55, _msgScroll.width-16, height);
    _msgInfo.text = _msgModel.Messagecontent;
    _msgScroll.contentSize = CGSizeMake(kScreenWidth, _msgInfo.maxY+30);
}
-(void)net_messageinfo{
    [self updateMesssageInfo];
    [self net_didread];
    /******  if add more type message than play it。
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:[NSString stringWithFormat:@"%@,",_msgModel.MessAgeId] forKey:@"Parastr"];
    [pargrams setObject:@",15,1" forKey:@"WebPara"];
    [BaseApi getMenthodWithUrl:GetMessageInfo block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            
        }else{
            
        }
    } dic:pargrams noNetWork:nil];
     */
}
#pragma mark - read
-(void)net_didread{
    NSMutableDictionary *pargrams = [NSMutableDictionary dictionary];
    [pargrams setObject:[UserModel getUserModel].P_LSM forKey:@"UserID"];
    [pargrams setObject:_msgModel.MessAgeId forKey:@"MESSAGEID"];
    [pargrams setObject:@"1" forKey:@"OPCODE"];
    [BaseApi getMenthodWithUrl:GetDealMessage block:^(NSDictionary *dict, NSError *error) {
        if (dict) {
            
        }else{
            
        }
    } dic:pargrams noNetWork:nil];
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
