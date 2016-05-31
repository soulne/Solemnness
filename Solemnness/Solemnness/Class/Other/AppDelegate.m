//
//  AppDelegate.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "AppDelegate.h"
#import "SoleTabBarViewController.h"
#import "SoleAdvertViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
//    self.window.rootViewController = [[SoleTabBarViewController alloc]init];
    
    self.window.rootViewController = [[SoleAdvertViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    

    
    return YES;
}


@end
