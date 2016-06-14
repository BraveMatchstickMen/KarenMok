//
//  AppDelegate.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/19.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AppDelegate.h"
#import "AboutViewController.h"
#import "PhotoViewController.h"
#import "HotMusicViewController.h"
#import "PlayViewController.h"
#import "AlbumViewController.h"

@interface AppDelegate ()

@property (nonatomic, retain) AFNetworkReachabilityManager *manager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    // about
//    AboutViewController *aboutVC = [[AboutViewController alloc] init];
//    UINavigationController *aboutNavi = [[UINavigationController alloc] initWithRootViewController:aboutVC];
//    aboutVC.tabBarItem.title = @"About";
    
    // photo
//    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
//    UINavigationController *photoNavi = [[UINavigationController alloc] initWithRootViewController:photoVC];
//    photoVC.tabBarItem.title = @"相册";
    
    // music
//    MusicViewController *musicVC = [[MusicViewController alloc] init];
//    UINavigationController *musicNavi = [[UINavigationController alloc] initWithRootViewController:musicVC];
//    musicVC.tabBarItem.title = @"音乐";
    
    // hot
//    HotMusicViewController *hotVC = [[HotMusicViewController alloc] init];
//    UINavigationController *hotNavi = [[UINavigationController alloc] initWithRootViewController:hotVC];
//    hotVC.tabBarItem.title = @"精选";
    
    
    // play
//    PlayViewController *playVC = [[PlayViewController alloc] init];
//    UINavigationController *playNavi = [[UINavigationController alloc] initWithRootViewController:playVC];
//    playVC.tabBarItem.title = @"play";
    
    
    // album
    AlbumViewController *albumVC = [[AlbumViewController alloc] init];
    UINavigationController *albumNavi = [[UINavigationController alloc] initWithRootViewController:albumVC];
    albumVC.navigationController.navigationBar.translucent = NO;
    
//    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
//    tabBarVC.viewControllers = [NSArray arrayWithObjects:aboutNavi, photoNavi, hotNavi, albumNavi, nil];
    
    self.window.rootViewController = albumNavi;
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
