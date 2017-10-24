//
//  AppDelegate.m
//  HSUpdateAppDemo
//
//  Created by 侯帅 on 2017/5/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "AppDelegate.h"
#import "HSMainTableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[HSMainTableViewController alloc]initWithStyle:UITableViewStyleGrouped]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}





@end
