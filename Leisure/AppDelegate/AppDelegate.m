//
//  AppDelegate.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "GBLoginManager.h"

#import "AppDelegate.h"
#import "RootController.h"
#import "RootListBaseController.h"
//#import "RequestManager.h"
//#import <UMSocial.h>
//#import <UMSocialQQHandler.h>
//#import <UMSocialSnsService.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //一键配置
    [GBLoginManager AppDelegateConfigSSO];

    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    RootController *rootVc = [[RootController alloc] init];
    self.window.rootViewController = rootVc;
    
//    [UMSocialData setAppKey:@"56ea4d3f67e58ec5760015b6"];
    
//    RootListBaseController *a = [[RootListBaseController alloc]init];
//    self.window.rootViewController = a;
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    return YES;
}

/*
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // 如果你除了使用我们sdk之外还要处理另外的url，你可以把`handleOpenURL:wxApiDelegate:`的实现复制到你的代码里面，再添加你要处理的url。
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return  [UMSocialSnsService handleOpenURL:url];
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    return  [UMSocialSnsService handleOpenURL:url];
    
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
