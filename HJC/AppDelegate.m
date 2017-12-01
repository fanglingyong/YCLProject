//
//  AppDelegate.m
//  HJC
//
//  Created by zhifu360 on 2017/10/17.
//  Copyright © 2017年 EastChina. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "PasswordLoginViewController.h"
#import "MainViewController.h"
#import "MessageCenterViewController.h"
#import "ShoppingCartViewController.h"
#import "MyCenterViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property(nonatomic,strong)UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    [self jumpLogin];
//    [self jumpMain];
    
    return YES;
}

/**
 登陆视图 window
 */
-(void)jumpLogin{
    PasswordLoginViewController * login = [[PasswordLoginViewController alloc]init];
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
    [main.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    main.tabBarItem.image = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.title = @"首页";
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:main];
    mainNav.navigationBarHidden = YES;
    
    MessageCenterViewController *message = [[MessageCenterViewController alloc] init];
    [message.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [[UIImage imageNamed:@"message_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    message.tabBarItem.selectedImage = [[UIImage imageNamed:@"message_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:message];
    messageNav.navigationBarHidden = YES;
    
    ShoppingCartViewController *shop = [[ShoppingCartViewController alloc] init];
    [shop.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    shop.tabBarItem.title = @"购物车";
    shop.tabBarItem.image = [[UIImage imageNamed:@"shop_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shop.tabBarItem.selectedImage = [[UIImage imageNamed:@"shop_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *shopNav = [[BaseNavigationController alloc] initWithRootViewController:shop];
    shopNav.navigationBarHidden = YES;
    
    MyCenterViewController *myCenter = [[MyCenterViewController alloc] init];
    [myCenter.tabBarItem setImageInsets:UIEdgeInsetsMake(7.0, 0.0, -7.0, 0.0)];
    myCenter.tabBarItem.title = @"我的";
    myCenter.tabBarItem.image = [[UIImage imageNamed:@"persom_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myCenter.tabBarItem.selectedImage = [[UIImage imageNamed:@"person_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *myCenterNav = [[BaseNavigationController alloc] initWithRootViewController:myCenter];
    myCenterNav.navigationBarHidden = YES;
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.delegate = self;
    tabbar.viewControllers = @[mainNav,messageNav,shopNav,myCenterNav];
    self.tabBarController = tabbar;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tabbar.tabBar.height)];
    bgView.backgroundColor = RGBCOLOR(16, 16, 16);
    tabbar.tabBar.opaque = YES;
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
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
