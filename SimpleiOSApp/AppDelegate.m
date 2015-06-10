//
//  AppDelegate.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/5/31.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "AppDelegate.h"

#import "SimpleNetworkEngineSingleton.h"
#import "LoginNetRequestBean.h"
#import "LoginNetRespondBean.h"

#import "AppInit.h"

#import "FavorListNetRequestBean.h"
#import "FavorListNetRespondBean.h"

#import "GlobalDataCacheForMemorySingleton.h"

@implementation AppDelegate

- (void)testLogin {
  LoginNetRequestBean *netRequestBean = [[LoginNetRequestBean alloc] initWithUsername:@"3252475@qq.com" password:@"123456Hh"];
  id<INetRequestHandle> netRequestHandle = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestBean isUseCache:NO beginBlock:^{
    
  } successedBlock:^(LoginNetRespondBean *respondDomainBean) {
    NSLog(@"%@", [respondDomainBean description]);
    [[GlobalDataCacheForMemorySingleton sharedInstance] noteSignInSuccessfulInfoWithLatestLoginNetRespondBean:respondDomainBean usernameForLastSuccessfulLogon:@"3252475@qq.com" passwordForLastSuccessfulLogon:@"123456Hh"];
    [self testFavorList];
  } failedBlock:^(ErrorBean *error) {
    
  } endBlock:^{
    
  }];
}
- (void)testFavorList {
  FavorListNetRequestBean *netRequestBean = [[FavorListNetRequestBean alloc] initWithIsShowPay:YES isShowSupplier:YES];
  id<INetRequestHandle> netRequestHandle = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestBean isUseCache:NO beginBlock:^{
    
  } successedBlock:^(FavorListNetRespondBean *respondDomainBean) {
    NSLog(@"%@", [respondDomainBean description]);
    
  } failedBlock:^(ErrorBean *error) {
    
  } endBlock:^{
    
  }];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  // TODO:初始化app, 一定要首先调用, 且只调用一次
  [AppInit initApp];
 
  
  // Override point for customization after application launch.
  [self.window makeKeyAndVisible];
  
  
  [self testLogin];
  
 
  
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
