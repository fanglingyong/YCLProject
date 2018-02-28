//
//  AppDelegate.m
//  HJC
//
//  Created by zhifu360 on 2017/10/17.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "LoginViewController.h"
#import "MainViewController.h"
#import "ProcurementViewController.h"
#import "MessageCenterViewController.h"
#import "ShoppingCartViewController.h"
#import "MyCenterViewController.h"
#import "BaseApi.h"
#import "EncrtDecrt.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property(nonatomic,strong)UITabBarController *tabBarController;
@property(nonatomic)NSInteger lastSelect;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    NSLog(@"设备宽%f,设备高%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAgain) name:@"loginAgain" object:nil];
    [self jumpMain];
    
    return YES;
}

/**
 登陆视图 window
 */
-(void)jumpLogin{
    LoginViewController * login = [[LoginViewController alloc]init];
    BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:login];
    loginNav.navigationBarHidden = YES;
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}

/**
 主视图 window
 */
-(void)jumpMain{
    MainViewController *main = [[MainViewController alloc] init];
    [main.tabBarItem setImageInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    main.tabBarItem.image = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.title = @"首页";
    [main.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"#f5b741"]} forState:UIControlStateSelected];
    [main.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.0)];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:main];
    mainNav.navigationBarHidden = YES;
    
    
    ProcurementViewController *pro = [[ProcurementViewController alloc] init];
    [pro.tabBarItem setImageInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    pro.tabBarItem.image = [[UIImage imageNamed:@"purchase_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    pro.tabBarItem.selectedImage = [[UIImage imageNamed:@"purchase_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    pro.tabBarItem.title = @"采购";
    [pro.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"#f5b741"]} forState:UIControlStateSelected];
    [pro.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.0)];
    BaseNavigationController *proNav = [[BaseNavigationController alloc] initWithRootViewController:pro];
    proNav.navigationBarHidden = YES;
    
    ShoppingCartViewController *shop = [[ShoppingCartViewController alloc] init];
    [shop.tabBarItem setImageInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    shop.tabBarItem.title = @"购物车";
    shop.tabBarItem.image = [[UIImage imageNamed:@"shop_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shop.tabBarItem.selectedImage = [[UIImage imageNamed:@"shop_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [shop.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"#f5b741"]} forState:UIControlStateSelected];
    [shop.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.0)];
    BaseNavigationController *shopNav = [[BaseNavigationController alloc] initWithRootViewController:shop];
    shopNav.navigationBarHidden = YES;
    
    
    MessageCenterViewController *message = [[MessageCenterViewController alloc] init];
    [message.tabBarItem setImageInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [[UIImage imageNamed:@"message_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    message.tabBarItem.selectedImage = [[UIImage imageNamed:@"message_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [message.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"#f5b741"]} forState:UIControlStateSelected];
    [message.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.0)];
    BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:message];
    messageNav.navigationBarHidden = YES;
    
   
    MyCenterViewController *myCenter = [[MyCenterViewController alloc] init];
    [myCenter.tabBarItem setImageInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    myCenter.tabBarItem.title = @"个人中心";
    myCenter.tabBarItem.image = [[UIImage imageNamed:@"person_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myCenter.tabBarItem.selectedImage = [[UIImage imageNamed:@"person_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [myCenter.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorFromHexCode:@"#f5b741"]} forState:UIControlStateSelected];
    [myCenter.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.0)];
    BaseNavigationController *myCenterNav = [[BaseNavigationController alloc] initWithRootViewController:myCenter];
    myCenterNav.navigationBarHidden = YES;
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.delegate = self;
    tabbar.viewControllers = @[mainNav, proNav, shopNav, messageNav,myCenterNav];
    self.tabBarController = tabbar;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tabbar.tabBar.height)];
    bgView.backgroundColor = RGBCOLOR(16, 16, 16);
    tabbar.tabBar.opaque = YES;
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];

    if([model.P_LSM intValue] == 0){
        if(tabBarController.viewControllers[0] == viewController){
            return YES;
        }else if (tabBarController.viewControllers[1] == viewController){
            return YES;
        }else if (tabBarController.viewControllers[2] == viewController){
            [self loginAction];
            return NO;
        }else if (tabBarController.viewControllers[3] == viewController){
            [self loginAction];
            return NO;
        }else{
            return YES;
        }
    } else {
        if (tabBarController.viewControllers[3] == viewController){
            self.lastSelect = tabBarController.selectedIndex;
            if([self loadUserInfo:tabBarController viewController:viewController]){
                return YES;
            }else{
                return NO;
            }
        }else{
            return YES;
        }
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if(tabBarController.viewControllers[0] == viewController){
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        MainViewController *secvc = (MainViewController *)navigationctr.topViewController;
        
    }else if (tabBarController.viewControllers[1] == viewController){
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        ProcurementViewController *secvc = (ProcurementViewController *)navigationctr.topViewController;
        [secvc headRefresh];
    }else if (tabBarController.viewControllers[2] == viewController){
        UINavigationController *navigationctr = (UINavigationController *)viewController;
        ShoppingCartViewController *secvc = (ShoppingCartViewController *)navigationctr.topViewController;
        [secvc net_workforshopcar];
    }else if (tabBarController.viewControllers[3] == viewController){
//        UINavigationController *navigationctr = (UINavigationController *)viewController;
//        MessageCenterViewController *secvc = (MessageCenterViewController *)navigationctr.topViewController;
//        [secvc net_MessageList];
    }else{
//        UINavigationController *navigationctr = (UINavigationController *)viewController;
//        MyCenterViewController *secvc = (MyCenterViewController *)navigationctr.topViewController;
//        [secvc initClinic];
    }
}

-(void)loginAction{
    UserModel *model = [[UserModel alloc] init];
    model = [UserModel getUserModel];
    
    if([model.P_LSM intValue] == 0){
        LoginViewController *view = [LoginViewController instance];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
        nav.navigationBarHidden = YES;
        view.backBlock = ^{
            [self loginAgain];
        };
        
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"openLogin"];
    }
}

-(void)loginAgain{
    self.tabBarController.selectedIndex = 0;
}

-(BOOL)loadUserInfo:(UITabBarController *)tabBarController viewController:(UIViewController *)viewController{
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
