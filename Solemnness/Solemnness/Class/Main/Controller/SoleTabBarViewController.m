//
//  SoleTabBarViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTabBarViewController.h"
#import "SoleNavigationController.h"
#import "SoleMeViewController.h"
#import "SoleNewViewController.h"
#import "SoleFriendViewController.h"
#import "SoleEssenceViewController.h"
#import "SoleTabBar.h"

@interface SoleTabBarViewController ()

@end

@implementation SoleTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSDictionary *attr = @{
                                NSForegroundColorAttributeName:[UIColor grayColor]
                                };
    NSDictionary *selectedAttr = @{
                                NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                   };

    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    [self setupVC:[[SoleEssenceViewController alloc]init] title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    
    [self setupVC:[[SoleNewViewController alloc]init] title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    [self setupVC:[[SoleFriendViewController alloc]init] title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SoleMeStroyBoard" bundle:nil];
    SoleMeViewController *meVC = [sb instantiateInitialViewController];
    
    [self setupVC:meVC title:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    
    [self setValue:[[SoleTabBar alloc]init] forKey:@"tabBar"];
    
    [[UITabBar appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    
}

- (void)setupVC:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    
    
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    vc.tabBarItem.title = title;
    
    SoleNavigationController *navVc = [[SoleNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navVc];
    
    
}




@end
