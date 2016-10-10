//
//  AppDelegate.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "AppDelegate.h"
#import "Glf_GuideViewController.h"
#import "Glf_CourseViewController.h"
#import "Glf_TabBarViewController.h"
#import "Glf_RegisterAndLoginViewController.h"

@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 引导页
//    // 使用 NSUserDefaults 读取用户数据
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    
//    // 判断是否是第一次进入引导页
//    if (![userDef boolForKey:@"notFirst"]) {
//        // 如果是第一次进入引导页
//        _window.rootViewController = [[Glf_GuideViewController alloc] init];
//    } else {
//        // 否则直接进入引用
//        _window.rootViewController = [[Glf_CourseViewController alloc] init];
//    }
    
    // 直接去 course 模块
    self.window.rootViewController = [[Glf_TabBarViewController alloc] init];
    
    // 登录注册
//    Glf_RegisterAndLoginViewController *regAndLogVC = [[Glf_RegisterAndLoginViewController alloc] init];
//    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:regAndLogVC];
//    self.window.rootViewController = rootNC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
