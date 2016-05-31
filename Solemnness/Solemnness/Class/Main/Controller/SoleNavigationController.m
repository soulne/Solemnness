//
//  SoleNavigationController.m
//  Solemnness
//
//  Created by 911 on 16/4/25.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleNavigationController.h"

@interface SoleNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SoleNavigationController

+ (void)initialize{
    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    self.interactivePopGestureRecognizer.enabled = NO;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        button.size = CGSizeMake(70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count != 1;
}


@end
